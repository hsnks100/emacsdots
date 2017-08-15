;;; ~/.emacs 에 다음을 수정 또는 추가하세요
(custom-set-variables
'(default-input-method "korean-hangul390")) ;; 세벌식 390
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" default)))
 '(package-selected-packages
   (quote
    (neotree evil-magit use-package tabbar solarized-theme rainbow-delimiters popwin paredit magit evil-leader dirtree airline-themes))))
	;; 세벌식 390
;; load emacs 24's package system. Add MELPA repository.

(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/") package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(load-theme 'deeper-blue) 


(use-package evil
  :ensure t
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)
    (setq evil-want-C-u-scroll t)


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
	  "gc" 'magit-commit
	  "gp" 'magit-push-current-to-pushremote
	  "gs" 'magit-status

	  "d" 'kill-this-buffer
	  "fed" (lambda() (interactive) (find-file "~/.emacs.d/init.el"))
	  "feR" (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
	  )))

    ;; boot evil by default
    (evil-mode 1))
  :config
  ;; {{ make IME compatible with evil-mode 
  ) 

(use-package paredit
  :ensure t
  )

(use-package neotree
  :ensure t
  :config
   (add-hook 'neotree-mode-hook
	     (lambda ()
	       (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
	       (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
	       (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	       (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
   (global-set-key [f8] 'neotree-toggle)



  )
(use-package rainbow-delimiters
  :ensure t
  :config

  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'text-mode-hook #'rainbow-delimiters-mode)

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



(use-package evil-magit
  :ensure t
  :config
  ;; (define-key evil-normal-state-local-minor-mode (kbd "C-j") nil)
  )

(use-package powerline :ensure t
  :init 
  :config (progn
	    (use-package airline-themes :ensure t
			  :config
			  (load-theme 'airline-cool) 
			  )
	    ))
  
(use-package tabbar :ensure t
  :init 
  :config
  (tabbar-mode t)
  )


(defun under-comment (ARG)
  (interactive)
  (comment-dwim ARG)
  )

(define-key evil-normal-state-map "_" 'comment-line)
(define-key evil-visual-state-map "_" 'comment-dwim)
(define-key evil-normal-state-map (kbd "C-j") 'tabbar-backward-tab)
(define-key evil-normal-state-map (kbd "C-k") 'tabbar-forward-tab)
(define-key evil-normal-state-map (kbd "<f4>") 'dirtree)
(setq scroll-step            1
      scroll-conservatively  10000)
(setq scroll-margin 10)




