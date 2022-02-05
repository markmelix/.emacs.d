;;;; Autocompletion features

;; Snippets pack for yasnippet
(straight-use-package 'yasnippet-snippets)

;; Snippets implementation
(straight-use-package 'yasnippet)
(require 'yasnippet)

(add-hook 'prog-mode-hook 'yas/minor-mode)

(yas-reload-all)

;; Autocompletion or snippet choose while typing code
(straight-use-package 'company)
(require 'company)

(add-hook 'prog-mode-hook 'company-mode)

(keymap-set company-active-map "C-n" 'next-line)
(keymap-set company-active-map "C-p" 'previous-line)
(keymap-set company-active-map "M-n" 'company-select-next)
(keymap-set company-active-map "M-p" 'company-select-previous)
(keymap-set company-active-map "M-<" 'company-select-first)
(keymap-set company-active-map "M->" 'company-select-last)

(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.0)
