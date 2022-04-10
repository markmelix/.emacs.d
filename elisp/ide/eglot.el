;;;; Eglot (lsp client) configuration

(straight-use-package 'eglot)

(require 'eglot)

(setq rustic-lsp-client 'eglot)

(keymap-set eglot-mode-map "C-c r" 'eglot-rename)
(keymap-set eglot-mode-map "C-c h" 'eldoc)
(keymap-set eglot-mode-map "C-c C-a" 'eglot-code-actions)

;(setq eglot-ignored-server-capabilities '(:documentHighlightProvider))
