;;; this file is made by ptshe
;; emacs's config-file
;; emacs-version is 26.3
;; any question do not ask me

;;; Code:
(custom-set-variables
 '(blink-cursor-mode nil)
 '(frame-background-mode (quote light))
 '(scroll-bar-mode nil)
 )

(custom-set-faces
 ;; '(comint-highlight-prompt ((t (:inherit cyan))))
 '(cursor ((t (:background "wheat"))))
 '(minibuffer-prompt ((t (:foreground "cyan")))))

(set-background-color "black")
(set-foreground-color "white")
(set-face-foreground 'region "yellow")
(set-face-background 'region "blue")

;; close menu and tool bar
;; use "M-x menu-bar-mode" to re-show menu bar
(menu-bar-mode '-1)
(if (not (equal (getenv "HOSTTYPE") "sparc"))
    (tool-bar-mode '-1)
)

;; show line-num
(global-linum-mode 1)
(setq column-number-mode t)

;; line don't wrap
(add-hook 'hack-local-variables-hook (lambda () (setq truncate-lines t)))

;; simple hook mode
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(global-set-key (kbd "M-[") 'hs-hide-block)
(global-set-key (kbd "M-]") 'hs-show-block)
(global-set-key (kbd "C-M-[") 'hs-hide-all)
(global-set-key (kbd "C-M-]") 'hs-show-all)

;; change some key-kbd
(global-set-key(kbd "M-/") 'set-mark-command)
(global-set-key(kbd "C-z") 'undo)
(global-set-key(kbd "C-p") 'replace-string)
(global-set-key(kbd "M-p") 'query-replace)
(global-set-key [f4] 'kill-current-buffer)
(global-set-key [f5] 'goto-line)
(global-set-key [S-f6] 'buffer-menu)
(global-set-key [f6] 'switch-to-prev-buffer)
(global-set-key [f7] 'switch-to-next-buffer)
(global-set-key [f8] 'bookmark-set)
(global-set-key [f9] 'bookmark-jump)
(global-set-key(kbd "C-t") 'comment-or-uncomment-region)


;; change start screen (not perfact)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)

(shell)
(rename-buffer "shell-ori")
(switch-to-buffer "shell-ori")
(delete-other-windows)

(fset 'yes-or-no-p 'y-or-n-p)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (cl-letf (((symbol-function #'process-list) (lambda ())))
    ad-do-it))

;; tab
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 8)
(setq-default tab-width 8)
(setq c-default-style "linux")
(setq backward-delete-char-untabify-method nil)

;; save ...
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq auto-save-default nil)
(setq backup-by-copying nil)
(setq make-backup-files nil)
(setq backup-directory-alist (quote(("." . "~/ptshe/.emacs-backup"))))

;; color-theme
(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/color-theme/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-pok-wob)

;; multiple-cursors
(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/multiple-cursors/")
(require 'multiple-cursors)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "M-<return> a") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "M-<return> e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-<return>") 'set-rectangular-region-anchor)

;; show time
(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)
(display-time)

;; font
;;iiiiiiiiii
;;wwwwwwwwww
;; (set-face-attribute 'default t :font "-DAMA-Ubuntu Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default t :font "-DAMA-Ubuntu Mono-normal-italic-normal-*-18-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default t :font "-1ASC-Liberation Mono-normal-italic-normal-*-17-*-*-*-m-0-iso10646-1")
;; sudo apt install ttf-dejavu
(set-face-attribute 'default t :font "-PfEd-DejaVu Sans Mono-normal-oblique-normal-*-16-*-*-*-m-0-iso10646-1")


(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; --------- ido mode ------------
;;(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/ido-goto/")
;;(require 'ido-goto)
(ido-mode t)

;; ------------ corsshairs --------------------
(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/crosshairs/")
(require 'crosshairs)
(setq col-highlight-vline-face-flag nil)
(crosshairs-mode)
(global-set-key (kbd "C-x +") 'crosshairs-highlight)
(global-set-key (kbd "C-x -") 'crosshairs-unhighlight)
(global-set-key (kbd "C-x *") 'crosshairs-mode)

;; ---------- flycheck ---------
(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/flycheck/")
(require 'flycheck)
(global-flycheck-mode t)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; ------------ auto-cpmplete ----------
(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/auto-complete/")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "/home/ptshe/.emacs.d/plugins/auto-complete/dict/")

(require 'fuzzy)
(setq ac-fuzzy-enable t)

(require 'auto-complete-config)
(ac-config-default)

;;(require 'popup)
(require 'pos-tip)
(setq ac-quick-help-prefer-pos-tip t)

(require 'auto-complete-clang)
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
   /usr/include/c++/7
   /usr/include/x86_64-linux-gnu/c++/7
   /usr/include/c++/7/backward
   /usr/lib/gcc/x86_64-linux-gnu/7/include
   /usr/local/include
   /usr/lib/gcc/x86_64-linux-gnu/7/include-fixed
   /usr/include/x86_64-linux-gnu
   /usr/include
  "
               )))

;; ---------- matlab edit mode -----------
(add-to-list 'load-path "/home/ptshe/.emacs.d/plugins/matlab-emacs/")
(require 'matlab)
;;(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))

;;(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
;;(add-to-list
;; 'auto-mode-alist
;; '("\\.m$" . matlab-mode))
;;(setq matlab-indent-function t)
;;(setq matlab-shell-command "matlab")


;; --------------- my macro ----------------
(global-set-key [f1] 'defining-kbd-macro)
(global-set-key [f2] 'end-kbd-macro)
(global-set-key [f3] 'kmacro-end-and-call-macro)
(load-file "/home/ptshe/.emacs.d/my-macro/my-macro.el")
(global-set-key(kbd "M-<up>") 'up-spt)
(global-set-key(kbd "M-<down>") 'down-spt)
(global-set-key(kbd "M-d") 'clear-shell-window)
(global-set-key [f12] 'all-tab)

;; --------- font scaler --------------------
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)






;;; .emacs.el ends here
