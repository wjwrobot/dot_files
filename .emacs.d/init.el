;;              PACKAGE MANAGER
;; https://github.com/jwiegley/use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;------------------------------------------------------------ 
;;------------------------------------------------------------ 
;;              UI
(custom-set-faces
 '(default ((t (:family "Hack Nerd Font" :foundry "SRC" :slant normal :weight normal :height 188 :width normal)))))
(custom-set-variables
 '(blink-cursor-mode nil)
 '(package-selected-packages (quote (atom-one-dark-theme dash))))

(tool-bar-mode -1)
;;(menu-bar-mode -1)
(toggle-scroll-bar -1)
(global-display-line-numbers-mode)
;;------------------------------------------------------------ 
;;              PROXY
(setq url-proxy-services
   '(;;("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "localhost:8118")
     ("https" . "localhost:8118")))
;;------------------------------------------------------------ 
;;              THEME
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/atom-one-dark-theme-20190107.1621")
(load-theme 'atom-one-dark t)

;;------------------------------------------------------------ 
;;------------------------------------------------------------ 
;;              EVIL
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
;------------------------------------------------------------ 
;;              LSP FOR PYTHON
;; https://github.com/emacs-lsp/lsp-python-ms
;; "https://vxlabs.com/2018/11/19/configuring-emacs-lsp-mode-and-microsofts-\
;; visual-studio-code-python-language-server/"
(use-package lsp-python-ms
  :ensure nil
  :hook (python-mode . lsp)
  :config

  ;; for dev build of language server
  (setq lsp-python-ms-dir
        (expand-file-name "~/build/python-language-server/output/bin/Release/")))
;;------------------------------------------------------------ 
;;              Projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))
;;------------------------------------------------------------ 
