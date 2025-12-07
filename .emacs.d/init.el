;; Requisites: Emacs >= 24

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)
 (add-to-list 'package-archives
 	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;; (use-package lsp-mode
;;   :ensure t
;;   :defer t
;;   :hook ((php-mode-hook . lsp)
;; 	 (lsp-mode . lsp-enable-which-key-integration))
;;   :init
;;   (setq lsp-keep-workspace-alive nil
;;         lsp-signature-doc-lines 5
;;         lsp-idle-delay 0.5
;;         lsp-prefer-capf t
;;         lsp-client-packages nil)
;;   :config
;;   (setq lsp-keymap-prefix "C-c l")
;;   (fset 'lsp-command-map lsp-command-map))

(add-to-list 'exec-path "/usr/local/bin/intelephense")
;;(executable-find "intelephense")

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs flycheck company which-key dap-mode php-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(which-key-mode)
(add-hook 'php-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (setq lsp-keymap-prefix "C-c l")
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (require 'dap-php)
  (yas-global-mode))
;

;; (defvar myPackages
;;   '(better-defaults
;;     ein
;;     elpy
;;     flycheck
;;     py-autopep8
;;     yasnippet
;;     zenburn-theme
;;     color-theme-sanityinc-tomorrow))

;; (mapc #'(lambda (package)
;; 	  (unless (package-installed-p package)
;; 	    (package-install package)))
;;             myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
;(global-linum-mode t) ;; enable line numbers globally
(windmove-default-keybindings) ;; use shift to move around windows
(setq visible-bell nil)  ;; Turn beep off
(global-hi-lock-mode t) ;; C-x w h REGEX to highlight, C-x w r to unhighlight

;; PYTHON CONFIGURATION
;; --------------------------------------
;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))
;; (setq elpy-rpc-virtualenv-path 'current
;;       elpy-rpc-python-command "python3"
;;       python-shell-interpreter "python3"
;;       python-shell-interpreter-args "-i")
;; (setq elpy-rpc-backend "jedi")

;; let ((default-directory  "~/.emacs.d/"))
 ;;    (normal-top-level-add-subdirs-to-load-path))

; Source: http://www.emacswiki.org/emacs/CommentingCode
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
  If no region is selected and current line is not blank and we are not at the end of the line,
  then comment current line.
  Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)


(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(sanityinc-tomorrow-eighties))
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(package-selected-packages
   '(paredit rainbow-delimiters zenburn-theme virtualenv use-package py-autopep8 jedi-direx flycheck elpygen elpy ein color-theme-sanityinc-tomorrow better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
