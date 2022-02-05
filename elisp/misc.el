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
(use-package which-key
  :straight t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; More convenient method for binding keys
(use-package general
  :straight t)
