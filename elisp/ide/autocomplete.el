;;;; Autocompletion features

;; Snippets implementation
(straight-use-package 'yasnippet)
(require 'yasnippet)
(yas-global-mode 1)

;; Snippets pack for yasnippet
(straight-use-package 'yasnippet-snippets)

;; Autocompletion or snippet choose while typing code
(straight-use-package 'company)

(custom-set-variables '(company-minimum-prefix-length 1))
(custom-set-variables '(company-idle-delay 0.0))

(require 'company)

(add-hook 'prog-mode-hook 'company-mode)

(keymap-set company-active-map "C-n" 'next-line)
(keymap-set company-active-map "C-p" 'previous-line)
(keymap-set company-active-map "M-n" 'company-select-next)
(keymap-set company-active-map "M-p" 'company-select-previous)
(keymap-set company-active-map "M-<" 'company-select-first)
(keymap-set company-active-map "M->" 'company-select-last)

;; Icons and docs in completion
;(straight-use-package 'company-box)
;(require 'company-box)
;(add-hook 'company-mode-hook 'company-box-mode)

;;; Better sorting for company completion suggestions
(straight-use-package 'company-prescient)
(company-prescient-mode 1)
(prescient-persist-mode)
