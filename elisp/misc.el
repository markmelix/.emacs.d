;;; Other miscellaneous settings

;; Url browsing
(setq
 ;; Browse urls with generic function
 browse-url-browser-function 'browse-url-generic
 
 ;; Change default browse-url program to chromium
 browse-url-generic-program "chromium"

 ;; Add extra arguments when browsing with chromium
 ;; Don't ask whether to restore crashed pages or not
 browse-url-chromium-arguments '("--disable-session-crashed-bubble")
 )

(setq-default
 ;; Add a newline automatically at the end of the file when it is about to be
 ;; saved
 require-final-newline t
 )

;;; What to do if the current emacs process is a daemon
(if (daemonp)
 	(add-hook 'after-make-frame-functions
 			  (lambda (frame)
 				(with-selected-frame frame (my/font-setup)))))

;; Display available keybindings in popup
(straight-use-package 'which-key)
(setq which-key-idle-delay 1)
(which-key-mode)
