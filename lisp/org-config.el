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

  (define-key org-mode-map (kbd "C-c t") 'org-toggle-heading) ;; toggle heading visibility
  (define-key org-mode-map (kbd "C-c l") 'org-insert-link)    ;; insert link
  (define-key org-mode-map (kbd "C-c c") 'org-capture)        ;; capture note
 ;; Insert template files
  (define-key org-mode-map (kbd "C-c h")
	      (lambda ()
      (interactive)
      (insert-file-contents "~/.emacs.d/org-templates/homework.org")))
  (define-key org-mode-map (kbd "C-c n")
	      (lambda ()
      (interactive)
      (insert-file-contents "~/.emacs.d/org-templates/notes.org")))  ;; buffer presentation
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

(use-package org-modern
  :ensure t
  :defer t
  :hook (org-mode . org-modern-mode))

;; Use minted instead of default listings
(setq org-latex-listings 'minted)
(setq org-latex-packages-alist '(("" "minted")))
(setq org-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "true")))

;; Always compile with shell-escape for minted
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory=%o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory=%o %f"))

;; Links colorlinks
(setq org-latex-hyperref-template
      "\\hypersetup{colorlinks=true, linkcolor=blue, urlcolor=blue, citecolor=blue}")
;; TOC
(add-to-list 'org-latex-packages-alist '("" "tocloft"))
(setq org-latex-toc-command "\\tableofcontents")

;; org-bable for code blokcs evaluation
;; List of languages you want to support
(setq my/org-babel-languages
      '((haskell . t)
        (python  . t)
        (emacs-lisp . t)
        (shell   . t)
        (C       . t)
        (java    . t)
	(latex . t)))

;; Load them into org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 my/org-babel-languages)

;; In line preview
(use-package org-fragtog
  :ensure t
  :defer t
  :hook (org-mode . org-fragtog-mode))
