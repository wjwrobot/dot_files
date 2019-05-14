;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-font (font-spec :family "Hack Nerd Font" :size 23))

(setq evil-move-cursor-back nil)
(setq url-proxy-services
   '(;;("https" . "localhost:8118")
     ("no_proxy" . "127.0.0.1")))
