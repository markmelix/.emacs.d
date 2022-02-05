(defvar elisp-dir-path "elisp/"
  "Path to the directory containing elisp files to load.
This path is relative to user-emacs-directory.")

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file (concat user-init-dir elisp-dir-path "/"))))

(load-user-file "functions.el")
(load-user-file "vars.el")
(load-user-file "startup.el")
(load-user-file "personal.el")
(load-user-file "locale.el")
(load-user-file "buffer.el")
(load-user-file "minibuffer.el")
(load-user-file "frame.el")
(load-user-file "eshell.el")
(load-user-file "dired.el")
(load-user-file "modes.el")
(load-user-file "backup.el")
(load-user-file "misc.el")

(load-user-file "org.el")
(load-user-file "org-roam.el")

(load-user-file "ide.el")

(load-user-file "lang/rust.el")
(load-user-file "lang/python.el")
(load-user-file "lang/c.el")
(load-user-file "lang/docker.el")
(load-user-file "lang/web.el")
(load-user-file "lang/fish.el")
(load-user-file "lang/cmake.el")
