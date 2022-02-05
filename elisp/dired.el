;;;; Dired configuration

;; Subtrees in dired
(use-package dired-subtree
  :straight t
  :bind (:map dired-mode-map
			  ("C-;" . dired-subtree-toggle)))

;; Filter dired output
(use-package dired-filter
  :straight t)

;; Open files differently from dired
(use-package dired-open
  :straight t)
