;;;; Own function deffinitions

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

;;;; Own variables initializating

(defvar my/buffer-width 80)

;;;; Startup settings

(custom-set-variables
 ;; Set gc-cons-threshold to high number to handle a lot of garbage
 '(gc-cons-threshold 100000000)

 ;; Increase the amount of data which Emacs reads from the process
 '(read-process-output-max (* 1024 1024))

 ;; Inhibit startup screens
 '(inhibit-startup-screen t)
 '(inhibit-splash-screen  t)

 ;; Set initial scratch buffer message to nil
 '(initial-scratch-message nil)

 ;; Inhibit bell ringing
 '(ring-bell-function 'ignore)
 
 ;; Set default shell to bash instead of fish
 '(shell-file-name "/bin/bash")
 )

;;; Don't print any message to the minibuffer after Emacs startup
(defun display-startup-echo-area-message ())

;;;; Package management

;;; Bootstrap straight package manager
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

;;; The leaf macro allows you to isolate package configuration in your
;;; .emacs file in a way that is both performance-oriented and, well, tidy.
(straight-use-package 'leaf)
(require 'leaf)

(straight-use-package 'leaf-keywords)
(leaf-keywords-init)

;;; Keep .emacs.d clean
(leaf no-littering
  :straight t
  :config
  (custom-set-variables
   '(custom-file (no-littering-expand-etc-file-name "custom.el")))
  (unless (file-exists-p custom-file)
	(write-region "" nil custom-file))
  (load custom-file))

;;; Make Emacs use the $PATH set up by the user's shell
(leaf exec-path-from-shell
  :straight t
  :config
  (when (or (daemonp) (memq window-system '(mac ns x)))
	(exec-path-from-shell-initialize)))

;;;; Locale settings

;; Set default input method after all get initialized
(add-hook 'after-init-hook (lambda ()
							 (custom-set-variables '(default-input-method "russian-computer"))))

;;; Platform specific locale configuration
(cond ((eq system-type 'gnu/linux)
	   ;; GNU/Linux-specific locale configuration
	   (set-language-environment   "utf-8")
	   (set-default-coding-systems 'utf-8)
	   (set-terminal-coding-system 'utf-8)
	   (set-keyboard-coding-system 'utf-8)
	   (prefer-coding-system       'utf-8))
	  ((eq system-type 'windows-nt)
	   ;; TODO: Windows-specific locale configuration
	   ))

;;;; Buffer settings

;;; Convenient mode line
(leaf doom-modeline
  :straight t
  :require t
  :config
  (doom-modeline-mode 1))

;;; Cursor
(custom-set-variables '(cursor-type 'bar))

;; Disable cursor blinking
(blink-cursor-mode -1)

;; Highlight current line
(global-hl-line-mode)

;;; Scrolling
(custom-set-variables
 ;; Number of lines of margin at the top and bottom of a window
 '(scroll-margin 1)

 ;; Scroll up to this many lines, to bring point back on screen
 '(scroll-conservatively 0)

 ;; Scrolling speed is proportional to the wheel speed
 '(mouse-wheel-progressive-speed nil)

 ;; Mouse wheel should scroll the window that the mouse is over
 '(mouse-wheel-follow-mouse t)

 ;; Disable adjusting window-vscroll automatically
 '(auto-window-vscroll nil)
 )

(custom-set-variables
 ;; How far to scroll windows upward
 '(scroll-up-aggressively 0.01)

 ;; How far to scroll windows downward
 '(scroll-down-aggressively 0.01)
 )

;;; Indentation
;; Width of a TAB character on display
(setq-default tab-width 4)

;;; Column beyond which automatic line-wrapping should happen
(custom-set-variables '(fill-column my/buffer-width))

;;; Buffer revert
;; Revert all buffers automatically
(global-auto-revert-mode 1)

;; Revert all non-file buffers
(custom-set-variables '(global-auto-revert-non-file-buffers t))

;; Inhibit generating any messages while reverting buffers
(custom-set-variables '(auto-revert-verbose nil))

;;; Fill column indicator
;; Display long line on the right part of the screen to determine when it's
;; time to break a line
;(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

;;; Line numbers
;; Display line numbers in the following modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'fish-mode-hook 'display-line-numbers-mode)

;;; Automatic line breaking
;; Enable auto-fill mode in following modes
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'fundamental-mode-hook 'auto-fill-mode)

;;; Parentheses
;; Show matching parenthesis
(show-paren-mode 1)

;; Close matching parenthesis
(electric-pair-mode 1)

;;; Word wrap
;; Turn on word wrap
(global-visual-line-mode 1)

;;; Highlight indent guides
(leaf highlight-indent-guides
  :straight t
  :hook prog-mode-hook org-mode-hook html-mode-hook
  :custom
  (highlight-indent-guides-method . 'character))

;;; Visually distinguish file-visiting windows from other types of windows (like
;;; popups or sidebars) by giving them a slightly different background.
(leaf solaire-mode
  :straight t
  :config
  (solaire-global-mode))

;;; Preview line when executing goto-line command.
(leaf goto-line-preview
  :straight t
  :bind ([remap goto-line] . goto-line-preview))

;;; Better undo implementation
(leaf undo-tree
  :straight t
  :config
  (global-undo-tree-mode))

;;; Delete whitespace between words, parenthesis and other delimiters in a (not
;;; very) smart way.
(leaf smart-hungry-delete
  :straight t
  :require t
  :bind
  (:python-mode-map ("<backspace>" . smart-hungry-delete-backward-char))
  ("C-d" . smart-hungry-delete-forward-char)
  :config
  (smart-hungry-delete-add-default-hooks))

;;; Drag Stuff is a minor mode for Emacs that makes it possible to drag stuff
;;; (words, region, lines) around in Emacs.
(leaf drag-stuff
  :disabled t
  :straight t
  :require t
  :bind
  ("M-p" . drag-stuff-up)
  ("M-n" . drag-stuff-down)
  ("M-<left>" . nil)
  ("M-<right>" . nil)
  :config
  (drag-stuff-define-keys)
  (drag-stuff-global-mode 1))

;;; Expand region increases the selected region by semantic units. Just keep
;;; pressing the key until it selects what you want.
(leaf expand-region
  :straight t
  :require t
  :bind
  ("C-=" . 'er/expand-region))

;;; Run code formatter on buffer contents without moving point, using RCS
;;; patches and dynamic programming.
(leaf apheleia
  :straight t
  :config
  (apheleia-global-mode 1))

;;; Make some buffers not to be displayed while using prev-buffer or next-buffer
;;; functions.
(defun my-buffer-predicate (buffer)
  (if (string-match "helm" (buffer-name buffer))
      nil
    t))
(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

;;;; Minibuffer settings

;; Ask for y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Use main buffer's input method when minibuffer is launched.
(defun my-inherit-input-method ()
  "Inherit input method from `minibuffer-selected-window'."
  (let* ((win (minibuffer-selected-window))
         (buf (and win (window-buffer win))))
    (when buf
      (activate-input-method (buffer-local-value 'current-input-method buf)))))

(add-hook 'minibuffer-setup-hook #'my-inherit-input-method)

;;; Helm setup
;; Framework for incremental completions and narrowing selections
(leaf helm
  :straight t
  :bind
  ("M-x" . helm-M-x)
  ("C-x r b" . helm-filtered-bookmarks)
  ("C-x C-f" . helm-find-files)
  ("C-x b" . helm-mini)
  :custom
  (helm-M-x-fuzzy-match . t)
  (helm-buffers-fuzzy-matching . t)
  (helm-recentf-fuzzy-match . t)
  :config
  (helm-mode 1)

  ;;; Interfaces of The Silver Searcher with helm.
  (leaf helm-ag
	:straight t))

;;;; Emacs Shell configuration
(leaf eshell
  :hook
  ;; Save command history when commands are entered
  (eshell-pre-command-hook . eshell-save-some-history)
  :bind
  ("C-c C-o" . eshell)
  :custom
  (eshell-history-size . 10000)
  (eshell-buffer-maximum-lines . 10000)
  (eshell-hist-ignoredups . t)
  (eshell-scroll-to-bottom-on-input . t))

;;;; Dired configuration

;;; Subtrees
(leaf dired-subtree
  :straight t
  :bind (:dired-mode-map
		 ("C-;" . dired-subtree-toggle)
		 ("M-u" . dired-up-directory)))

;; Filter dired output
(leaf dired-filter
  :straight t)

;; Open files differently from dired
(leaf dired-open
  :straight t)

;;;; File backup configuration

(custom-set-variables
 ;; Backup of a file the first time it is saved
 '(make-backup-files t)

 ;; Don't clobber symlinks
 '(backup-by-copying t)

 ;; Version numbers for backup files
 '(version-control t)

 ;; Delete excess backup files silently
 '(delete-old-versions t)

 ;; Use system trash can
 '(delete-by-moving-to-trash t)

 ;; Oldest versions to keep when a new numbered backup is made
 '(kept-old-versions 6)

 ;; Newest versions to keep when a new numbered backup is made
 '(kept-new-versions 9)

 ;; Auto-save every buffer that visits a file
 '(auto-save-default t)

 ;; Number of seconds idle time before auto-save
 '(auto-save-timeout 20)

 ;; Number of keystrokes between auto-saves
 '(auto-save-interval 200)

 ;; Don't create lockfiles
 '(create-lockfiles nil)
 )

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

;;; Other miscellaneous settings

;; An utility package to collect various Icon Fonts and propertize them
;; Run all-the-icons-install-fonts to install the fonts
(leaf all-the-icons
  :if (display-graphic-p)
  :straight t
  :require t)

;; Url browsing
(custom-set-variables
 ;; Browse urls with generic function
 '(browse-url-browser-function 'browse-url-generic)
 
 ;; Change default browse-url program to chromium
 '(browse-url-generic-program "chromium")

 ;; Add extra arguments when browsing with chromium
 ;; Don't ask whether to restore crashed pages or not
 '(browse-url-chromium-arguments '("--disable-session-crashed-bubble"))
 )

(setq-default
 ;; Add a newline automatically at the end of the file when it is about to be
 ;; saved
 require-final-newline t
 )

;;; What to do if the current emacs process is a daemon
(if (daemonp)
 	(add-hook 'after-make-frame-functions
 			  (lambda (frame)
 				(with-selected-frame frame (my/font-setup)))))

;; Display available keybindings in popup
(leaf which-key
  :straight t
  :config
  (which-key-mode))

;;;; Frame and UI settings

(defun my/font-setup ()
  "Setup fonts"
  (set-frame-font "Hack Nerd Font 11" t t)

  ;; Emoji: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
  (set-fontset-font t 'symbol "Apple Color Emoji")
  (set-fontset-font t 'symbol "Noto Color Emoji" nil 'append)
  (set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
  (set-fontset-font t 'symbol "Symbola" nil 'append))

(when (or (daemonp) (display-graphic-p))
	(my/font-setup))

;; Disable tool, menu and scroll bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Doom themes
(leaf doom-themes
  :straight t
  :config
  (load-theme 'doom-vibrant t))

;;;; Org mode settings

;;; Org Mode
(leaf org
  :straight t
  :bind
  ("C-c L" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  (:org-mode-map
   ("C-M-i" . completion-at-point))
  :require org org-tempo
  :custom
  (org-directory . "~/Org")
  (org-adapt-indentation . nil)
  (org-element-use-cache . nil)
  (org-hide-emphasis-markers . t)
  (org-enforce-todo-dependencies . t)
  (org-enforce-todo-checkbox-dependencies . t)
  (org-startup-with-inline-images . t)
  (org-image-actual-width . nil)
  (org-hierarchical-todo-statistics . nil)
  (org-checkbox-hierarchical-statistics . nil)
  (org-latex-create-formula-image-program . 'dvisvgm)
  `(org-preview-latex-image-directory . ,(expand-file-name "ltximg/" no-littering-var-directory))
  (org-latex-packages-alist . '(("" "amsmath" t nil)
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
  :config
  (plist-put org-format-latex-options :scale 2)
  (eval-after-load "preview"
	'(add-to-list 'preview-default-preamble
				  "\\PreviewEnvironment{tikzpicture}" t)))


;;; Shows org-mode bullets as pretty UTF-8 characters
(leaf org-bullets
  :straight t
  :hook org-mode-hook)

;; Preview latex in org files automatically
(leaf org-fragtog
  :straight t
  :hook (org-mode-hook (lambda ()
						 (let ((inhibit-message t))
						   (org-latex-preview '(16))))))

;;;; Org roam (zettelkasten inside Emacs) settings

;; Zettelkasten inside Emacs
(leaf org-roam
  :straight t
  :bind
  ("C-c n l" . org-roam-buffer-toggle)
  ("C-c n f" . org-roam-node-find)
  ("C-c n i" . org-roam-node-insert)
  ("C-c n c" . org-roam-capture)
  ("C-c n j" . org-roam-dailies-capture-today)
  :custom
  (org-roam-completion-everywhere . t)
  `(org-roam-directory . ,(file-truename "~/braindump/notes"))
  (org-roam-v2-ack . t)
  (org-roam-capture-templates
   . '(("d" "default" plain
		"* Метаданные\n** Источники\n- %?\n** Ссылки\n- \n* Данные\n"
		:if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
						   "#+title: ${title}\n")
		:unnarrowed t)))
  :config
  (org-roam-db-autosync-mode))

;; Beautiful and customizable Zettelkasten notes graph
(leaf org-roam-ui
  :straight t
  :bind ("C-c n g" . org-roam-ui-mode)
  :custom
  (org-roam-ui-sync-theme . t)
  (org-roam-ui-follow . t)
  (org-roam-ui-update-on-save . t)
  (org-roam-ui-open-on-start . t)
  (org-roam-ui-browser-function . 'browse-url-chromium))

;;;; An incremental parsing system for programming tools
(leaf tree-sitter
  :straight t
  :require t
  :hook
  (tree-sitter-after-on-hook . tree-sitter-hl-mode)
  :config
  (leaf tree-sitter-langs
	:straight t
	:require t)
  (global-tree-sitter-mode))

;;;; Project management
(leaf projectile
  :straight t
  :require t
  :config
  (projectile-mode 1))

;; Projectile with helm
(leaf helm-projectile
  :straight t
  :after projectile
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (helm-projectile-on))

;;;; Git management

(leaf magit
  :straight t
  :require t
  :config
  ;;; Show source files' TODOs (and FIXMEs, etc) in Magit status buffer
  (leaf magit-todos
	:straight t
	:require t
	:hook magit-mode-hook)
  
  ;;; Popup commit message at current line to know why this line was changed
  (leaf git-timemachine
	:straight t
	:require t
	:bind
	("C-c g t" . git-timemachine))

  ;;; Reveal the commit messages under the cursor
  (leaf git-messenger
	:straight t
	:bind
	("C-c g m" . git-messenger:popup-message)
	:custom
	(git-messenger:show-detail . t)
	(git-messenger:use-magit-popup . t))

  ;;; Open page at github/bitbucket from emacs buffers
  (leaf browse-at-remote
	:straight t
	:bind
	("C-c g b" . browse-at-remote))

  ;;; Highlight diffs in buffer
  (leaf diff-hl
	:straight t
	:hook
	(magit-pre-refresh-hook . diff-hl-magit-pre-refresh)
	(magit-post-refresh-hook . diff-hl-magit-post-refresh)
	:config
	(global-diff-hl-mode)))

;;;; IDE features

;;;; Different languages support

;;; Python IDE features
(leaf elpy
  :straight t
  :require t
  :hook ,(python-mode-hook . '(lambda () (electric-indent-mode -1)))
  :config
  (elpy-enable))

(leaf docker
  :straight t
  :bind "C-c C-d")

(leaf dockerfile-mode :straight t)
(leaf docker-compose-mode :straight t)
(leaf cmake-mode :straight t)
(leaf fish-mode :straight t)
(leaf toml-mode :straight t)
(leaf markdown-mode :straight t)

(leaf lua-mode
  :straight t
  :hook (lua-mode-hook . (lambda () (setq indent-tabs-mode nil)))
  :custom
  (lua-indent-level . 4))

;;; Rust language support
(leaf rustic
  :straight t
  :custom
  (lsp-eldoc-hook . nil)
  (lsp-enable-symbol-highlighting . nil)
  (lsp-signature-auto-activate . t))

;;; Real-time error checking
(leaf flycheck
  :straight t
  :require t
  :config
  (add-to-list 'flycheck-checkers 'rustic-clippy)
  (add-hook 'rustic-mode-hook (lambda ()
								(setq flycheck-checker 'rustic-clippy))))

;;; Snippets implementation
(leaf yasnippet
  :straight t
  :require t
  :hook (prog-mode-hook . yas-minor-mode)
  :config
  (leaf yasnippet-snippets
	:straight))

;;; Autocompletion
(leaf company
  :straight t
  :require t
  :hook prog-mode-hook
  :bind
  (:company-active-map
   ("C-n" . next-line)
   ("C-p" . previous-line)
   ("M-n" . company-select-next)
   ("M-p" . company-select-previous)
   ("M-<" . company-select-first)
   ("M->" . company-select-last))
  :custom
  (company-minimum-prefix-length . 1)
  (company-idle-delay . 0.0)
  :config
  ;;; Better sorting for company completion suggestions
  (leaf company-prescient
	:straight t
	:require t
	:config
	(company-prescient-mode 1)
	(prescient-persist-mode 1)))

;;; Lanuage Server Protocol
(leaf lsp-mode
  :straight t
  :require t
  :hook
  (lsp-mode-hook . lsp-enable-which-key-integration)
  :custom
  (lsp-rust-analyzer-cargo-watch-command . "clippy")
  (lsp-eldoc-render-all . t)
  (lsp-lens-enable . nil)
  (lsp-modeline-diagnostics-scope . :file)
  (lsp-modeline-code-actions-enable . nil)
  (lsp-headerline-breadcrumb-enable . nil)
  (lsp-enable-on-type-formatting . nil)
  (lsp-diagnostic-package . :none)
  (lsp-rust-analyzer-diagnostics-enable . nil)
  (lsp-rust-full-docs . t)
  (lsp-rust-clippy-preference . "on")
  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\prod\\'")
  ;; (cl-defgeneric lsp-clients-extract-signature-on-hover (contents _server-id)
  ;; 	"Extract a representative line from CONTENTS, to show in the echo area."
  ;; 	(nth 1 (s-split "\n\n" (lsp--render-element contents))))
  
  (leaf lsp-treemacs
	:straight t
	:require t
	:bind
	(:lsp-command-map
	 ("s" . lsp-treemacs-symbols)
	 ("e" . lsp-treemacs-error-list))))

(leaf lsp-ui
  :straight t
  :require t
  :bind-keymap
  (:lsp-mode-map
   ("C-c l" . lsp-command-map))
  :commands lsp-ui-mode
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

;;; Debugging features
(leaf dap-mode
  :straight t
  :require dap-python dap-gdb-lldb
  :hook rust-mode-hook python-mode-hook
  :bind
  ;; (:lsp-command-map
  ;;  ("d" . dap-hydra))
  (:prog-mode-map
   ("C-c d" . dap-hydra))
  :custom
  (lsp-enable-dap-auto-configure . nil)
  (dap-default-terminal-kind . "external")
  (dap-external-terminal . '("alacritty" "-t" "{display}" "-e" "sh" "-c" "{command}"))
  (dap-python-executable . "python")
  (dap-python-debugger . 'debugpy)
  :config
  ;(dap-gdb-lldb-setup)
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 0)
  (tooltip-mode 0)
  (dap-ui-controls-mode 1)

  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb"
		 :request "launch"
		 :name "LLDB::Run"
		 :gdbpath "rust-lldb"
		 ;; uncomment if lldb-mi is not in PATH
		 ;; :lldbmipath "path/to/lldb-mi"
		 ))

  (dap-register-debug-template
   "Python :: Debug"
   (list :type "python"
		 :console "externalTerminal"
		 :args ""
		 :cwd nil
		 :program nil
		 :request "launch"
		 :name "Python :: Debug")))
