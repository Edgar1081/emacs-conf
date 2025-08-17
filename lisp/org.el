;; org.el — put this in your org.el or your init where you keep package config
(use-package org
  :defer t
  :init
  ;; base locations (customize to your preference)
  (setq org-directory (expand-file-name "~/org/"))
  (setq org-default-notes-file (concat org-directory "inbox.org"))
  ;; nicer startup
  (setq org-startup-indented t)     ;; behave like org-indent-mode on open
  (setq org-startup-folded 'showall) ;; or 'content / 'overview
  (setq org-ellipsis " ▼ ")         ;; nicer fold ellipsis
  :config
  ;; buffer presentation
  (add-hook 'org-mode-hook #'visual-line-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)
  (setq org-hide-emphasis-markers t)   ;; hide *bold* markers
  (setq org-return-follows-link t)     ;; RET follows links

  ;; source block editing/formatting
  (setq org-src-fontify-natively t)    ;; syntax highlight code blocks
  (setq org-src-preserve-indentation t)
  (setq org-edit-src-content-indentation 0)
  (setq org-src-tab-acts-natively t)

  ;; Babel — enable languages you want to run inside org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t))) ;; add more as needed

  ;; Keep Org files tidy and searchable
  (setq org-agenda-files (list org-directory))
  (setq org-agenda-span 'week)

  ;; Capture templates (quick notes)
  (setq org-capture-templates
        `(("t" "Todo" entry (file+headline ,(concat org-directory "inbox.org") "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("n" "Note" entry (file ,(concat org-directory "notes.org"))
           "* %U %?\n\n  %i\n  %a")))

  ;; nice default appearance for headings/blocks
  (setq org-hide-leading-stars t)
  (setq org-pretty-entities t))
