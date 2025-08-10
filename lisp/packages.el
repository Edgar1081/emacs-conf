;; Initialize package system FIRST
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
;; Load use-package
(require 'use-package)
(setq use-package-always-ensure t)

;; VTERM package
(use-package vterm
  :ensure t
  :defer t
  :bind (("C-c t" . vterm))
  :config
  (setq vterm-shell "/bin/zsh")
  (setq vterm-max-scrollback 10000))

;; MAGIT package
(use-package magit
  :defer t
  :bind ("C-x g" . magit-status))
(setq magit-revert-buffers 'silent)

;; Doom mode line
(use-package doom-modeline
  :defer t
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-minor-modes t)
  (doom-modeline-icon t)
  (doom-modeline-icon t))

;; Theme and Icons
;; (load-theme 'leuven-dark t)
(use-package nerd-icons)

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon
  :config
  (load-theme 'doom-acario-dark t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Emacs latex
;; AUCTeX LaTeX setup
;; PDF Tools for viewing and navigation
;; Seeing pdf on emacs from latex
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)   ;; load pdf-tools when opening PDFs
  :commands pdf-view-mode                ;; lazy load when entering pdf-view-mode
  :hook (pdf-view-mode . (lambda () (display-line-numbers-mode 0)))
  :config
  ;; Run pdf-tools-install only when pdf-tools loads
  (pdf-tools-install)
  (pdf-view-midnight-minor-mode))



;; Emacs LaTeX configuration using AUCTeX + minted + pdf-tools
(use-package auctex
  :defer t
  :ensure t
  :hook (LaTeX-mode . LaTeX-preview-setup)
  :config
  ;; Automatically save style info and parse on load
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-save-query nil)
  (setq TeX-PDF-mode t) ;; default to PDF output

  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-method 'synctex)
  (add-hook 'LaTeX-mode-hook #'TeX-source-correlate-mode)

  ;; Use shell-escape for packages like minted
  (setq TeX-command-extra-options "-shell-escape")

  ;; Use pdf-tools as default viewer if installed
  (setq TeX-view-program-selection
        '((output-pdf "PDF Tools")
          (output-dvi "DVI Viewer")
          (output-html "HTML Viewer")))
  (setq TeX-view-program-list
        '(("PDF Tools" TeX-pdf-tools-sync-view)))

  (with-eval-after-load 'latex
    (add-to-list 'LaTeX-verbatim-environments "minted")
    (add-to-list 'LaTeX-verbatim-environments "Verbatim")
    (add-to-list 'LaTeX-verbatim-macros-with-braces "minted")
    (add-to-list 'LaTeX-verbatim-macros-with-braces "Verbatim"))
  
  ;; Enable forward search with pdf-tools
  (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
  (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))
