;;;; Docker support

(use-package docker
  :straight t
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :straight t)

(use-package dockerfile-mode
  :straight t
  :mode "Dockerfile")
