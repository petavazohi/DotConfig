;;; local python settings ----
;;; Commentary :


;;; Code:
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq jedi:environment-root "jedi")

(require 'numpydoc)
(define-key python-mode-map (kbd "C-c C-n") 'numpydoc-generate)
(setq numpydoc-insert-examples-block nil)


;; (add-hook 'python-mode-hook 'python-lsp-mode)

;; (setq yas-triggers-in-field t)

