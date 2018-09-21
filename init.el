;; (add-hook 'after-init-hook 'global-color-identifiers-mode)
; from enberg on #emacs

(require 'package)
(add-to-list 'package-archives '("melpa stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa china" . "http://elpa.emacs-china.org/melpa-stable/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")) 
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(use-package alect-themes 
             :ensure t 
             :init :config)

;; (load-theme 'alect-light-alt t)
;(load-theme 'dracula t)
;; (load-theme 'deeper-blue) 
;; (set-language-environment "Korean")

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
                 :ensure t
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
                              (setq foo (concat "make -j8"))
                              (compile foo)
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
             :ensure t
             :config
             (progn 
               (global-set-key [f8] 'neotree-refresh)
               (add-hook 'neotree-mode-hook
                         (lambda ()
                           (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                           (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
                           (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                           (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
                           (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
                           (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
                           (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
                           (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
                           (define-key evil-normal-state-local-map (kbd "mr") 'neotree-rename-node)
                           (define-key evil-normal-state-local-map (kbd "ma") 'neotree-create-node)
                           (define-key evil-normal-state-local-map (kbd "md") 'neotree-delete-node)
                           (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))
               )


             )

(use-package company;; see ~/.emacs.d/elpa/xcscope-readme.txt
             :ensure t
             :init
             )
(use-package xcscope     ;; see ~/.emacs.d/elpa/xcscope-readme.txt
             :ensure t
             :init
             (cscope-setup))
(use-package powerline
             :ensure t
             :init 
             :config (progn
                       (use-package airline-themes 
                         :ensure t
                                    :config
                                    ;; (load-theme 'airline-cool) 
                                    )
                       ))
(use-package tabbar 
             :ensure t
             :init 
             :config
             (setq tabbar-buffer-groups-function
                   (lambda ()
                     (list "All")))
             (setq *tabbar-ignore-buffers* '("*Help*" ".bbdb" "diary"))
             )


(use-package helm 
             :ensure t
             :init 
             (use-package helm-swoop
               :ensure t
                          :init 
                          :config
                          )
             :config
             )
(use-package auto-complete 
             :ensure t
             :init 
             :config
             (ac-config-default) 
             (define-key ac-complete-mode-map "\C-n" 'ac-next)
             (define-key ac-complete-mode-map "\C-p" 'ac-previous)
             (setq ac-auto-show-menu    0.2)
             (setq ac-delay             0.2)
             (setq ac-menu-height       20)
             (setq ac-auto-start t)
             (setq ac-show-menu-immediately-on-auto-complete t)
             )

;; (use-package abyss-theme :init :config)
;; (use-package dracula-theme :init :config)
;; provide the default key binding 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
;; (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
;; (define-key evil-normal-state-map (kbd "<up>") 'evil-window-increase-height)
;; (define-key evil-normal-state-map (kbd "<down>") 'evil-window-decrease-height)
(define-key evil-normal-state-map (kbd "[") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd "]") 'evil-scroll-down)
(define-key evil-normal-state-map "_" 'comment-line)
(define-key evil-visual-state-map "_" 'comment-dwim)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-visual-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-visual-state-map (kbd "k") 'evil-previous-visual-line)
(global-set-key  (kbd "C-o") 'evil-jump-backward)
(global-set-key  (kbd "C-k") 'tabbar-backward-tab)
(global-set-key  (kbd "C-j") 'tabbar-forward-tab)
(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-l") 'evil-window-right) 
(global-set-key (kbd "C-<up>") 'evil-window-increase-height)
(global-set-key (kbd "C-<down>") 'evil-window-decrease-height)
(global-set-key (kbd "C-<right>") 'evil-window-increase-width)
(global-set-key (kbd "C-<left>") 'evil-window-decrease-width)
(define-key evil-normal-state-map ";a" 'ff-find-other-file)



(add-hook 'lisp-interaction-mode-hook (lambda() 
                                        (local-unset-key (kbd "C-j"))
                                        ))


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
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil) 

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))


(setq compilation-finish-function
      (lambda (buf str)
        (if (null (string-match ".*exited abnormally.*" str))
          ;;no errors, make the compilation window go away in a few seconds
          (progn
            (run-at-time
              "2 sec" nil 'delete-windows-on
              (get-buffer-create "*compilation*"))
            (message "No Compilation Errors!")))))
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(set-face-attribute 'default nil :height 160)
(menu-bar-mode -1) 
(toggle-scroll-bar 1) 
(tool-bar-mode -1) 
(global-auto-revert-mode t)
(setq use-package-always-ensure t)
(setq default-input-method "korean-hangul390") 
(prefer-coding-system 'utf-8)
(global-set-key (kbd "<Multi_key>") 'toggle-input-method) 
(defun under-comment (ARG)
  (interactive)
  (comment-dwim ARG))

(add-hook 'help-mode-hook 'tabbar-local-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete helm tabbar powerline xcscope company neotree evil alect-themes use-package))))
