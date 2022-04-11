;;;; Eglot (lsp client) configuration

(straight-use-package 'eglot)

(require 'eglot)

(custom-set-variables '(rustic-lsp-client 'eglot))

(keymap-set eglot-mode-map "C-c r" 'eglot-rename)
(keymap-set eglot-mode-map "C-c h" 'eldoc)
(keymap-set eglot-mode-map "C-c C-a" 'eglot-code-actions)

;(custom-set-variables '(eglot-ignored-server-capabilities '(:documentHighlightProvider)))
