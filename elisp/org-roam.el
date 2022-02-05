;;;; Org roam (zettelkasten inside Emacs) settings

;; Zettelkasten inside Emacs
(straight-use-package 'org-roam)

(keymap-global-set "C-c n l" 'org-roam-buffer-toggle)
(keymap-global-set "C-c n f" 'org-roam-node-find)
(keymap-global-set "C-c n i" 'org-roam-node-insert)
(keymap-global-set "C-c n c" 'org-roam-capture)
(keymap-global-set "C-c n j" 'org-roam-dailies-capture-today)

(setq
 org-roam-completion-everywhere t
 org-roam-directory (file-truename "~/Braindump/Notes")
 org-roam-v2-ack t)

(setq org-roam-capture-templates
	  '(("d" "default" plain
		 "* Метаданные\n** Источники\n- %?\n** Ссылки\n- \n* Данные\n"
		 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
							"#+title: ${title}\n")
		 :unnarrowed t)))

(org-roam-db-autosync-mode)

;; Beautiful and customizable Zettelkasten notes graph
(straight-use-package 'org-roam-ui)
(keymap-global-set "C-c n g" org-roam-ui-mode)
(setq org-roam-ui-sync-theme t
	  org-roam-ui-follow t
	  org-roam-ui-update-on-save t
	  org-roam-ui-open-on-start t
	  org-roam-ui-browser-function 'browse-url-chromium)
