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
