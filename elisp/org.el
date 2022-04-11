;;;; Org mode settings

;; Org Mode
(straight-use-package 'org)
(require 'org)

(keymap-global-set "C-c L" 'org-store-link)
(keymap-global-set "C-c a" 'org-agenda)
(keymap-global-set "C-c c" 'org-capture)

(keymap-set org-mode-map "C-M-i" 'completion-at-point)

(custom-set-variables '(org-directory "~/Org")
					  '(org-hide-leading-stars nil)
					  '(org-adapt-indentation nil)
					  '(org-element-use-cache nil)
					  '(org-enforce-todo-dependencies t)
					  '(org-enforce-todo-checkbox-dependencies t)
					  '(org-startup-with-inline-images t)
					  '(org-image-actual-width nil)
					  '(org-hierarchical-todo-statistics nil)
					  '(org-checkbox-hierarchical-statistics nil)
					  '(org-latex-create-formula-image-program 'dvisvgm)
					  '(org-preview-latex-image-directory
						(expand-file-name "ltximg/" no-littering-var-directory))
					  '(org-latex-packages-alist
						'(("" "amsmath" t nil)
						  ("" "amsthm" t nil)
						  ("" "amssymb" t nil)
						  ("" "mathtext" t nil)
						  ("AUTO" "inputenc" t
						   ("pdflatex"))
						  ("T1,T2A" "fontenc" t
						   ("pdflatex"))
						  ("english,russian" "babel" t nil)
						  ("" "tikz" t nil)
						  ("" "pgfplots" t nil))))

(plist-put org-format-latex-options :scale 2)

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble
				"\\PreviewEnvironment{tikzpicture}" t))

;; Preview latex in org files automatically
(straight-use-package 'org-fragtog)
(add-hook 'org-mode-hook 'org-fragtog-mode)
(add-hook 'org-mode-hook (lambda ()
						   (let ((inhibit-message t))
							 (org-latex-preview '(16)))))
