(defvar my/buffer-width 80)

(defun call-if-fbound (function &rest args)
  "Call FUNCTION with optional ARGS, only if it is fbound.
Return t if it is fbound and called without error, and nil otherwise."
  (when (fboundp function)
    (apply function args)
    t))

(defun my/open-config-file ()
  "Open the init.el file."
  (interactive)
  (find-file user-init-file))

(defun my/open-i3-config-file ()
  "Open ~/.config/i3/config file."
  (interactive)
  (find-file "~/.config/i3/config"))

(defun my/open-fish-config-file ()
  "Open ~/.config/fish/config.fish file."
  (interactive)
  (find-file "~/.config/fish/config.fish"))

(defun my/font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (if (find-font (font-spec :name font-name))
	  t
	nil))

(defun my/configure-eshell ()
  "Eshell configurations"
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size 10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(defun my/font-setup ()
  "Setup frame font"
  (set-frame-font "Hack Nerd Font 10" t t))

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

	  ;; Browse urls with generic function
	  browse-url-browser-function 'browse-url-generic
	  
	  ;; Change default browse-url program to chromium
      browse-url-generic-program "chromium"

	  ;; Add extra arguments when browsing with chromium
	  ;; Don't ask whether to restore crashed pages or not
	  browse-url-chromium-arguments '("--disable-session-crashed-bubble")
	  
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

	  ;; Set gc-cons-threshold to high number to handle a lot of garbage
	  gc-cons-threshold 100000000

	  ;; Increase the amount of data which Emacs reads from the process
	  read-process-output-max (* 1024 1024))

;; How far to scroll windows upward
(setq-default scroll-up-aggressively 0.01

			  ;; How far to scroll windows downward
			  scroll-down-aggressively 0.01

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
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'fish-mode-hook 'display-line-numbers-mode)

;; Enable auto-fill mode in following modes
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'fundamental-mode-hook 'auto-fill-mode)

;; Deactivate any input method when minibuffer is launched.
(add-hook 'minibuffer-setup-hook 'deactivate-input-method)

;; Set default input method after all get initialized
(add-hook 'after-init-hook (lambda ()
							 (setq default-input-method "russian-computer")))

;; Show matching parenthesis
(show-paren-mode 1)

;; Close matching parenthesis
(electric-pair-mode 1)

;; Turn on word wrap
(global-visual-line-mode 1)

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

;; Convenient mode line
(use-package telephone-line
  :straight t
  :config
  (telephone-line-mode 1))

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
  :demand
  :after no-littering
  :bind (("C-c L" . org-store-link)
		 ("C-c a" . org-agenda)
		 ("C-c c" . org-capture)
		 :map org-mode-map
		 ("C-M-i" . completion-at-point))
  :config
  (setq org-directory "~/Org"
		org-hide-leading-stars nil
		org-adapt-indentation nil
		org-element-use-cache nil
		org-enforce-todo-dependencies t
		org-enforce-todo-checkbox-dependencies t
		org-startup-with-inline-images t
		org-image-actual-width nil
		org-hierarchical-todo-statistics nil
		org-checkbox-hierarchical-statistics nil
		org-latex-create-formula-image-program 'dvisvgm
		org-preview-latex-image-directory
		(expand-file-name "ltximg/" no-littering-var-directory)
		org-latex-packages-alist
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
		  ("" "pgfplots" t nil)))
  (plist-put org-format-latex-options :scale 2)
  (eval-after-load "preview"
	'(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)))

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

;; Language Server Protocol
(use-package lsp-mode
  :straight t
  :hook (((python-mode rustic-mode) . lsp-deferred)
		 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
		lsp-pylsp-plugins-pydocstyle-enabled nil
		lsp-signature-auto-activate nil
		lsp-keymap-prefix "C-c l"
		lsp-idle-delay 0.1
		lsp-use-plists t
		lsp-log-io nil)
  (global-eldoc-mode -1)
  (lsp-enable-which-key-integration t))

;; Extended lsp ui features
(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-ui-mode-map
				 ("M-j" . lsp-ui-imenu)))

;; Debugging features
(use-package dap-mode
  :disabled
  :straight t
  :hook (python-mode rustic-mode)
  :config
  (setq lsp-enable-dap-auto-configure nil
		dap-default-terminal-kind "external"
		dap-external-terminal '("alacritty" "-t" "{display}" "-e" "sh" "-c" "{command}")
		dap-python-executable "python"
		dap-python-debugger 'debugpy)
  
  (require 'dap-python)
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)

  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb"
         :request "launch"
         :name "LLDB::Run"
		 :gdbpath "rust-lldb"
         :target nil
         :cwd nil))
  
  (dap-register-debug-template
   "Python :: Debug"
   (list :type "python"
		 :console "externalTerminal"
		 :args ""
		 :cwd nil
		 :program nil
		 :request "launch"
		 :name "Python :: Debug"))

  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed
  (general-define-key
   :keymaps 'lsp-mode-map
   :prefix lsp-keymap-prefix
   "d" '(dap-hydra t :wk "debugger"))

  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 0)
  (tooltip-mode 0)
  (dap-ui-controls-mode 1))

;; Real-time error checking in some program modes
(use-package flycheck
  :straight t
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

;; Flycheck for Rust
(use-package flycheck-rust
  :after rustic
  :straight t
  :hook (flycheck-mode . flycheck-rust-setup)
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Snippets pack for yasnippet
(use-package yasnippet-snippets
  :straight t)

;; Snippets implementation
(use-package yasnippet
  :after yasnippet-snippets
  :straight t
  :hook (prog-mode . yas/minor-mode)
  :config
  (yas-reload-all))

;; Autocompletion or snippet choose while typing code
(use-package company
  :straight t
  :hook (prog-mode . company-mode)
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

;; Rust language support
(use-package rustic
  :straight t)

;; Python language support
(use-package python-mode
  :straight t)

;; CMake support
(use-package cmake-mode
  :straight t)

;; Fish shell support
(use-package fish-mode
  :straight t)

(use-package docker
  :straight t
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :straight t)

(use-package dockerfile-mode
  :straight t
  :mode "Dockerfile")

;; Highlight indent guides
(use-package highlight-indent-guides
  :straight t
  :custom (highlight-indent-guides-method 'character)
  :hook ((prog-mode org-mode html-mode-hook) . highlight-indent-guides-mode))

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

;; Emacs shell and terminal emulator
(use-package eshell
  :bind ("C-C C-o" . eshell)
  :hook (eshell-first-time-mode . my/configure-eshell))

;; Solarized Theme
(use-package solarized-theme
  :straight t
  :init
  (setq solarized-use-variable-pitch nil
		solarized-scale-org-headlines nil)
  :config
  (load-theme 'solarized-dark t))

;; Preview latex in org files automatically
(use-package org-fragtog
  :demand
  :straight t
  :hook ((org-mode . org-fragtog-mode)
		 (org-mode . (lambda () (org-latex-preview '(16))))))

(my/font-setup)

(if (daemonp)
 	(add-hook 'after-make-frame-functions
 			  (lambda (frame)
 				(with-selected-frame frame (my/font-setup)))))


(cond ((eq system-type 'gnu/linux)
	   ;; GNU/Linux-specific configurations

	   (setq exec-path (append exec-path '("~/.local/bin")))

	   (set-language-environment   "utf-8")
	   (set-default-coding-systems 'utf-8)
	   (set-terminal-coding-system 'utf-8)
	   (set-keyboard-coding-system 'utf-8)
	   (prefer-coding-system       'utf-8))
	  ((eq system-type 'windows-nt)
	   ;; Windows-specific configurations
	   ))
