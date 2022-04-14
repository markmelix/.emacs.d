;;;; Project management
(straight-use-package 'projectile)
(keymap-global-set "C-c p" 'projectile-command-map)
(projectile-mode 1)

;; Projectile with helm
(straight-use-package 'helm-projectile)
(helm-projectile-on)
