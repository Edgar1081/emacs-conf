(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package markdown-mode
  :ensure t
  :defer t)

(use-package haskell-mode
  :ensure t
  :defer t)

;; Haskell-specific LSP hook
(use-package lsp-haskell
  :ensure t
  :defer t
  :hook (haskell-mode . lsp-deferred)
  :config
  (setq lsp-haskell-server-path "haskell-language-server-wrapper"
        lsp-haskell-server-args nil))

(use-package lsp-java
  :ensure t
  :defer t
  :hook (java-mode . lsp))

;; Core LSP configuration (deferred)
(use-package lsp-mode
  :defer t
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; global keymap for lsp commands
  :config
  ;; enable which-key integration globally
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :commands lsp-deferred)


(use-package lsp-ui
  :ensure t
  :defer t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t))

(use-package company
  :ensure t
  :defer t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

(use-package flycheck
  :ensure t
  :defer t
  :hook (lsp-mode . flycheck-mode))
