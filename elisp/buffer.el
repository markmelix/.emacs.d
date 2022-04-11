;;;; Buffer settings

;; Convenient mode line
(straight-use-package 'doom-modeline)
(require 'doom-modeline)
(doom-modeline-mode 1)


;;; Cursor
(custom-set-variables '(cursor-type 'bar "Use vertical bar cursor"))

;; Disable cursor blinking
(call-if-fbound 'blink-cursor-mode -1)

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
(custom-set-variables '(tab-width 4))

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
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

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
(straight-use-package 'highlight-indent-guides)

(custom-set-variables '(highlight-indent-guides-method 'character))

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'org-mode-hook 'highlight-indent-guides-mode)
(add-hook 'html-mode-hook 'highlight-indent-guides-mode)

;;; Visually distinguish file-visiting windows from other types of windows (like
;;; popups or sidebars) by giving them a slightly different background.
(straight-use-package 'solaire-mode)
(solaire-global-mode)

;;; Preview line when executing goto-line command.
(straight-use-package 'goto-line-preview)
(global-set-key [remap goto-line] 'goto-line-preview)

;;; Better undo implementation
(straight-use-package 'undo-tree)
(global-undo-tree-mode)

;;; Delete whitespace between words, parenthesis and other delimiters in a (not
;;; very) smart way.
(straight-use-package 'smart-hungry-delete)
(require 'smart-hungry-delete)
(smart-hungry-delete-add-default-hooks)
(keymap-global-set "<backspace>" 'smart-hungry-delete-backward-char)
(keymap-global-set "C-d" 'smart-hungry-delete-forward-char)

;;; Drag Stuff is a minor mode for Emacs that makes it possible to drag stuff
;;; (words, region, lines) around in Emacs.
(straight-use-package 'drag-stuff)
(require 'drag-stuff)
(drag-stuff-define-keys)
(keymap-global-set "M-p" 'drag-stuff-up)
(keymap-global-set "M-n" 'drag-stuff-down)
(drag-stuff-global-mode 1)

;;; Expand region increases the selected region by semantic units. Just keep
;;; pressing the key until it selects what you want.
(straight-use-package 'expand-region)
(require 'expand-region)
(keymap-global-set "C-=" 'er/expand-region)

;;; Run code formatter on buffer contents without moving point, using RCS
;;; patches and dynamic programming.
(straight-use-package 'apheleia)
(apheleia-global-mode +1)

;;; Make some buffers not to be displayed while using prev-buffer or next-buffer
;;; functions.
(defun my-buffer-predicate (buffer)
  (if (string-match "helm" (buffer-name buffer))
      nil
    t))
(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)
