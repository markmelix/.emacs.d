;;; Startup settings

(custom-set-variables
 ;; Set gc-cons-threshold to high number to handle a lot of garbage
 '(gc-cons-threshold 100000000)

 ;; Increase the amount of data which Emacs reads from the process
 '(read-process-output-max (* 1024 1024))

 ;; Inhibit startup screens
 '(inhibit-startup-screen t)
 '(inhibit-splash-screen  t)

 ;; Set initial scratch buffer message to nil
 '(initial-scratch-message nil)

 ;; Inhibit bell ringing
 '(ring-bell-function 'ignore)
 )

(defun display-startup-echo-area-message ())

;;; Package management
;; Bootstrap straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
	   (expand-file-name "straight/repos/straight.el/bootstrap.el"
						 user-emacs-directory))
	  (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
	(with-current-buffer
		(url-retrieve-synchronously
		 (concat "https://raw.githubusercontent.com/raxod502/straight.el"
				 "/develop/install.el")
		 'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; Keep .emacs.d clean
(straight-use-package 'no-littering)
(custom-set-variables '(auto-save-file-name-transforms
						`((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
					  '(custom-file (no-littering-expand-etc-file-name "custom.el")))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

;;; Path setup
(when (eq system-type "gnu/linux")
  (custom-set-variables '(exec-path (append exec-path '("~/.local/bin")))))
