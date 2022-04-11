;;;; Emacs Shell configuration

(defun my/configure-eshell ()
  "Configure eshell."
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (custom-set-variables '(eshell-history-size 10000)
						'(eshell-buffer-maximum-lines 10000)
						'(eshell-hist-ignoredups t)
						'(eshell-scroll-to-bottom-on-input t)))

(add-hook 'eshell-first-time-mode 'my/configure-eshell)

(keymap-global-set "C-c C-o" 'eshell)
