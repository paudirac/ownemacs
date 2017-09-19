;; remove visual clutter
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; sensible defaults
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8)

;; writting
(setq sentence-end-double-space nil)
(setq default-fill-column 80)

;; backups
;;   delete excess backup versions silently
;;   use version control
;;   make backups file even when in version controlled dir
;;   which directory to put backups file
;;   don't ask for confirmation when opening symlinked file
;;   transform backups file name
(setq delete-old-versions t  
      kept-new-versions 6
      kept-old-versions 2
      version-control t      
      vc-make-backup-files t 
      backup-directory-alist `(("." . "~/.emacs.d/backups")) 
      vc-follow-symlinks t 
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))) 

(setq initial-scratch-message
      ";; A few years ago, while visiting or, rather, rummaging about Emacs, 
;; the author of this config found, in an obscure nook of one of the 
;; infinite blogs, the following code, engraved by hand upon the startup 
;; screen:
;;
;;        CODE
;;
;; These ASCII capitals, black with age, and quite deeply graven in the virtual 
;; stone, with I know not what signs peculiar to Terminal caligraphy imprinted 
;; upon their forms and upon their attitudes, as though with the purpose of 
;; revealing that it had been a hand of the 70s which had inscribed them there,
;; and especially the fatal and melancholy meaning contained in them, struck 
;; the author deeply.
;; He questioned himself; he sought to divine who could have been that soul in 
;; torment which had not been willing to quit this world without leaving this 
;; stigma of crime or unhappiness upon the brow of the ancient editor.
;;
;; It is upon this word that this config is founded.
;; September, 2017.") 

;; packages via package & use-package
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("org" . "http://orgmode.org/elpa/")
	("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; my own emacs experimenting starts here
;; packages
(use-package evil :ensure t)
(evil-mode)
(use-package ivy :ensure t)
(ivy-mode 1)
;(use-package ranger :ensure t)
(use-package which-key :ensure t)
(which-key-mode)
(use-package magit :ensure t)
(use-package projectile :ensure t
  :init
  (setq projectile-keymap-prefix "SPC p"))
(use-package counsel-projectile :ensure t)
(use-package rainbow-delimiters :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))
(use-package smartparens :ensure t
  :init
  (add-hook 'racket-mode-hook 'smartparens-mode)
  :config
  (require 'smartparens-config)
  (turn-on-show-smartparens-mode))
(use-package racket-mode :ensure t
  :config
  (smartparens-mode t)
  (message "running racket mode"))
(use-package paredit :ensure t)
(use-package evil-paredit :ensure t
  :init
  (add-hook 'racket-mode-hook 'evil-paredit-mode))

;; key bindingss
(general-define-key
 "C-s" 'swiper
 "M-s" 'counsel-M-x
 :prefix "C-c"
 "f" '(:ignore t :which-key "files")
 "ff" 'counsel-find-file
 "fr" 'counsel-recentf
 )

(use-package general :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   "'" '(iterm-focus :which-key "iterm")
   "?" '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
   "/" 'counsel-ag
   "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "SPC" '(avy-goto-word-or-subword-1 :which "go to char")
   "b" 'ivy-switch-buffer

   "f" '(:ignore t :which-key "files")
   "ff" 'counsel-find-file
   "fr" 'counsel-recentf

   "p" '(:ignore t :which-key "project")
   "pf" '(counsel-projectile-find-file :which-key "find a project file")
   "pd" '(counsel-projectile-find-dir :which-key "find a project directory")
   "pb" 'counsel-projectile-switch-to-buffer

   "s" 'swiper
   "m" 'menu-bar-mode

   "g" '(:ignore t :which-key "magit")
   "gs" 'magit-status

   "k" '(:ignore t :which-key "paredit")
   "kb" 'paredit-forward-barf-sexp
   "ks" 'paredit-forward-slurp-sexp
 
   "a" '(:ignore t :which-key "Applications")
   "ar" 'ranger
   "ad" 'dired))


;; theme
(use-package zenburn-theme :ensure t
  :config
  (load-theme 'zenburn :no-confirm t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zenburn-theme which-key use-package smartparens ranger rainbow-delimiters magit general evil counsel-projectile avy anti-zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
