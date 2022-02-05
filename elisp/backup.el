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
