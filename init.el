(setq use-package-always-ensure t)
;;; ~/.emacs 에 다음을 수정 또는 추가하세요
 ;; 세벌식 390

	;; 세벌식 390
;; load emacs 24's package system. Add MELPA repository.


(package-initialize)
(add-to-list 'package-archives '("melpa stable" . "https://stable.melpa.org/packages/"))
;;(add-to-list 'package-archives '("melpa china" . "http://elpa.emacs-china.org/melpa-stable/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(require 'package)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(load-theme 'deeper-blue) 

(modify-syntax-entry ?_ "w") 
(global-linum-mode t)

(use-package bison-mode)

(use-package evil
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
      (defun clean ()
	(interactive)
	(defvar foo)
	(setq foo (concat "make clean"))
	(compile foo)
	;; (call-interactively 'compile)
	;; compile
	;; (compile nil)
	;; (shell-command foo)
	)
      (defun build ()
	(interactive)
	(defvar foo)
	(setq foo (concat "make"))
	(compile foo)
	;; (call-interactively 'compile)
	;; compile
	;; (compile nil)
	;; (shell-command foo)
	)
      (progn
	(evil-leader/set-leader "<SPC>") 
	(setq evil-leader/in-all-states t)
	;; keyboard shortcuts
	(evil-leader/set-key
	  "A" 'ff-find-other-file
	  "gc" 'magit-commit
	  "gp" 'magit-push-current-to-pushremote
	  "gs" 'magit-status

	  "d" 'kill-this-buffer
	  "fed" (lambda() (interactive) (find-file "~/.emacs.d/init.el"))
	  "feR" (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
	  "bb" 'build
	  "bc" 'clean
	  )))

    ;; boot evil by default
    (evil-mode 1))
  :config
  ;; {{ make IME compatible with evil-mode 
  ) 

(use-package paredit
  )

(use-package neotree
  :config
   (add-hook 'neotree-mode-hook
	     (lambda ()
	       (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
	       (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
	       (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	       (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
	       (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
	       
             ))
   (global-set-key [f8] 'neotree-toggle)



  )
(use-package rainbow-delimiters
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

(use-package ac-helm
  :init 
  :config
  (ac-config-default)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  )


(use-package evil-magit
  :config
  ;; (define-key evil-normal-state-local-minor-mode (kbd "C-j") nil)
  )

(use-package powerline
  :init 
  :config (progn
	    (use-package airline-themes 
			  :config
			  (load-theme 'airline-cool) 
			  )
	    ))
  
(use-package tabbar 
  :init 
  :config
  (tabbar-mode t)
   (setq tabbar-buffer-groups-function
           (lambda ()
            (list "All")))
  )

(use-package sr-speedbar
  :init
  :config
  (speedbar-add-supported-extension ".y")

  
  )
(use-package cmake-ide
  :config
  (cmake-ide-setup))
(defun my-tabbar-buffer-groups () ;; customize to show all normal files in one group
  "Returns the name of the tab group names the current buffer belongs to.
 There are two groups: Emacs buffers (those whose name starts with '*', plus
 dired buffers), and the rest.  This works at least with Emacs v24.2 using
 tabbar.el v1.7."
  (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
	      ((eq major-mode 'dired-mode) "emacs")
	      (t "user"))))
(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)




(defun under-comment (ARG)
  (interactive)
  (comment-dwim ARG)
  )

(define-key evil-normal-state-map (kbd "<f4>") 'neotree)
(defun insert-ret ()
  (interactive)
  (insert "\n")
  )

;; (define-key evil-normal-state-map (kbd "<S-return>") ((lambda() (interactive) (insert "\n"))))
(define-key evil-normal-state-map (kbd "<S-return>") 'insert-ret)

(define-key evil-normal-state-map "_" 'comment-line)
(define-key evil-visual-state-map "_" 'comment-dwim)
;; (define-key evil-normal-state-map (kbd "C-j") 'tabbar-backward-tab)
;; (define-key evil-normal-state-map (kbd "C-k") 'tabbar-forward-tab)
(global-set-key  (kbd "C-j") 'tabbar-backward-tab)
(global-set-key  (kbd "C-k") 'tabbar-forward-tab)
;; (global-set-key  (kbd "S-<ret>") ((lambda()(insert "\n"))))
(setq scroll-step            1
      scroll-conservatively  10000)
(setq scroll-margin 10)





(defun perl-on-buffer ()
  (interactive)
  (shell-command-on-region (point-min) (point-max) "perl" "*Perl Output*")
  (display-buffer "*Perl Output*"))

(eval-after-load 'perl-mode
  '(define-key perl-mode-map (kbd "C-c C-c") 'perl-on-buffer))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Run C programs directly from within emacs


;; (global-set-key (kbd "C-<S-b>") 'build)
(setq c-default-style "k&r") 
(setq-default indent-tabs-mode nil)
(global-auto-revert-mode t)


(add-hook 'c-mode-common-hook
	  '(lambda ()
         
	     (setq tab-width 4
		   indent-tabs-mode nil
		   indent-level 4
		   c-basic-offset 4)))

(setq x-select-enable-clipboard nil)



(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode)
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; 
    (define-key helm-map (kbd "M-x") 'helm-M-x)
    (define-key helm-map (kbd "C-x C-b") 'helm-buffers-list)



    )
  :config
  

    )
(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" default)))
 '(inhibit-startup-screen t))

