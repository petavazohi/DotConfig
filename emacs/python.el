;;; local python settings ----
;;; Commentary :


;;; Code:
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq jedi:environment-root "jedi")

(require 'numpydoc)
(define-key python-mode-map (kbd "C-c C-n") 'numpydoc-generate)
(setq numpydoc-insert-examples-block nil)


;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq compile-command "python")

;; (elpy-enable)

;; ;; Use IPython for REPL
;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;; 	     "ipython")

;; (add-hook 'python-mode-hook 'python-lsp-mode)

;; (setq yas-triggers-in-field t)

