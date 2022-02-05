;;;; Real-time error checking in some program modes

(straight-use-package 'flycheck)
(setq flycheck-check-syntax-automatically '(save mode-enabled))

;; Flycheck for Rust
(straight-use-package 'flycheck-rust)
(add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
