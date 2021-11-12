;x; ;; init.el --- Emacs configuration

;; ;; Set OSX function key as Meta

;; ;; INSTALL PACKAGES

;; ;; --------------------------------------

;; (require 'package)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives     
              '("elpy" . "http://jorgenschaefer.github.io/packages/"))   

(package-initialize)

;; ;; activate all packages

;; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

;; define list of packages to install
(defvar myPackages
  '(better-defaults
    material-theme
    exec-path-from-shell
    elpy
    pyenv-mode))

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


(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq jedi:environment-root "jedi")


;; Use shell's $PATH
(exec-path-from-shell-copy-env "PATH")
(setq inhibit-startup-message t)   ;; hide the startup message
(load-theme 'material t)           ;; load material theme
;;(load-theme 'spacemacs-dark t)
;;(load-theme 'dracula t)

(global-linum-mode  t)              ;; enable line numbers globally
(setq linum-format "%4d \u2502 ")  ;; format line number spacing
;; Allow hash to be entered  
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))



;; ;;(setq yas-triggers-in-field t)


;; ;; remove creating backup files
(setq make-backup-files nil)

(load "~/.emacs.d/local")

