;;;; Dired configuration

;;; Subtrees
(straight-use-package 'dired-subtree)
(keymap-set dired-mode-map "C-;" 'dired-subtree-toggle)
(keymap-set dired-mode-map "M-u" 'dired-up-directory)

;; Filter dired output
(straight-use-package 'dired-filter)

;; Open files differently from dired
(straight-use-package 'dired-open)
