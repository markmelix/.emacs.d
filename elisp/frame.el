;;;; Frame and UI settings

(defun my/font-setup ()
  "Setup fonts"
  (set-frame-font "Hack Nerd Font 10" t t)

  ;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
  (set-fontset-font t 'symbol "Apple Color Emoji")
  (set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
  (set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
  (set-fontset-font t 'symbol "Symbola" nil 'append))

(my/font-setup)

;; Disable tool bar
(call-if-fbound 'tool-bar-mode -1)

;; Disable menu bar
(call-if-fbound 'menu-bar-mode -1)

;; Disable scroll bar
(call-if-fbound 'scroll-bar-mode -1)

;; Solarized Theme
(straight-use-package 'solarized-theme)
(setq solarized-use-variable-pitch nil
	  solarized-scale-org-headlines nil)
(load-theme 'solarized-dark t)

;; Convenient mode line
(straight-use-package 'telephone-line)
(telephone-line-mode 1)
