;;; Debugging features

(straight-use-package 'dap-mode)

(add-hook 'python-mode-hook 'dap-mode)
(add-hook 'rustic-mode-hook 'dap-mode)

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

(require 'dap-node)
(dap-node-setup)

(keymap-set lsp-mode-map "d" 'dap-hydra)

(dap-mode 1)
(dap-ui-mode 1)
(dap-tooltip-mode 0)
(tooltip-mode 0)
(dap-ui-controls-mode 1)
