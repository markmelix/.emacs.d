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
(custom-set-variables '(solarized-use-variable-pitch nil)
 					  '(solarized-scale-org-headlines nil))

;; Doom themes
(straight-use-package 'doom-themes)
(load-theme 'doom-vibrant t)

;; Apply Emacs theme to the rest of Linux, using magic
(straight-use-package 'theme-magic)
(require 'theme-magic)
(theme-magic-export-theme-mode)
