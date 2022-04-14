;;;; Lanuage Server Protocol

(straight-use-package 'lsp-mode)
(require 'lsp)

(setq
 lsp-eldoc-hook nil
 lsp-eldoc-render-all nil
 lsp-eldoc-enable-hover nil
 lsp-enable-symbol-highlighting nil
 lsp-idle-delay 0.6
 lsp-rust-analyzer-cargo-watch-command "clippy"
 lsp-rust-analyzer-server-display-inlay-hints t
 lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial"
 lsp-rust-analyzer-display-chaining-hints t
 lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil
 lsp-rust-analyzer-display-closure-return-type-hints t
 lsp-rust-analyzer-display-parameter-hints nil
 lsp-rust-analyzer-display-reborrow-hints nil
 )

(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\prod\\'")

(keymap-set lsp-mode-map "C-c l" lsp-command-map)
(keymap-set lsp-command-map "s" 'lsp-treemacs-symbols)

(lsp-enable-which-key-integration t)

(cl-defgeneric lsp-clients-extract-signature-on-hover (contents _server-id)
  "Extract a representative line from CONTENTS, to show in the echo area."
  (nth 1 (s-split "\n\n" (lsp--render-element contents))))
