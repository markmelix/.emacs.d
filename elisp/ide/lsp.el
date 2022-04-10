;;;; Lanuage Server Protocol

(straight-use-package 'lsp-mode)
(require 'lsp)

(setq lsp-rust-analyzer-cargo-watch-command "clippy"
	  lsp-rust-analyzer-completion-postfix-enable nil
 	  lsp-keymap-prefix "C-c l"
 	  lsp-use-plists t
	  lsp-idle-delay 0.5
	  lsp-modeline-diagnostics-scope: :file
	  lsp-diagnostics-provider :none
 	  rustic-lsp-client 'lsp-mode
 	  rustic-lsp-server 'rust-analyzer)

(keymap-set lsp-mode-map "C-c l" lsp-command-map)
(keymap-set lsp-command-map "s" 'lsp-treemacs-symbols)

(lsp-enable-which-key-integration t)

(cl-defgeneric lsp-clients-extract-signature-on-hover (contents _server-id)
  "Extract a representative line from CONTENTS, to show in the echo area."
  (nth 1 (s-split "\n\n" (lsp--render-element contents))))


