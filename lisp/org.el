;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Follow the links
(setq org-return-follows-link  t)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)
