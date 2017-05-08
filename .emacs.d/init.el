;;; package --- Summary:
;;; Commentary:

;;; Code:
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives '
             ("melpa-stable" . "http://stable.melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant


;; Path for things I add manually rather then thorugh a package manager
(let ((default-directory  "~/.emacs.d/addons"))
  (normal-top-level-add-subdirs-to-load-path))

;; Keybinds
(global-set-key (kbd "<f6>")
                (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

(global-set-key [f8] 'neotree-toggle)
(global-set-key [f9] 'neotree-dir)

(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-unix-mode))
;; Requires
(use-package org-bullets)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package typescript
  :mode ("\\.ts\\'" . typescript-mode)
  :config
  (add hook 'typescript-mode-hook
       (lambda ()
         (tide-setup)
         (flycheck-mode +1)
          (flycheck-mode +1)
          (setq flycheck-check-syntax-automatically '(save mode-enabled))
          (eldoc-mode +1)
          (tide-hl-identifier-mode +1)
          (company-mode +1)
         )
       )
  )


(use-package darktooth-theme
  :ensure t
  :init
  (load-theme 'darktooth t))

;; (use-package solarized-theme
;;   :init
;;   (load-theme 'solarized t))

;; (use-package zenburn-theme
;;   :init
;;   (load-theme 'zenburn t))

;; Icon package
(use-package all-the-icons :ensure t)

(use-package powerline :ensure t)

(use-package spaceline
  :after powerline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

;; (use-package spaceline-all-the-icons
;;   :after spaceline
;;   :config (spaceline-all-the-icons-theme))

;; (use-package spacemacs-theme
;;   :ensure t
;;   :init
;;   (load-theme 'spacemacs-light t))

;; (use-package base16-theme
;;   :ensure t
;;   :init
;;   ;; (load-theme 'base16-eighties t)
;;   (load-theme 'base16-flat)
;;   ;;(load-theme 'base16-gruvbox-dark-soft)
;;   )

;; (use-package challenger-deep-theme
;;   :ensure t
;;   :init
;;   ;; (load-theme 'base16-eighties t)
;;   (load-theme 'challenger-deep t)
;;   ;;(load-theme 'base16-gruvbox-dark-soft)
;;   )


(scroll-bar-mode -1)



;;(spaceline-toggle-battery-on)

;; Fuck this shit right now
;; Requirement of Spaceline
;; (use-package powerline
;;   :ensure t
;;   :config

;;   ;; Mode line
;;   (use-package spaceline-config
;;     :ensure spaceline
;;     :config

;;     ;; Custom (iconized) spaceline theme
;;     (use-package spaceline-all-the-icons
;;       :load-path "spaceline"
;;       :config
;;       (use-package spaceline-colors
;;         :load-path "spaceline"
;;         :init (add-hook 'after-init-hook 'spaceline-update-faces)
;;         :config (advice-add 'load-theme :after 'spaceline-update-faces)

;;         (setq-default powerline-default-separator 'nil)
;;         (setq-default mode-line-format '("%e" (:eval (spaceline-ml-ati))))))))



;;ido config
(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode t)
  )



;;company mode
(use-package company
  :ensure t
  :defer t
  :init
  (global-company-mode)
  (add-to-list 'company-dabbrev-code-modes 'typescript-mode))
;;(add-hook 'after-init-hook 'global-company-mode)


;;neo-tree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  
  (setq flycheck-checkers '(javascript-eslint))
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  )

(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil))



(use-package fill-column-indicator
  :init
  (setq-default fill-column 80)
  :config
  (setq fci-rule-column 80)
  (setq fci-rule-width 1)
  (define-globalized-minor-mode global-fci-mode fci-mode
    (lambda () (if (or (derived-mode-p 'prog-mode) (eq major-mode 'text-mode))
                   (progn
                     (setq fci-rule-color "#8cd0d3")
                     (fci-mode 1)))
      ))
  (global-fci-mode 1))


;; Configuration for fill-column
;; (setq fci-rule-column 80)
;; (setq fci-rule-color "#8cd0d3")
;; (setq fci-rule-width 1)
;; (define-globalized-minor-mode global-fci-mode fci-mode
;;   (lambda () (if (or (derived-mode-p 'prog-mode) (eq major-mode 'text-mode))
;;                  (progn (setq fci-rule-color "#8cd0d3") (fci-mode 1)))))
;; (global-fci-mode 1)

;;fci-config for company mode compatibility
;; (defvar-local company-fci-mode-on-p nil)

;; (defun company-turn-off-fci (&rest ignore)
;;   (when (boundp 'fci-mode)
;;     (setq company-fci-mode-on-p fci-mode)
;;     (when fci-mode (fci-mode -1))))

;; (defun company-maybe-turn-on-fci (&rest ignore)
;;   (when company-fci-mode-on-p (fci-mode 1)))

;; (add-hook 'company-completion-started-hook 'company-turn-off-fci)
;; (add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
;; (add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)

;; LaTeX Editing
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(add-hook 'LaTex-mode-hook 'LaTex-math-mode)

;; Different Styles for Different Programming languages

;; https://github.com/tibbe/haskell-style-guide
(defun haskell-style ()
  "To be added to `haskell-mode-hook'."
  (interactive)
  (setq tab-width 4
        haskell-indentation-layout-offset 4
        haskell-indentation-left-offset 4
        haskell-indentation-ifte-offset 4))

(add-hook 'haskell-mode-hook 'haskell-style)
;; (add-hook 'haskell-mode-hook 'intero-mode)





;; Add any desired theme directory to the ding theme directories
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")

;;Load desired theme
;;(load-theme 'theme-name-here t)

;;Get rid of trash taking up my screen
(menu-bar-mode -1)
(tool-bar-mode -1)

;;Line numbers
;;(require 'linum-off)
;;(global-linum-mode t)

;;TabsAreEvil
(setq-default indent-tabs-mode nil)

;;Org mode config
(setq org-ellipsis "⤵")
(setq org-log-done 'time)
(add-hook 'org-mode-hook(lambda () (org-bullets-mode t)))

;;(add-hook 'org-mode-hook 'turn-on-auto-fill)
;;(global-set-key (kbd "C-c q") 'auto-fill-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-indent-environment-list
   (quote
    (("algorithmic" LaTeX-indent-tabular)
     ("tikzpicture" LaTeX-indent-tabular)
     ("verbatim" current-indentation)
     ("verbatim*" current-indentation)
     ("tabular" LaTeX-indent-tabular)
     ("tabular*" LaTeX-indent-tabular)
     ("align" LaTeX-indent-tabular)
     ("align*" LaTeX-indent-tabular)
     ("array" LaTeX-indent-tabular)
     ("eqnarray" LaTeX-indent-tabular)
     ("eqnarray*" LaTeX-indent-tabular)
     ("displaymath")
     ("equation")
     ("equation*")
     ("picture")
     ("tabbing"))))
 '(ansi-color-names-vector
   ["#2c3e50" "#e74c3c" "#2ecc71" "#f1c40f" "#3498db" "#9b59b6" "#3498db" "#e0e0e0"])
 '(ansi-term-color-vector
   [unspecified "#2c3e50" "#e74c3c" "#2ecc71" "#f1c40f" "#3498db" "#9b59b6" "#3498db" "#e0e0e0"])
 '(custom-safe-themes
   (quote
    ("a0dc0c1805398db495ecda1994c744ad1a91a9455f2a17b59b716f72d3585dde" "c9321e2db48a21fc656a907e97ee85d8cd86967855bf0bed3998bcf9195c758b" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "10e231624707d46f7b2059cc9280c332f7c7a530ebc17dba7e506df34c5332c4" "deaf0dad46995bc682dd0acf1f0327cab82f1cf0025755ebb1bab714d0a6e8d3" "2d32455b3acc27bef4dc912f74c14a371cf7167a075bbd4f90ac14e761359e5b" "93268bf5365f22c685550a3cbb8c687a1211e827edc76ce7be3c4bd764054bad" "73ad471d5ae9355a7fa28675014ae45a0589c14492f52c32a4e9b393fcc333fd" "cabc32838ccceea97404f6fcb7ce791c6e38491fd19baa0fcfb336dcc5f6e23c" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "f5512c02e0a6887e987a816918b7a684d558716262ac7ee2dd0437ab913eaec6" default)))
 '(js-curly-indent-offset 1)
 '(js-indent-level 2)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (spaceline-all-the-icons darktooth-theme dracula-theme nord-theme challenger-deep-theme base16-theme projectile gruvbox-theme rust-mode tide spacemacs-theme fancy-battery use-package spaceline all-the-icons neotree color-theme-solarized solarized-theme ensime magit js2-mode auctex intero fill-column-indicator haskell-mode paradox sublime-themes color-theme-sanityinc-tomorrow zenburn-theme)))
 '(paradox-github-token t)
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(typescript-indent-level 2)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))

;;; init.el ends here


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
