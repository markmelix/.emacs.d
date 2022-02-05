;;; File backup configuration

(setq
 ;; Backup of a file the first time it is saved.
 make-backup-files t

 ;; Don't clobber symlinks
 backup-by-copying t

 ;; Version numbers for backup files
 version-control t

 ;; Delete excess backup files silently
 delete-old-versions t

 ;; Use system trash can
 delete-by-moving-to-trash t

 ;; Oldest versions to keep when a new numbered backup is made
 kept-old-versions 6

 ;; Newest versions to keep when a new numbered backup is made
 kept-new-versions 9

 ;; Auto-save every buffer that visits a file
 auto-save-default t

 ;; Number of seconds idle time before auto-save
 auto-save-timeout 20

 ;; Number of keystrokes between auto-saves
 auto-save-interval 200

 ;; Don't create lockfiles
 create-lockfiles nil
 )

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
