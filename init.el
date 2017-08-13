;; load emacs 24's package system. Add MELPA repository.
(require 'package)
(add-to-list
 'package-archives
 ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
 '("melpa" . "http://melpa.milkbox.net/packages/")
 t)
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(setq use-package-verbose t)
(use-package evil
  :ensure t
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)

    ;; leader shortcuts

    ;; This has to be before we invoke evil-mode due to:
    ;; https://github.com/cofi/evil-leader/issues/10
    (use-package evil-leader
      :init (global-evil-leader-mode)
      :config
      (progn
	(evil-leader/set-leader "<SPC>") 
	(setq evil-leader/in-all-states t)
        ;; keyboard shortcuts
        (evil-leader/set-key
          "a" 'ag-project
          "A" 'ag
          "b" 'ido-switch-buffer
          "c" 'mc/mark-next-like-this
          "C" 'mc/mark-all-like-this
          "e" 'er/expand-region
          "E" 'mc/edit-lines
          "fed" 'ido-find-file
          "g" 'magit-status
          "i" 'idomenu
          "j" 'ace-jump-mode
          "k" 'kill-buffer
          "K" 'kill-this-buffer
          "o" 'occur
          "p" 'magit-find-file-completing-read
          "r" 'recentf-ido-find-file
          "s" 'ag-project
          "t" 'bw-open-term
          "T" 'eshell
          "w" 'save-buffer
          "x" 'smex
          )))

    ;; boot evil by default
    (evil-mode 1))
  )

(use-package paraedit
  :ensure t
  )

(use-package dirtree
  :ensure t
  )


(evil-define-operator evil-delete-char-without-register (beg end type reg)
  "delete character without yanking unless in visual mode"
  :motion evil-forward-char
  (interactive "<R><y>")
  (if (evil-visual-state-p)
    (evil-delete beg end type reg)
    (evil-delete beg end type ?_)))


(define-key evil-normal-state-map (kbd "x") 'evil-delete-char-without-register) 

(defun evil-paste-after-from-0 ()
  (interactive)
  (let ((evil-this-register ?0))
    (call-interactively 'evil-paste-after)))

(define-key evil-visual-state-map "p" 'evil-paste-after-from-0)

(use-package magit
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "gc") 'magit-commit)
  
  
  )



