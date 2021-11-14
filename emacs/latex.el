(auctex-latexmk-setup)
(latex-preview-pane-enable)
(setq TeX-PDF-mode t)


;;; AUCTeX

;; spell check
(add-hook 'TeX-mode-hook 'flyspell-mode)

;; support \ref{} and \cite{}
(add-hook 'TeX-mode-hook 'turn-on-reftex)


