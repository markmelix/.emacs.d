;;;; Project management
(straight-use-package 'projectile)
(keymap-global-set "C-c p" 'projectile-command-map)
(projectile-mode 1)

;;; Set default shell to bash instead of fish before switchong project.
;;; 
;;; Otherwise projectile raises error when it tries to open a project. See
;;; https://github.com/hlissner/doom-emacs/issues/1569
(add-hook 'projectile-before-switch-project-hook
		  '(lambda () (setq shell-file-name "/bin/bash")))

;; Projectile with helm
(straight-use-package 'helm-projectile)
(helm-projectile-on)
