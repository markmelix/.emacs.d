;;;; Frame and UI settings

(defun my/font-setup ()
  "Setup frame font"
  (set-frame-font "Hack Nerd Font 10" t t))

(my/font-setup)

;; Disable tool bar
(call-if-fbound 'tool-bar-mode -1)

;; Disable menu bar
(call-if-fbound 'menu-bar-mode -1)

;; Disable scroll bar
(call-if-fbound 'scroll-bar-mode -1)

;; Solarized Theme
(use-package solarized-theme
  :straight t
  :init
  (setq solarized-use-variable-pitch nil
		solarized-scale-org-headlines nil)
  :config
  (load-theme 'solarized-dark t))

;; Convenient mode line
(use-package telephone-line
  :straight t
  :config
  (telephone-line-mode 1))
