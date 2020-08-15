
(defconst user-settings-dir
  (concat user-emacs-directory "elisp"))
(defun load-user-file (file)
  (load-file (expand-file-name file user-settings-dir)))

;;;;;;;;;;;;;;;;;;;;;;;
;; Package management
;;;;;;;;;;;;;;;;;;;;;;;

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;;;;;;;;;;;;;;;;;;;;;;
;; Core settings
;;;;;;;;;;;;;;;;;;;;;;;

(auto-save-visited-mode 1)
(setq inhibit-startup-screen t)
(setq auto-save-visited-interval 1)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
(setq make-backup-files nil)
(load-library "iso-transl")
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file) (load custom-file))
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode -1)
(column-number-mode t)
(delete-selection-mode 1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 1)
(pixel-scroll-mode)
(setq-default truncate-lines t
              indent-tabs-mode nil)
(setq epa-pinentry-mode 'loopback)
(auth-source-pass-enable)
(setq scroll-margin 10
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(put 'secrets-mode 'disabled nil)
(setq create-lockfiles nil)

(use-package dired-subtree
  :config
  (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle))

(setq-default dired-listing-switches "-laGh1v --group-directories-first")

(if (equal "clevo-n141zu" (system-name))
    (progn
      (add-to-list 'default-frame-alist '(font . "Fantasque Sans Mono-18"))
      ;; (add-to-list 'default-frame-alist '(font . "Iosevka Type-15"))
      (setq-default line-spacing 4))
  (progn
    (add-to-list 'default-frame-alist '(font . "Fantasque Sans Mono-14"))
    ;; (add-to-list 'default-frame-alist '(font . "Iosevka Type-14"))
    (setq-default line-spacing 3)))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; (use-package white-sand-theme
;;   :config
;;   (load-theme 'white-sand t))

(use-package chocolate-theme
  :config
  (load-theme 'chocolate t))

(setq tramp-default-method "ssh")

;;;;;;;;;;;;;;;;;;;;;;;
;; File types
;;;;;;;;;;;;;;;;;;;;;;;

(use-package dhall-mode)
(use-package graphql-mode)
(use-package json-mode
  :config (setq js-indent-level 2))
(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
(use-package nix-mode :after json-mode :mode "\\.nix\\'")
(use-package yaml-mode)

(use-package sql-indent
  :config
  (add-hook 'sql-mode-hook 'sqlind-minor-mode))

(use-package rjsx-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)))

;;;;;;;;;;;;;;;;;;;;;;;
;; Core plugins
;;;;;;;;;;;;;;;;;;;;;;;

(use-package counsel
  :config
  (ivy-mode 1)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)

  (global-set-key (kbd "C-h f") 'counsel-describe-function)
  (global-set-key (kbd "C-h v") 'counsel-describe-variable)
  (global-set-key (kbd "C-h l") 'counsel-find-library)
  (global-set-key (kbd "C-h i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "C-h u") 'counsel-unicode-char)

  (global-set-key (kbd "C-c C-r") 'ivy-resume)

  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package prescient
  :config (prescient-persist-mode))
(use-package ivy-prescient
  :after counsel prescient
  :config (ivy-prescient-mode))
(use-package company-prescient
  :after company prescient
  :config (company-prescient-mode))

(use-package ivy-posframe
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  (ivy-posframe-mode 1))

(use-package yasnippet)
(use-package company
  :config
  (global-set-key (kbd "C-ù") 'company-capf)
  (add-hook 'after-init-hook 'global-company-mode))

;;;;;;;;;;;;;;;;;;;;;;;
;; Window Management
;;;;;;;;;;;;;;;;;;;;;;;

(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-keys '(?a ?z ?e ?r ?t ?q ?s ?d ?f)))

(global-set-key (kbd "C-x é") 'split-window)
(global-set-key (kbd "C-x \"") 'split-window-horizontally)
(global-set-key (kbd "C-x &") 'delete-other-windows)
(global-set-key (kbd "C-x à") 'delete-window)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

(global-set-key (kbd "C-<tab>") 'switch-to-last-buffer)

;; (use-package frog-jump-buffer
;;   :config
;;   (global-set-key (kbd "C-x b") 'frog-jump-buffer))

;; (use-package zoom
;;   :config
;;   (setq zoom-size (lambda ()
;;                     (cond ((> (frame-pixel-width) 1280) '(90 . 0.80))
;;                           (t                            '(0.5 . 0.5))))
;;         )
;;   (zoom-mode t))


;;;;;;;;;;;;;;;;;;;;;;;
;; Text editing
;;;;;;;;;;;;;;;;;;;;;;;

(use-package expand-region
  :config
  (global-set-key (kbd "C-*") 'er/expand-region)
  (global-set-key (kbd "C-M-*") 'er/contract-region))

(use-package avy
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (avy-setup-default))

(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))

(global-set-key (kbd "C-$") 'duplicate-line-or-region)

;;;;;;;;;;;;;;;;;;;;;;;
;; Project Management
;;;;;;;;;;;;;;;;;;;;;;;

(use-package direnv :config (direnv-mode))
(use-package magit :config (global-set-key (kbd "C-x g") 'magit-status))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/Code")))

(use-package counsel-projectile
  :after projectile counsel
  :config
  (counsel-projectile-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;
;; Programming
;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck
  :init
  (global-flycheck-mode t))
  ;; :config
  ;; (setq-default flycheck-temp-prefix ".flycheck"
                ;; flycheck-disabled-checkers '(javascript-jshint)
                ;; flycheck-checkers '(javascript-eslint)))

(use-package emmet-mode
    :init
    (add-hook 'css-mode-hook  'emmet-mode)
    (add-hook 'html-mode-hook  'emmet-mode))

(use-package haskell-mode
  ;; :hook (haskell-mode . haskell-interactive-mode)
  :config
  (add-hook 'haskell-mode-hook (lambda ()
                                 (interactive-haskell-mode)
                                 (flycheck-mode)))
  ;; :hook (lambda ()
           ;; (interactive-haskell-mode)
           ;; (flycheck-mode)
           ;; (dante-mode)
           ;; (setq haskell-mode-stylish-haskell-path "~/.local/bin/brittany")
           ;; (setq haskell-stylish-on-save t)
           ;; (let ((current-prefix-arg 1))
           ;; (paredit-mode))
           ;; (set-face-underline 'flycheck-error nil)
           ;; (set-face-underline 'flycheck-warning nil)
  ;; )
  (setq haskell-stylish-on-save t)
  (setq haskell-process-type 'cabal‑new-repl))

(use-package lsp-mode
  :hook (haskell-mode . lsp)
  :hook (haskell-mode . direnv-update-environment)
  ;; :config
  ;; (setq gc-cons-threshold 100000000)
  ;; (setq read-process-output-max (* 1024 1024)) ;; 1mb
  ;; (setq lsp-prefer-capf t)
  ;; (setq lsp-log-io t)
  ;; (setq lsp-document-sync-method 'full)
  ;; (setq lsp-prefer-flymake nil)
  :commands lsp)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :hook (haskell-mode . flycheck-mode)
  :config
  (global-set-key (kbd "M-p") 'lsp-ui-sideline-apply-code-actions)
  :commands lsp-ui-mode)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

;; (use-package company-lsp :commands company-lsp)
(use-package lsp-haskell
  :config
  ;; (setq lsp-haskell-process-path-hie "ghcide")
  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
  (setq lsp-haskell-process-args-hie '()))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))

(use-package tide)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)
;; (add-hook 'before-save-hook 'prettier-js-mode)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-tide-mode)
(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

(setq-default typescript-indent-level 2)

(use-package prettier-js)

(add-hook 'js-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

(use-package elixir-mode
  :config
  (setq lsp-clients-elixir-server-executable "elixir-ls"))

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

(use-package ein)

(use-package docker
  :bind ("C-c d" . docker))

(use-package dockerfile-mode)
(use-package docker-compose-mode)
