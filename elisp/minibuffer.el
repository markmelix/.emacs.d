;;;; Minibuffer settings

;; Ask for y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Deactivate any input method when minibuffer is launched.
(add-hook 'minibuffer-setup-hook 'deactivate-input-method)

;;; Helm setup
;; Framework for incremental completions and narrowing selections
(straight-use-package 'helm)

(keymap-global-set "M-x" 'helm-M-x)
(keymap-global-set "C-x r b" 'helm-filtered-bookmarks)
(keymap-global-set "C-x C-f" 'helm-find-files)
(keymap-global-set "C-x b" 'helm-mini)

(custom-set-variables '(helm-M-x-fuzzy-match t)
					  '(helm-buffers-fuzzy-matching t)
					  '(helm-recentf-fuzzy-match t))

(helm-mode 1)
