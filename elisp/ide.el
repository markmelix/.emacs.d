;;;; Integrated development environment

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
