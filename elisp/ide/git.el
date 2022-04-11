;;;; Git management

(straight-use-package 'magit)
(require 'magit)

(straight-use-package 'magit-todos)
(require 'magit-todos)
(add-hook 'magit-mode-hook 'magit-todos-mode)

;;; Step through historic versions of git controlled file
(straight-use-package 'git-timemachine)
(keymap-global-set "C-c g t" 'git-timemachine)

;;; Popup commit message at current line to know why this line was changed
(straight-use-package 'git-messenger)
(keymap-global-set "C-c g m" 'git-messenger:popup-message)
(custom-set-variables '(git-messenger:show-detail t)
					  '(git-messenger:use-magit-popup t))

;;; Open page at github/bitbucket from emacs buffers
(straight-use-package 'browse-at-remote)
(keymap-global-set "C-c g b" 'browse-at-remote)

;;; Highlight diffs in buffer
(straight-use-package 'diff-hl)
(global-diff-hl-mode)

;; Magit integration
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
