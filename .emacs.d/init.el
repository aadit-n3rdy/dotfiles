(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "mononoki Nerd Font" :height 140)
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)

(define-key emacs-lisp-mode-map (kbd "C-x e") 'eval-buffer)

(dolist (mode '(org-mode-hook
		term-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (use-package helm
;;   :init
;;   (helm-mode)
;;   :bind (("M-x" . helm-M-x)
;; 	 ("C-x C-f" . helm-find-files)))

(use-package ivy
   :config
   (ivy-mode 1)
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-l" . ivy-done)
	 ("C-k" . ivy-next-line)
	 ("C-j" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-next-line)
	 ("C-j" . ivy-previous-line)
	 ("C-d" . ive-reverse-i-search-kill)))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package which-key
  :init
  (which-key-setup-minibuffer)
  (which-key-mode 1)
  :config
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-idle-delay 0.3))

(use-package doom-modeline
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-width 5)
  (setq doom-modeline-project-detection 'project)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon  t)
  :hook (after-init . doom-modeline-mode))
(use-package doom-themes
  :config
  (load-theme 'doom-dracula t))

(use-package all-the-icons)
;; (use-package all-the-icons-ivy)
;; (use-package all-the-icons-ivy-rich)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package general)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  :config
  (evil-mode 1)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package treemacs)
(use-package treemacs-evil
  :after (treemacs evil))

(use-package hydra)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  (c-mode . lsp)
  (c++-mode . lsp)
  (python-mode . lsp)
  
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))
(use-package lsp-treemacs
  :after lsp)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)  
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(use-package company-box
  :after company-mode
  :hook (company-mode . company-box))
(use-package projectile
  :config (projectile-mode 1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))
  
(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(add-hook 'c-mode-hook 'lsp)
(add-hook 'cpp-mode-hook 'lsp)
(add-hook 'cc-mode-hook 'lsp)
