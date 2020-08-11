#!/bin/bash

# ==============================
# A script for deploying v2ray on server.
# v2ray + tls + ws
# MIT license

# Adapt from https://github.com/V2RaySSR/Trojan

# You can get a UUID from here https://www.uuidgenerator.net/
# and a random string from here:
# https://www.random.org/strings/?num=1&len=7&digits=on&upperalpha=on&loweralpha=on&unique=off&format=html&rnd=new
## Configure files
# v2ray: /etc/v2ray/config.json
# nginx: /etc/nginx/conf.d/default.conf
# ==============================
#fonts color
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}


function install() {
   # CHECK=$(grep SELINUX= /etc/selinux/config | grep -v "#")
    real_addr=`ping ${domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
    local_addr=`curl ipv4.icanhazip.com`

    ## Install SSL certification
    # install certbot
    yellow "正在安装certbot"
    yum install -y python36 unzip && pip3 install certbot
    # stop firewall
    yellow "停止防火墙"
    systemctl stop firewalld && systemctl disable firewalld
    # get a SSL certification
    read -p "请输入用于申请SSL证书的邮箱：" mail
    yellow "正在申请SSL证书"
    certbot certonly --standalone --agree-tos -n -d ${domain} -d ${domain:4} -m ${mail}
    # auto update certification every two months
    echo "0 0 1 */2 * service nginx stop; certbot renew; service nginx start;" | crontab

    yellow "正在安装nginx与v2ray"
    ## Install nginx and v2ray
    yum install -y nginx
    yum install -y curl && bash -c "$(curl -L -s https://install.direct/go.sh)"
    # stop SELinux for allowing Nginx to transports dataflow to v2ray
    yellow "正在停止SELinux"
    setsebool -P httpd_can_network_connect 1 && setenforce 0

    # ====================
    yellow "（可选）开启BBR加速"
    ## Optional: BBR speedup
    bash -c 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf'
    bash -c 'echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf'
    sysctl -p
    # sysctl net.ipv4.tcp_congestion_control
}

function v2ray_config() {
    cat > /etc/v2ray/config.json <<-EOF
{
"inbound": {
    "protocol": "vmess",
    "listen": "127.0.0.1",
 "port": 8686,
 "settings": {"clients": [
        {"id": "$UUID"}
    ]},
 "streamSettings": {
 "network": "ws",
 "wsSettings": {"path": "/$rand_path"}
    }
},

"outbound": {"protocol": "freedom"}
}
EOF
}

function nginx_config() {
    cat > /etc/nginx/conf.d/default.conf <<-EOF
server {
    ### 1:
    server_name $domain;

    listen 80 reuseport fastopen=10;
    rewrite ^(.*) https://\$server_name\$1 permanent;
    if (\$request_method  !~ ^(POST|GET)\$) { return  501; }
    autoindex off;
    server_tokens off;
}

server {
    ### 2:
    ssl_certificate /etc/letsencrypt/live/$domain/fullchain.pem;

    ### 3:
    ssl_certificate_key /etc/letsencrypt/live/$domain/privkey.pem;

    ### 4:
    location /$rand_path
    {
        proxy_pass http://127.0.0.1:8686;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_requests 10000;
        keepalive_timeout 2h;
        proxy_buffering off;
    }

    listen 443 ssl reuseport fastopen=10;
    server_name \$server_name;
    charset utf-8;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_requests 10000;
    keepalive_timeout 2h;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    ssl_ecdh_curve secp384r1;
    ssl_prefer_server_ciphers off;

    ssl_session_cache shared:SSL:60m;
    ssl_session_timeout 1d;
    ssl_session_tickets off;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 10s;

    if (\$request_method  !~ ^(POST|GET)\$) { return 501; }
    add_header X-Frame-Options DENY;
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options nosniff;
    add_header Strict-Transport-Security max-age=31536000 always;
    autoindex off;
    server_tokens off;

    index index.html index.htm  index.php;
    location ~ .*\.(js|jpg|JPG|jpeg|JPEG|css|bmp|gif|GIF|png)\$ { access_log off; }
    location / { index index.html; }
}
EOF
}

function generate_client_file() {
    cat > /usr/share/nginx/html/config.json <<-EOF
{
"inbounds": [
    {
    "listen": "127.0.0.1",
    "port": 1080, // 监听端口
    "protocol": "socks", // 入口协议为 SOCKS 5
    "sniffing": {
        "enabled": true,
        "destOverride": [
        "http",
        "tls"
        ]
    },
    "settings": {
        "auth": "noauth" //socks的认证设置，noauth 代表不认证，由于 socks 通常在客户端使用，所以这里不认证
    }
    }
],
"outbounds": [
    {
    "protocol": "vmess", // 出口协议
    "settings": {
        "vnext": [
        {
            "address": "$domain", // 服务器地址，请修改为你自己的服务器 IP 或域名
            "port": 443, // 服务器端口
            "users": [
            {
                "id": "$UUID", // 用户 ID，必须与服务器端配置相同
                "alterId": 0, // 此处的值也应当与服务器相同
                "security": "auto"
            }
            ]
        }
        ]
    },
    "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlssettings": {
        "allowInsecure": true,
        "serverName": "$domain"
        },
        "wssettings": {
        "connectionReuse": true,
        "headers": {
            "Host": "$domain"
        },
        "path": "/$rand_path"
        }
    }
    }
]
}
EOF
}

function main() {
    green "======================="
    yellow "请输入绑定到本VPS的域名"
    green "======================="
    read domain
    UUID=$(uuidgen)
    rand_path=${UUID::7} # first 7 characters
    rand_config_file_path=${UUID:3:5}
    #====================
    install
    v2ray_config
    nginx_config
    #====================
    yellow "（可选）放置网站模板"
    ## Setting up website
    # get a website template and put it in /usr/share/nginx/html/
    wget https://github.com/wjwrobot/wjwrobot.github.io/archive/master.zip
    unzip master.zip
    mv wjwrobot.github.io-master/* /usr/share/nginx/html/
    rm master.zip && rm -d wjwrobot.github.io-master
    mkdir -p /usr/share/nginx/html/${rand_config_file_path}
    #====================
    generate_client_file
    #====================
    mv /usr/share/nginx/html/config.json /usr/share/nginx/html/${rand_config_file_path}/config.json

    yellow "启动v2ray与nginx服务"
    ## Start services
    service v2ray start
    service nginx start
    # test v2ray configure file
    #/usr/bin/v2ray/v2ray -test -config=/etc/v2ray/config.json

    yellow "(可选）设置防火墙,只允许ssh,http/s端口"
    ## Optional: Setting up firewall
    # install ufw
    yum install -y epel-release && yum install -y ufw
    # only enable necessary ports
    #ufw disable && ufw allow ssh && ufw allow http && ufw allow https && ufw enable

    green "客户端配置文件放置在http://${domain}/${rand_config_file_path}/config.json"
}

main

