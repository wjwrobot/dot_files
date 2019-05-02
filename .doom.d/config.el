;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-font (font-spec :family "Hack Nerd Font" :size 21))
;; (custom-set-faces
;;  '(default ((t (:family "Hack Nerd Font" :foundry "SRC" :slant normal :weight normal :height 193 :width normal)))))

;; (set-irc-server! "irc.freenode.net"
;;  `(:tls t
;;    :nick ""
;;    :port 6667
;;    :sasl-username ""
;;    :sasl-password ""
;;    :channels ("#irssi")))

(setq evil-move-cursor-back nil)

(def-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-message-project-root-warning t)
  :hook (cc-mode . lsp))

(put 'narrow-to-region 'disabled nil)
