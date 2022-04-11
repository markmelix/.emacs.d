;;;; Locale settings

;; Set default input method after all get initialized
(add-hook 'after-init-hook (lambda ()
							 (custom-set-variables '(default-input-method "russian-computer"))))

;;; Platform specific locale configuration
(cond ((eq system-type 'gnu/linux)
	   ;; GNU/Linux-specific locale configuration
	   (set-language-environment   "utf-8")
	   (set-default-coding-systems 'utf-8)
	   (set-terminal-coding-system 'utf-8)
	   (set-keyboard-coding-system 'utf-8)
	   (prefer-coding-system       'utf-8))
	  ((eq system-type 'windows-nt)
	   ;; Windows-specific locale configuration
	   ))

