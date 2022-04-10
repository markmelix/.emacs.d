;;;; Real-time error checking in some program modes

(straight-use-package 'flycheck)
(require 'flycheck)

(add-to-list 'flycheck-checkers 'rustic-clippy)

(straight-use-package 'flycheck-rust)
(with-eval-after-load 'rustic-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(add-hook 'rustic-mode-hook (lambda ()
							  (flycheck-mode)
							  (setq flycheck-checker 'rustic-clippy)))

(add-hook 'python-mode-hook (lambda ()
							  (flycheck-mode)
							  (setq flycheck-checker 'python-pylint)))
