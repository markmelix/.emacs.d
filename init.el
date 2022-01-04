;; Set gc-cons-threshold to extremely high value to speed up initial bootstrap
(let ((gc-cons-threshold 100000000))
  (defvar my/buffer-width 80)

  (defun call-if-fbound (function &rest args)
    "Call FUNCTION with optional ARGS, only if it is fbound.
Return t if it is fbound and called without error, and nil otherwise."
    (when (fboundp function)
      (apply function args)
      t))

  (defun my/open-config-file ()
	"Open the ~/.emacs.d/config.org file."
	(interactive)
	(find-file user-init-file))

  (defun my/font-installed-p (font-name)
	"Check if font with FONT-NAME is available."
	(if (find-font (font-spec :name font-name))
		t
	  nil))

  (defun my/font-setup ()
	"Setup frame font"
	(set-frame-font "Hack Nerd Font 12" nil t))

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

  ;; Personal data
  (setq user-full-name "Mark Meliksetyan"
		ser-mail-address "markmelix@gmail.com"

		;; Inhibit startup screens
		inhibit-startup-screen t
		inhibit-splash-screen  t

		;; Set initial scratch buffer message to nil
		initial-scratch-message nil

		;; Backup of a file the first time it is saved.
		make-backup-files t

		;; Don't clobber symlinks
		backup-by-copying t

		;; Version numbers for backup files
		version-control t

		;; Delete excess backup files silently
		delete-old-versions t

		;; Use system trash can
		delete-by-moving-to-trash t

		;; Oldest versions to keep when a new numbered backup is made
		kept-old-versions 6

		;; Newest versions to keep when a new numbered backup is made
		kept-new-versions 9

		;; Auto-save every buffer that visits a file
		auto-save-default t

		;; Number of seconds idle time before auto-save
		auto-save-timeout 20

		;; Number of keystrokes between auto-saves
		auto-save-interval 200

		;; Don't create lockfiles
		create-lockfiles nil

		;; Inhibit bell ringing
		ring-bell-function 'ignore

		;; Revert all non-file buffers
		global-auto-revert-non-file-buffers t

		;; Inhibit generating any messages while reverting buffers
		auto-revert-verbose nil

		;; Number of lines of margin at the top and bottom of a window
		scroll-margin 1
		
		;; Scroll up to this many lines, to bring point back on screen
		scroll-conservatively 0

		;; Scrolling speed is proportional to the wheel speed
		mouse-wheel-progressive-speed nil

		;; Mouse wheel should scroll the window that the mouse is over
		mouse-wheel-follow-mouse t

		;; Disable adjusting window-vscroll automatically
		auto-window-vscroll nil

		;; Set default input method to the Russian one
		default-input-method 'russian-computer

		;; Use word-wrapping for continuation lines
		word-wrap t)

  ;; How far to scroll windows upward
  (setq-default scroll-up-aggressively nil

				;; How far to scroll windows downward
				scroll-down-aggressively nil

				;; Column beyond which automatic line-wrapping should happen
				fill-column my/buffer-width

				;; Add a newline automatically at the end of the file when it is
				;; about to be saved
				require-final-newline t

				;; Width of a TAB character on display
				tab-width 4

				;; Use vertical bar cursor
				cursor-type 'bar)

  ;; Ask for y/n instead of yes/no
  (defalias 'yes-or-no-p 'y-or-n-p)

  ;; Disable tool bar
  (call-if-fbound 'tool-bar-mode -1)

  ;; Disable menu bar
  (call-if-fbound 'menu-bar-mode -1)

  ;; Disable scroll bar
  (call-if-fbound 'scroll-bar-mode -1)

  ;; Disable cursor blinking
  (call-if-fbound 'blink-cursor-mode -1)

  ;; Revert all buffers automatically
  (global-auto-revert-mode 1)

  ;; Display long line on the right part of the screen to determine when it's
  ;; time to break a line
  (global-display-fill-column-indicator-mode 1)

  ;; Display line numbers
  (global-display-line-numbers-mode 1)

  ;; Enable auto-fill mode in following modes
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'text-mode-hook 'auto-fill-mode)
  (add-hook 'fundamental-mode-hook 'auto-fill-mode)

  ;; Show matching parenthesis
  (show-paren-mode 1)

  ;; Close matching parenthesis
  (electric-pair-mode 1)

  ;; Bootstrap straight package manager
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

  ;; Install use-package
  (straight-use-package 'use-package)

  ;; Keep .emacs.d clean
  (use-package no-littering
	:straight t
	:custom
	(auto-save-file-name-transforms
	 `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
	(custom-file (no-littering-expand-etc-file-name "custom.el"))
	:config
	(unless (file-exists-p custom-file)
	  (write-region "" nil custom-file))
	(load custom-file))

  ;; Display available keybindings in popup
  (use-package which-key
	:straight t
	:init (which-key-mode)
	:diminish which-key-mode
	:config
	(setq which-key-idle-delay 1))

  ;; More convenient method for binding keys
  (use-package general
	:straight t)

  ;; Org Mode
  (use-package org
	:straight t
	:after no-littering
	:bind (("C-c L" . org-store-link)
		   ("C-c a" . org-agenda)
		   ("C-c c" . org-capture)
		   :map org-mode-map
		   ("C-M-i" . completion-at-point))
	:custom
	(org-directory "~/Org")
	(org-hide-leading-stars nil)
	(org-adapt-indentation nil)
	(org-element-use-cache nil)
	(org-enforce-todo-dependencies t)
	(org-enforce-todo-checkbox-dependencies t)
	(org-startup-with-inline-images t)
	(org-image-actual-width nil)
	(org-hierarchical-todo-statistics nil)
	(org-checkbox-hierarchical-statistics nil)
	:config
	(when (display-graphic-p)
	  (setq org-latex-create-formula-image-program 'imagemagick
			org-preview-latex-image-directory (expand-file-name "ltximg/" no-littering-var-directory)
			org-latex-packages-alist '(("" "amsmath" t nil)
									   ("" "amsthm" t nil)
									   ("" "amssymb" t nil)
									   ("" "mathtext" t nil)
									   ("AUTO" "inputenc" t
										("pdflatex"))
									   ("T1,T2A" "fontenc" t
										("pdflatex"))
									   ("english,russian" "babel" t nil)
									   ("" "tikz" t nil)
									   ("" "pgfplots" t nil))
			org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
	  (eval-after-load "preview"
		'(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))))

  ;; Zettelkasten inside Emacs
  (use-package org-roam
	:straight t
	:after org
	:bind (("C-c n l" . org-roam-buffer-toggle)
		   ("C-c n f" . org-roam-node-find)
		   ("C-c n i" . org-roam-node-insert)
		   ("C-c n c" . org-roam-capture)
		   ("C-c n j" . org-roam-dailies-capture-today))
	:init
	(setq org-roam-completion-everywhere t)
	(setq org-roam-directory (file-truename "~/Braindump/Notes"))
	(setq org-roam-capture-templates
		  '(("d" "default" plain "* Метаданные\n** Источники\n   - %?\n** Ссылки\n   - \n* Данные\n"
			 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
								"#+title: ${title}\n")
			 :unnarrowed t)))
	(setq org-roam-v2-ack t)
	:config
	(org-roam-db-autosync-mode))

  ;; Beautiful and customizable Zettelkasten notes graph
  (use-package org-roam-ui
	:straight
	(:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
	:after org-roam
	:bind ("C-c n g" . org-roam-ui-mode)
	:config
	(setq org-roam-ui-sync-theme t
		  org-roam-ui-follow t
		  org-roam-ui-update-on-save t
		  org-roam-ui-open-on-start t))

  ;; Language Server Protocol
  (use-package lsp-mode
	:straight t
	:commands (lsp lsp-deferred)
	:hook lsp-ui-mode
	:custom
	(lsp-rust-analyzer-cargo-watch-command "clippy")
	(lsp-pylsp-plugins-pydocstyle-enabled nil)
	(lsp-signature-auto-activate nil)
	(lsp-keymap-prefix "C-c l")
	:config
	(global-eldoc-mode -1)
	(lsp-enable-which-key-integration t))

  ;; Extended lsp ui features
  (use-package lsp-ui
	:disabled
	:if (display-graphic-p)
	:straight t
	:commands lsp-ui-mode
	:custom
	(lsp-ui-doc-enable nil))

  ;; Real-time error checking in some program modes
  (use-package flycheck
	:hook (prog-mode . flycheck-mode)
	:straight t
	:config
	(setq flycheck-check-syntax-automatically '(save mode-enabled)))

  ;; Flycheck for Rust
  (use-package flycheck-rust
	:straight t
	:config
	(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

  ;; Snippets pack for yasnippet
  (use-package yasnippet-snippets
	:straight t)

  ;; Snippets implementation
  (use-package yasnippet
	:after yasnippet-snippets
	:straight t
	:hook ((prog-mode . yas/minor-mode)
		   (text-mode . yas/minor-mode))
	:config
	(yas-reload-all))

  ;; Autocompletion or snippet choose while typing code
  (use-package company
	:after (lsp-mode yasnippet)
	:straight t
	:hook ((lsp-mode . company-mode)
		   (prog-mode . company-mode))
	:bind (:map company-active-map
				("C-n" . next-line)
				("C-p" . previous-line)
				("M-n" . company-select-next)
				("M-p" . company-select-previous)
				("M-<" . company-select-first)
				("M->" . company-select-last))
	:custom
	(company-minimum-prefix-length 1)
	(company-idle-delay 0.0))

  ;; Better company look
  (use-package company-box
	:disabled
	:straight t
	:hook (company-mode . company-box-mode))

  ;; Debugging features
  (use-package dap-mode
	:straight t
	:hook (python-mode . dap-mode)
	:custom
	(lsp-enable-dap-auto-configure nil)
	(dap-default-terminal-kind "external") ; may be external/integrated
	(dap-external-terminal '("alacritty" "-t" "{display}" "-e" "sh" "-c" "{command}"))
	:config
	(dap-mode 1)
	(dap-ui-mode 1)
	(dap-tooltip-mode 0)
	(tooltip-mode 0)
	(dap-ui-controls-mode 1)

	;; Set up Node debugging
	(require 'dap-node)
	(dap-node-setup) ;; Automatically installs Node debug adapter if needed
	(general-define-key
	 :keymaps 'lsp-mode-map
	 :prefix lsp-keymap-prefix
	 "d" '(dap-hydra t :wk "debugger")))

  ;; Rust language support
  (use-package rustic
	:straight t)

  ;; Python language support
  (use-package python-mode
	:straight t
	:hook (python-mode . lsp-deferred)
	:custom
	(dap-python-executable "python")
	(dap-python-debugger 'debugpy)
	:config
	(require 'dap-python)
	(dap-register-debug-template
	 "Python :: Debug"
	 (list :type "python"
		   :console "externalTerminal"
		   :args ""
		   :cwd nil
		   :program nil
		   :request "launch"
		   :name "Python :: Debug")))

  ;; Python enviroments managing
  (use-package pyvenv
	:straight t
	:hook (python-mode . pyenv-mode))

  ;; CMake support
  (use-package cmake-mode
	:straight t)

  ;; Fish shell support
  (use-package fish-mode
	:straight t)

  ;; Highlight indent guides
  (use-package highlight-indent-guides
	:straight t
	:custom (highlight-indent-guides-method 'character)
	:hook ((prog-mode . highlight-indent-guides-mode)
		   (org-mode . highlight-indent-guides-mode)
		   (html-mode-hook . highlight-indent-guides-mode)))

  ;; Convenient mode line
  (use-package telephone-line
	:straight t
	:config
	(telephone-line-mode 1))

  ;; Project management
  (use-package projectile
	:demand t
	:straight t
	:bind-keymap ("C-c p" . projectile-command-map)
	:config
	(projectile-mode 1))

  ;; Git management
  (use-package magit
	:demand t
	:straight t)

  ;; Framework for incremental completions and narrowing selections
  (use-package helm
	:demand t
	:straight t
	:custom (helm-M-x-fuzzy-match t)
	:bind ("M-x"     . helm-M-x)
	("C-x r b" . helm-filtered-bookmarks)
	("C-x C-f" . helm-find-files)
	:config
	(helm-mode 1))

  ;; The silver searcher with helm interface
  (use-package helm-ag
	:after helm
	:straight t
	:custom
	(helm-ag-base-command "rg --color never"))

  ;; Projectile with helm
  (use-package helm-projectile
	:after (helm projectile)
	:straight t
	:config
	(helm-projectile-on))

  ;; Subtrees in dired
  (use-package dired-subtree
	:straight t
	:bind (:map dired-mode-map
				("C-;" . dired-subtree-toggle)))

  ;; Filter dired output
  (use-package dired-filter
	:straight t)

  ;; Open files differently from dired
  (use-package dired-open
	:straight t)

  ;; Preview latex in org files automatically
  (use-package org-fragtog
	:if (display-graphic-p)
	:after org
	:straight t
	:hook ((org-mode . org-fragtog-mode)
		   (org-mode . (lambda () (org-latex-preview '(16))))))

  ;; Solarized Theme
  (use-package solarized-theme
	:if (display-graphic-p)
	:straight t
	:init
	(setq solarized-use-variable-pitch nil
		  solarized-scale-org-headlines nil)
	:config
	(load-theme 'solarized-dark t))

  (defun my/frame-setup ()
	(my/font-setup)
	(setq solarized-use-variable-pitch nil
		  solarized-scale-org-headlines nil)
	(load-theme 'solarized-dark t))

  (if (daemonp)
	  (add-hook 'after-make-frame-functions
				(lambda (frame)
				  (with-selected-frame frame
					(my/font-setup)
					(my/frame-setup))))
	(my/frame-setup))

  (cond ((eq system-type 'gnu/linux)
		 ;; GNU/Linux-specific configurations

		 (setq exec-path (append exec-path '("~/.local/bin")))

		 (set-language-environment   "utf-8")
		 (set-default-coding-systems 'utf-8)
		 (set-terminal-coding-system 'utf-8)
		 (set-keyboard-coding-system 'utf-8)
		 (prefer-coding-system       'utf-8)

		 (use-package vterm
		   :straight t))
		((eq system-type 'windows-nt)
		 ;; Windows-specific configurations
		 ))
  (cond ((display-graphic-p)
		 ;; Graphical configurations
		 (my/font-setup))
		(t
		 ;; Console-specific configurations
		 )))
