;;;; Org roam (zettelkasten inside Emacs) settings

;; Zettelkasten inside Emacs
(use-package org-roam
  :straight t
  :demand
  :bind (("C-c n l" . org-roam-buffer-toggle)
		 ("C-c n f" . org-roam-node-find)
		 ("C-c n i" . org-roam-node-insert)
		 ("C-c n c" . org-roam-capture)
		 ("C-c n j" . org-roam-dailies-capture-today))
  :init
  (setq org-roam-completion-everywhere t)
  (setq org-roam-directory (file-truename "~/Braindump/Notes"))
  (setq org-roam-capture-templates
		'(("d" "default" plain "* Метаданные\n** Источники\n- %?\n** Ссылки\n- \n* Данные\n"
		   :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
							  "#+title: ${title}\n")
		   :unnarrowed t)))
  (setq org-roam-v2-ack t)
  :config
  (org-roam-db-autosync-mode))

;; Beautiful and customizable Zettelkasten notes graph
(use-package org-roam-ui
  :straight t
  :after org-roam
  :bind ("C-c n g" . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
		org-roam-ui-follow t
		org-roam-ui-update-on-save t
		org-roam-ui-open-on-start t
		org-roam-ui-browser-function 'browse-url-chromium))
