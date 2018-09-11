(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(set-face-attribute 'default nil :height 160)
(menu-bar-mode -1) 
(toggle-scroll-bar 1) 
(tool-bar-mode -1) 
(setq use-package-always-ensure t)

(package-initialize)
(add-to-list 'package-archives '("melpa stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa china" . "http://elpa.emacs-china.org/melpa-stable/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")) 
(require 'package)

(use-package alect-theme :init :config)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

(load-theme 'alect-light-alt t)
;; (load-theme 'deeper-blue) 
(set-language-environment "Korean")
(setq default-input-method "korean-hangul390") 
(setq default-input-method "korean-hangul3f") 
(prefer-coding-system 'utf-8)
(global-set-key (kbd "<Multi_key>") 'toggle-input-method) 
(defun under-comment (ARG)
  (interactive)
  (comment-dwim ARG)
  )
;; (modify-syntax-entry ?_ "w") 
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
	(evil-leader/set-leader "\\") 
	(setq evil-leader/in-all-states t)
	;; keyboard shortcuts
	(evil-leader/set-key
	  ;; "g" 'cscope-find-global-definition-no-prompting
	  "g" 'cscope-find-this-symbol
	  "A" 'ff-find-other-file
	  "d" 'kill-this-buffer
	  "fed" (lambda() (interactive) (find-file "~/.emacs.d/init.el"))
	  "feR" (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
	  "bb" 'build
	  "bc" 'clean
	  "e" 'cscope-find-egrep-pattern
	  "c" 'cscope-find-called-functions
	  
	  )))

    ;; boot evil by default
    (evil-mode 1))
  :config
  ;; {{ make IME compatible with evil-mode 
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

(use-package xcscope     ;; see ~/.emacs.d/elpa/xcscope-readme.txt
  :ensure xcscope
  :init (cscope-setup))
(use-package powerline
  :init 
  :config (progn
	    (use-package airline-themes 
			  :config
			  ;; (load-theme 'airline-cool) 
			  )
	    ))
(use-package tabbar 
  :init 
  :config
   (setq tabbar-buffer-groups-function
           (lambda ()
            (list "All")))
  )


;; (use-package abyss-theme :init :config)
;; (use-package dracula-theme :init :config)
;; provide the default key binding 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "d8dc153c58354d612b2576fea87fe676a3a5d43bcc71170c62ddde4a1ad9e1fb" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" default)))
 '(global-linum-mode t)
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (alect-theme alect-themes abyss-theme dracula-theme tabbar airline-themes powerline use-package neotree evil-leader)))
 '(scroll-conservatively 1000)
 '(scroll-margin 3)
 '(tabbar-mode t nil (tabbar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(define-key evil-normal-state-map (kbd "[") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd "]") 'evil-scroll-down)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "<up>") 'evil-window-increase-height)
(define-key evil-normal-state-map (kbd "<down>") 'evil-window-decrease-height)
(define-key evil-normal-state-map "_" 'comment-line)
(define-key evil-visual-state-map "_" 'comment-dwim)
(global-set-key  (kbd "C-k") 'tabbar-backward-tab)
(global-set-key  (kbd "C-j") 'tabbar-forward-tab)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (define-key cscope-list-entry-keymap (kbd "<return>") 'cscope-select-entry-one-window)

 (defun my-cscope-self-mode-hook()
   ;; (interactive)
(define-key cscope-list-entry-keymap (kbd "<return>") 'cscope-select-entry-one-window)
)
;;   (local-set-key "o"   'cscope-select-entry-other-window)
;;   (local-set-key (kbd "<RET>") 'cscope-select-entry-one-window)
;;   )
(add-hook 'cscope-list-entry-hook 'my-cscope-self-mode-hook)
(add-hook 'c-mode-hook 'global-linum-mode)
(add-hook 'c-mode-hook 'tabbar-mode)
 


