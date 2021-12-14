;;; init.el --- Emacs configuration
;;; Commentary:





;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
              '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(package-initialize)


;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "Pedram Tavadze"
            user-mail-address "petavazohi@mix.wvu.edu")



;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)


;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a key-press
(delete-selection-mode t)


;; define list of packages to install
(defvar myPackages
  '(better-defaults
    material-theme
    dracula-theme
    exec-path-from-shell
    elpy
    flyspell
    flycheck
    flycheck-grammarly
    lsp-mode
    pyenv-mode
    epc
    deferred
    auto-complete
    python-environment
    conda
    jedi
    auctex
    auctex-latexmk
    latex-preview-pane
    web-mode
    markdown-mode
    rainbow-delimiters
    yaml-mode
    windmove
    company
    company-auctex
    company-bibtex
    company-shell
    yasnippet
    org
    ))

;; install all packages in list
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(defun comment ()
   "Check if anything is selected use 'comment-region' else use 'comment-line'."
  (if mark-active
      ('comment-region)
    'comment-line))


(defun close-and-kill-this-pane ()
  "If there are multiple windows, then close this pane and kill the buffer in it also."
  (interactive)
  (kill-this-buffer)
  (if (not (one-window-p))
                (delete-window)))


;; copy to clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; don't show warnings
(setq warning-minimum-level :emergency)

;; Use shell's $PATH
(exec-path-from-shell-copy-env "PATH")
;; (setq inhibit-startup-message t)   ;; hide the startup message

;; (load-theme 'material t)           ;; load material theme
;; (load-theme 'material-light t)           ;; load material theme
(load-theme 'material t)           ;; load material theme
;; (load-theme 'dracula t)

(global-linum-mode  t)              ;; enable line numbers globally
(setq linum-format "%4d \u2502 ")  ;; format line number spacing
(load "~/.emacs.d/linum-hl")
(require 'linum-highlight-current-line-number)
(setq linum-format 'linum-highlight-current-line-number)

;; enable yassnippets
(yas-global-mode 1)

;; saveplace remembers your location in a file when saving files
(save-place-mode 1)

;; show matching paranthesis
(show-paren-mode 1)

;; highlight the current line
(global-hl-line-mode 1)

;; pranthesis will have differnt colors
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; web-mode settings
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))


;; org settings
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-support-shift-select t)



;; Start fullscreen (cross-platf)
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;; to activate vasp-mode
(add-to-list 'auto-mode-alist '("\\CAR\\'" . vasp-mode))


;; company-mode text complition http://company-mode.github.io/
(add-hook 'after-init-hook 'global-company-mode)

;; remove creating backup files
(setq make-backup-files nil)

;; flyspell-mode spell check
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; flycheck-mode syntax check
(add-hook 'after-init-hook 'global-flycheck-mode)
(require 'flycheck-grammarly)
(setq flycheck-grammarly-check-time 0.8)


;; keybindings
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)

(global-set-key (kbd "C-<left>")  'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>")    'windmove-up)
(global-set-key (kbd "C-<down>")  'windmove-down)

(global-set-key (kbd "C-<prior>")  'beginning-of-buffer)
(global-set-key (kbd "C-<next>") 'end-of-buffer)


(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "M-1") (comment))
(global-set-key (kbd "C-l") 'linum-mode)
(global-set-key (kbd "C-w") 'kill-buffer)
(global-set-key (kbd "C-o") 'find-file)


(global-set-key (kbd "C-x \"") 'split-window-below)
(global-set-key (kbd "C-x %") 'split-window-right)
(global-set-key (kbd "C-x -") 'split-window-below)
(global-set-key (kbd "C-x _") 'split-window-right)



(global-set-key (kbd "C-g")  'flycheck-list-errors)

(global-visual-line-mode t)

;; ;; move from half space buffers using shift and arrow keys
;; ;; (windmove-default-keybindings)

;; make mode
(add-to-list 'auto-mode-alist '("\\makefile.*\\'" . makefile-mode))




(load "~/.emacs.d/local")
(load "~/.emacs.d/f90")
(load "~/.emacs.d/bash")
(load "~/.emacs.d/python")
(load "~/.emacs.d/vasp-mode")
(if (eq major-mode 'latex-mode)
    (load "~/.emacs.d/latex.el"))

;;; init.el ends here


