;;; init.el --- Simplified and Organized Emacs Configuration

;; Package Management Setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package f
  :ensure t)


;; Refresh package contents before installing
(unless package-archive-contents
  (package-refresh-contents))

;; Package List
;; Install and configure packages with use-package
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t))
(use-package auctex-latexmk
  :after tex
  :config
  (auctex-latexmk-setup))

(use-package auctex-latexmk)
(use-package auto-complete)
(use-package better-defaults)
(use-package blacken)
(use-package company)
(use-package company-auctex)
(use-package company-bibtex)
(use-package company-box)
(use-package company-shell)
(use-package conda)
(use-package deferred)
(use-package dracula-theme)
(use-package elpy)
(use-package epc)
(use-package exec-path-from-shell)
(use-package fill-column-indicator)
(use-package flycheck)
(use-package flycheck-grammarly)
(use-package flyspell)
(use-package jedi)
(use-package latex-preview-pane)
(use-package lsp-mode)
(use-package markdown-mode)
(use-package material-theme)
(use-package numpydoc)
(use-package org)
(use-package py-autopep8)
(use-package pyenv-mode)
(use-package python-environment)
(use-package rainbow-delimiters)
(use-package web-mode)
(use-package windmove)
(use-package yaml-mode)
(use-package yasnippet)


;;; User Information
(setq user-full-name "Pedram Tavadze"
      user-mail-address "petavazohi@gmail.com")

;;; Performance Tuning
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

;;; UI Tweaks
(tool-bar-mode -1)
(setq require-final-newline t)
(delete-selection-mode t)
;; (global-linum-mode t)
;; (setq linum-format "%4d \u2502 ")
;; (global-display-line-numbers-mode t)
(if (>= emacs-major-version 29)
    (global-display-line-numbers-mode t)
  (global-linum-mode t))
(load-theme 'material t)

;;; Editing Enhancements
(electric-pair-mode 1)
(show-paren-mode 1)
(global-hl-line-mode 1)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;; Load External Files and Mode-Specific Configurations
(load "~/.emacs.d/local" t)
(load "~/.emacs.d/f90" t)
(load "~/.emacs.d/bash" t)
(load "~/.emacs.d/vasp-mode" t)
(add-hook 'latex-mode-hook (lambda () (load "~/.emacs.d/latex" t)))
(add-hook 'python-mode-hook (lambda () (load "~/.emacs.d/python" t)))

;;; Custom Function Definitions
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if no region is selected."
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (region-active-p)
      (setq start (region-beginning) end (region-end)))
    (comment-or-uncomment-region start end)))

;;; Keybindings
;; for emacs C-/ is sent to C-_ so for C-/ to work we need to bind it with C-_
(global-set-key (kbd "C-_") 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'recompile)

(global-set-key (kbd "C-<left>")  'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-<up>")    'windmove-up)
(global-set-key (kbd "C-<down>")  'windmove-down)


(global-set-key (kbd "C-<prior>") 'previous-buffer)
(global-set-key (kbd "C-<next>") 'next-buffer)


(global-set-key (kbd "C-a") 'mark-whole-buffer)

(global-set-key (kbd "C-l") 'display-line-numbers-mode)
(global-set-key (kbd "C-q") 'display-fill-column-indicator-mode)
;; (global-set-key (kbd "C-w") 'kill-buffer)
(global-set-key (kbd "C-o") 'find-file)
;; (global-set-key (kbd "C-x \\\"") 'split-window-below)
;; (global-set-key (kbd "C-x %") 'split-window-right)
;; (global-set-key (kbd "C-x -") 'split-window-below)
;; (global-set-key (kbd "C-x _") 'split-window-right)
;; (global-set-key (kbd "C-g")  'flycheck-list-errors)

;; Add more keybindings as needed...

;;; Additional Settings and Hooks
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq make-backup-files nil)

;;; init.el ends here
