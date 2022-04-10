;;; Debugging features

(straight-use-package 'dap-mode)
(require 'lsp)

(add-hook 'python-mode-hook 'dap-mode)
(add-hook 'rustic-mode-hook 'dap-mode)

(keymap-set lsp-command-map "d" 'dap-hydra)
(keymap-set prog-mode-map "C-c d" 'dap-hydra)

(setq lsp-enable-dap-auto-configure nil
	  dap-default-terminal-kind "external"
	  dap-external-terminal '("alacritty" "-t" "{display}" "-e" "sh" "-c" "{command}")
	  dap-python-executable "python"
	  dap-python-debugger 'debugpy)

(require 'dap-node)
(require 'dap-python)
(require 'dap-lldb)
(require 'dap-gdb-lldb)

(dap-gdb-lldb-setup)
(dap-node-setup)

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
