;;;; Docker support

(straight-use-package 'docker)
(keymap-global-set "C-c d" 'docker)

(straight-use-package 'dockerfile-mode)
(straight-use-package 'docker-compose-mode)
