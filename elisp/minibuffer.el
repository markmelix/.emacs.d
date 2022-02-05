;;;; Minibuffer settings

;; Ask for y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Deactivate any input method when minibuffer is launched.
(add-hook 'minibuffer-setup-hook 'deactivate-input-method)

;;; Helm setup
;; Framework for incremental completions and narrowing selections
(use-package helm
  :demand t
  :straight t
  :bind (("M-x"     . helm-M-x)
		 ("C-x r b" . helm-filtered-bookmarks)
		 ("C-x C-f" . helm-find-files)
		 ("C-x b"   . helm-mini))
  :config
  (setq helm-M-x-fuzzy-match t
		helm-buffers-fuzzy-matching t
		helm-recentf-fuzzy-match t)
  (helm-mode 1))

;; Projectile with helm
(use-package helm-projectile
  :after (helm projectile)
  :straight t
  :config
  (helm-projectile-on))
