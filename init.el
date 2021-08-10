
;; ;; init.el --- Emacs configuration

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(conda web-server websocket)))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )





;; (elpy-enable)

;; (add-hook 'elpy-mode-hook (lambda ()
;;                             (add-hook 'before-save-hook
;;                                       'elpy-format-code nil t)))
;; (yas-global-mode 1)
;; (add-hook 'yas-minor-mode-hook (lambda () (yas-activate-extra-mode 'fundamental-mode)))

;; ;; (setq python-shell-interpreter "python"
;; ;;       python-shell-interpreter-args "-i")


;; ;; (defcustom python-autopep8-path (executable-find "autopep8")
;; ;;   "autopep8 executable path."
;; ;;   :group 'python
;; ;;   :type 'string)

;; ;; (defun python-autopep8 ()
;; ;;   "Automatically formats Python code to conform to the PEP 8 style guide.
;; ;; $ autopep8 --in-place --aggressive --aggressive <filename>"
;; ;;   (interactive)
;; ;;   (when (eq major-mode 'python-mode)
;; ;;     (shell-command 
;; ;;      (format "%s --in-place --aggressive %s" python-autopep8-path
;; ;;              (shell-quote-argument (buffer-file-name))))
;; ;;     (revert-buffer t t t)))

;; ;; ;; (bind-key "C-c C-a" 'python-auto-format)

;; ;; (eval-after-load 'python
;; ;;   '(if python-autopep8-path
;; ;;        (add-hook 'before-save-hook 'python-autopep8)))

;; ;; (setq python-shell-interpreter "ipython"
;; ;;       python-shell-interpreter-args "-i --simple-prompt")



;; ;; (defun python-args-to-numpy-docstring (text &optional make-fields)
;; ;;   "Return a reST docstring format for the python arguments in yas-text."
;; ;;   (let* ((indent (concat "\n" (make-string (current-column) 32)))
;; ;;          (args (python-split-args text))
;; ;;      (nr 0)
;; ;;          (formatted-args
;; ;;       (mapconcat
;; ;;        (lambda (x)
;; ;;          (concat "   " (nth 0 x)
;; ;;              (if make-fields (format "  ${%d:type%d}" (cl-incf nr) nr))
;; ;;              (if (nth 1 x) (concat " ,\(default " (nth 1 x) "\)"))))
;; ;;        args
;; ;;        indent)))
;; ;;     (unless (string= formatted-args "")
;; ;;       (concat
;; ;;        (mapconcat 'identity
;; ;;           (list "" "Parameters:\n-----------" formatted-args)
;; ;;           indent)
;; ;;        "\n"))))


;; ;; (defun python-args-to-numpy-docstring (text &optional make-fields)
;; ;;   "return docstring format for the python arguments in yas-text"
;; ;;   (let* ((args (python-split-args yas-text))
;; ;; 	 (nr 0)
;; ;;          (format-arg (lambda(arg)
;; ;; 		       (concat (nth 0 arg) " : " (if (nth 1 arg) ", optional") (if make-fields (format "  ${%d:type%d}" (cl-incf nr) nr )) "\n"))) 
;; ;; 	 args
;; ;; 	 indent)
;; ;;          (formatted-params (mapconcat format-arg args "\n"))
;; ;;          (formatted-ret (mapconcat format-arg (list (list "out")) "\n")))
;; ;;     (unless (string= formatted-params "")
;; ;;       (mapconcat 'identity
;; ;;                  (list "\nParameters\n----------" formatted-params
;; ;;                        "Returns\n-------" formatted-ret)
;; ;;                  "\n"))))

;; ;;(setq yas-triggers-in-field t)


;; ;; remove creating backup files
(setq make-backup-files nil)


