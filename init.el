;;; Who am I
(setq user-full-name "Mark Meliksetyan")
(setq user-mail-address "markmelix@gmail.com")

;;; Own variables
(defvar --buffer-length 80)

;;; Own functions
(defun --open-init-file ()
  "Open the user init file."
  (interactive)
  (find-file user-init-file))

(defun --font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (if (find-font (font-spec :name font-name))
      t
    nil))

;;; Own modes
(define-minor-mode sensitive-mode
  "Disable all Emacs file backup features."
  :init-value nil
  :lighter " Sensitive"
  :keymap nil
  ;; Check if the mode is enabled and if yes, inhibit backups for the current
  ;; buffer by setting buffer-local variable backup-inhibit to true and
  ;; disabling auto-save mode if it is enabled. If mode is not enabled,
  ;; enable auto-save mode and disable backups inhibit by killing local
  ;; variable.
  (if (symbol-value sensitive-mode)
      (progn
	(make-local-variable 'backup-inhibited)
	(setq backup-inhibited t)
	(when auto-save-default
	  (auto-save-mode -1)))
    (unless auto-save-default
      (auto-save-mode 1))
    (kill-local-variable 'backup-inhibited)))

;;; Own keybindings
(global-set-key (kbd "C-c i") '--open-init-file)
(global-set-key "\C-c$" 'toggle-truncate-lines)

;;; File backup

      ;; Backup of a file the first time it is saved.
(setq make-backup-files         t

      ;; Don't clobber symlinks
      backup-by-copying         t

      ;; Version numbers for backup files
      version-control           t

      ;; Delete excess backup files silently
      delete-old-versions       t

      ;; Use system trash can
      delete-by-moving-to-trash t

      ;; Oldest versions to keep when a new numbered backup is made
      kept-old-versions         6

      ;; Newest versions to keep when a new numbered backup is made
      kept-new-versions         9

      ;; Auto-save every buffer that visits a file
      auto-save-default         t

      ;; Number of seconds idle time before auto-save
      auto-save-timeout         20

      ;; Number of keystrokes between auto-saves
      auto-save-interval        200)

;;; Frame appearance

(tool-bar-mode     -1) ; hide tool bar
(menu-bar-mode     -1) ; hide menu bar (can be accessed using F10 key)
(scroll-bar-mode   -1) ; hide scroll bar
(blink-cursor-mode -1) ; disable cursor blinking

;; Display fill column indicator at every 79 column
;; (we should specify 79 instead of 80, because Emacs counts columns starting
;;  from zero)
(setq-default display-fill-column-indicator-column 79)
(global-display-fill-column-indicator-mode 1)

;; Set frame font to the Hack Nerd one
;; (https://github.com/ryanoasis/nerd-fonts)
(set-frame-font "Hack Nerd Font 12" nil t)

;; Inhibit startup screen
(setq inhibit-startup-screen t
      inhibit-splash-screen  t)

;;; Emacs server settings
(require 'server)

;; Start emacs server if not already started
(unless (server-running-p)
  (server-start))

;;; Buffer settings

;; Display line numbers only when edit programs
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Smooth scrolling
(setq scroll-step           1
      scroll-margin         10
      scroll-conservatively 10000
      auto-window-scroll    nil)

;; Don't ring when do something wrong
(setq ring-bell-function 'ignore)

;; Automatically end each file with new line
(setq mode-require-final-newline t)

;;; Buffer indentation settings

;; Don't indent with tabs
(setq indent-tabs-mode nil)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Erase more spaces at once instead of erasing one space at time
(setq backward-delete-char-untabify-method 'hungry)

;; Inhibit electric indent
(setq-default electric-indent-inhibit t)

;; Highlight any matching parenthesis
(show-paren-mode 1)

;; Automatically close parethesis and quots
(electric-pair-mode 1)

;; Wrap by words instead of characters
(setq word-wrap t)

;;; Encoding settings

;; Set default encoding system to utf-8
(set-language-environment   "utf-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system       'utf-8)

;;; Minibuffer settings

;; Make 'yes or no' messages like y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Package management

;; Bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
			 user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 (concat "https://raw.githubusercontent.com/raxod502/straight.el"
		 "/develop/install.el")
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package - syntax sugar for better package management
(straight-use-package 'use-package)

(use-package solarized-theme
  :if (display-graphic-p)
  :straight t
  :config
  (load-theme 'solarized-dark t))

(use-package no-littering
  :straight t
  :custom
  (auto-save-file-name-transforms
   `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (custom-file (no-littering-expand-etc-file-name "custom.el")))

(use-package sublimity
  :demand t
  :straight t
  :custom
  (sublimity-attractive-centering-width (+ --buffer-length 5))
  :config
  (require 'sublimity-attractive)
  (sublimity-mode 1))

(use-package lsp-mode
  :straight t
  :commands lsp
  :hook lsp-ui-mode
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy"))

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable nil))

(use-package company
  :straight t
  :bind (:map company-active-map
	      ("C-n" . company-select-next)
	      ("C-p" . company-select-previous)
	      ("M-<" . company-select-first)
	      ("M->" . company-select-last)))

(use-package yasnippet-snippets
  :straight t)

(use-package yasnippet
  :after yasnippet-snippets
  :straight t
  :hook ((prog-mode . yas/minor-mode)
	 (text-mode . yas/minor-mode))
  :config
  (yas-reload-all))

(use-package flycheck
  :straight t)

(use-package rustic
  :straight t)

(use-package highlight-indent-guides
  :straight t
  :custom (highlight-indent-guides-method 'character)
  :hook (prog-mode . highlight-indent-guides-mode))

(use-package telephone-line
  :straight t
  :config
  (telephone-line-mode 1))

(use-package undo-tree
  :straight t
  :config
  (global-undo-tree-mode 1))

(use-package key-chord
  :straight t
  :custom
  (key-chord-keys-delay 0.5)
  :config
  (key-chord-mode 1))

(use-package helm
  :demand t
  :straight t
  :custom (helm-M-x-fuzzy-match t)
  :bind ("M-x"     . helm-M-x)
	("C-x r b" . helm-filtered-bookmarks)
	("C-x C-f" . helm-find-files)
  :config
  (helm-mode 1))

(use-package projectile
  :straight t
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-mode 1))

(use-package helm-projectile
  :after (helm projectile)
  :straight t
  :config
  (helm-projectile-on))

(use-package helm-ag
  :after helm
  :straight t)

(use-package neotree
  :straight t
  :bind ("C-c b" . neotree-toggle)
  :config
  (if (display-graphic-p)
      (progn (use-package all-the-icons
	       :straight t)
	     (unless (--font-installed-p "all-the-icons")
	       (all-the-icons-install-fonts t))
	     (setq neo-theme 'icons))
    (setq neo-theme 'arrow)))

(use-package dired-subtree
  :straight t)

(use-package dired-filter
  :straight t)

(use-package dired-open
  :straight t)

(use-package evil
  :demand t
  :after (undo-tree key-chord)
  :straight t
  :custom (evil-search-module       'evil-search)
	  (evil-undo-system         'undo-tree)
	  (evil-want-keybinding     nil)
	  (evil-vsplit-window-right t)
	  (evil-want-C-u-scroll     t)
  :hook (evil-local-mode-hook . turn-undo-tree-mode)
  :bind (:map evil-replace-state-map
	      ("C-c" . evil-normal-state)
	 :map evil-visual-state-map
	      ("C-c" . evil-normal-state)
	 :map evil-operator-state-map
	      ("C-c" . evil-normal-state))
  :config
  (evil-mode 1)

  (add-hook 'emacs-lisp-mode-hook
	    (function (lambda ()
			(setq evil-shift-width 2))))
  (require 'key-chord)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-define evil-insert-state-map "kk" 'evil-normal-state)

  (use-package evil-collection
    :straight t
    :custom (evil-collection-setup-minibuffer t)
	    (evil-collection-want-find-usages-bindings nil)
    :config
    (evil-collection-init))

  (use-package evil-lion
    :straight t
    :bind (:map evil-normal-state-map
		("g l " . evil-lion-left)
		("g L " . evil-lion-right)
	   :map evil-visual-state-map
		("g l " . evil-lion-left)
		("g L " . evil-lion-right)))

  (use-package evil-commentary
    :straight t
    :bind (:map evil-normal-state-map
		("gc" . evil-commentary)))

  (use-package evil-goggles
    :straight t
    :config
    (evil-goggles-use-diff-faces)
    (evil-goggles-mode 1))

  (use-package evil-surround
      :straight t
      :commands (evil-surround-edit
		 evil-Surround-edit
		 evil-surround-region
		 evil-Surround-region)
      :init
      (evil-define-key 'operator global-map "s"  'evil-surround-edit)
      (evil-define-key 'operator global-map "S"  'evil-Surround-edit)
      (evil-define-key 'visual   global-map "S"  'evil-surround-region)
      (evil-define-key 'visual   global-map "gS" 'evil-Surround-region))

  (use-package evil-mc
    :straight t
    :config
    (evil-define-key* '(normal visual) global-map
      (kbd "gr") evil-mc-cursors-map
      (kbd "C-M-<mouse-1>") 'evil-mc-toggle-cursor-on-click
      (kbd "gr M-n") 'evil-mc-make-and-goto-next-cursor
      (kbd "gr M-p") 'evil-mc-make-and-goto-prev-cursor
      (kbd "gr C-n") 'evil-mc-make-and-goto-next-match
      (kbd "gr C-t") 'evil-mc-skip-and-goto-next-match
      (kbd "gr C-p") 'evil-mc-make-and-goto-prev-match)
    (global-evil-mc-mode 1)))
