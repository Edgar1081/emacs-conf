;; Moving windows
(global-set-key [M-left] 'windmove-left)          ; move to left window
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to lower window

;; Auto revert mode to reload changes in disk
(setq global-auto-revert-non-file-buffers t) 
(global-auto-revert-mode 1)

;; Focus new Window bottom
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
;; Focus new Window side
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; Disable startup screen
(setq inhibit-startup-message t)

;; start server
(server-start)

;; Full screen at start
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(undecorated . t))

;; Disable toolbar, scrollbar, and menu bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Short asnwers
(setq use-short-answers t)

;; Line numbers
(global-display-line-numbers-mode t)

;; Column number
(setq column-number-mode t)

;; font
;; Set icon font only for symbols
(set-frame-font "JetBrainsMono Nerd Font-12" t t)

;; Transparency
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Replace selected text
(delete-selection-mode 1)

;; Load config files
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "welcome.el")
(load "packages.el")
