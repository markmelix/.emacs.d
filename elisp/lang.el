;;;; Different languages support

;;; CMake support
(straight-use-package 'cmake-mode)

;;; Docker support
(straight-use-package 'docker)
(straight-use-package 'dockerfile-mode)
(straight-use-package 'docker-compose-mode)
(keymap-global-set "C-c d" 'docker)

;;; Fish shell language support
(straight-use-package 'fish-mode)

;;; Python language support
(straight-use-package 'python-mode)

;;; Rust language support
(straight-use-package 'rustic)

;;; Toml support
(straight-use-package 'toml-mode)
