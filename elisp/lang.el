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

;;; Rust language support
;(straight-use-package 'rust-mode)
(straight-use-package 'rustic)
(require 'rustic)

;;; Toml support
(straight-use-package 'toml-mode)

;;; Markdown support
(straight-use-package 'markdown-mode)
