;;;; Lanuage Server Protocol

(straight-use-package 'lsp-mode)
(require 'lsp)

(add-hook 'pyton-mode-hook 'lsp-deferred)
(add-hook 'rustic-mode-hook 'lsp-deferred)

(setq lsp-rust-analyzer-cargo-watch-command "clippy"
	  lsp-pylsp-plugins-pydocstyle-enabled nil
	  lsp-signature-auto-activate nil
	  lsp-keymap-prefix "C-c l"
	  lsp-idle-delay 0.1
	  lsp-use-plists t
	  lsp-log-io nil)

(global-eldoc-mode -1)
(lsp-enable-which-key-integration t)

;; Extended lsp ui features
(straight-use-package 'lsp-ui)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(keymap-set lsp-ui-mode-map "M-j" 'lsp-ui-imenu)
