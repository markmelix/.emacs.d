;;;; Buffer settings

;;; Cursor
;; Use vertical bar cursor
(setq-default cursor-type 'bar)

;; Disable cursor blinking
(call-if-fbound 'blink-cursor-mode -1)

;;; Scrolling
(setq
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
 )

(setq-default
 ;; How far to scroll windows upward
 scroll-up-aggressively 0.01

 ;; How far to scroll windows downward
 scroll-down-aggressively 0.01
 )

;;; Indentation
;; Width of a TAB character on display
(setq-default tab-width 4)



;; Column beyond which automatic line-wrapping should happen
(setq-default fill-column my/buffer-width)

;;; Buffer revert
;; Revert all buffers automatically
(global-auto-revert-mode 1)

;; Revert all non-file buffers
(setq global-auto-revert-non-file-buffers t)

;; Inhibit generating any messages while reverting buffers
(setq auto-revert-verbose nil)

;;; Fill column indicator
;; Display long line on the right part of the screen to determine when it's
;; time to break a line
(global-display-fill-column-indicator-mode 1)

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

;; Highlight indent guides
(use-package highlight-indent-guides
  :straight t
  :custom (highlight-indent-guides-method 'character)
  :hook ((prog-mode org-mode html-mode-hook) . highlight-indent-guides-mode))
