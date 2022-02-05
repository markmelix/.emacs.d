;;;; Own modes initializating

(define-minor-mode sensitive-mode
  "Disable all Emacs file backup features."
  :init-value nil
  :lighter " Sensitive"
  :keymap nil
  ;; Check if the mode is enabled and if yes, inhibit backups for the current
  ;; buffer by setting buffer-local variable backup-inhibit to true and
  ;; disabling auto-save mode if it is enabled. If mode is not enabled,
  ;; enable auto-save mode and disable backups inhibit by killing local
  ;; variable.
  (if (symbol-value sensitive-mode)
	  (progn
		(make-local-variable 'backup-inhibited)
		(setq backup-inhibited t)
		(when auto-save-default
		  (auto-save-mode -1)))
	(unless auto-save-default
	  (auto-save-mode 1))
	(kill-local-variable 'backup-inhibited)))
