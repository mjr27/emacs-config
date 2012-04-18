(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "./")
(set 'basedir "~/.emacs.d/")
(setq nfsdir basedir)
(setq load-path (cons basedir load-path))
(let ((default-directory basedir))
  (normal-top-level-add-subdirs-to-load-path))

;; line numbers
(require 'linum)

;; buffer switching
(require 'iswitchb)


;; Auto-completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat basedir "ac-dict"))
(ac-config-default)
(defun run-autocomplete ()
  (interactive)
  (ac-config-default)
  )
(global-auto-complete-mode t)


;;
; Whitespaces @ eol trimming
(require 'ws-trim)
(global-ws-trim-mode t)
(set-default 'ws-trim-level 2)
(setq ws-trim-global-modes '(guess (not message-mode eshell-mode)))
(add-hook 'ws-trim-method-hook 'joc-no-tabs-in-python-hook)
(defun joc-no-tabs-in-python-hook ()
  "WS-TRIM Hook to strip all tabs in python/javascript"
  (interactive)
  (if (string= major-mode "python-mode")
      (ws-trim-tabs))
  (if (string= major-mode "js2-mode")
      (ws-trim-tabs))
  (if (string= major-mode "django-mode")
      (ws-trim-tabs))
  )

;;
; YaSnippet
(require 'yasnippet)
(yas/load-directory (concat basedir "yasnippet/snippets"))
(yas/initialize)


;;
; Visial tuning
(setq scroll-margin 5)
(setq scroll-conservatively 50)
(setq scroll-preserve-screen-position 't)
(setq file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq comment-style 'indent)

;;;
; easy confirmations
(fset 'yes-or-no-p 'y-or-n-p)

;;;
; no current line highlighting
(global-hl-line-mode nil)

(setq scroll-step 1)
(setq display-time-interval 1)
(setq display-time-format "%H:%M:%S")


(global-linum-mode 1)

(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)

;;;
; Starting server
(require 'server)
(when (and (= emacs-major-version 23)
           (= emacs-minor-version 1)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                        ; ~/.emacs.d/server is unsafe"
                                        ; on windows.
(server-start)

(if (equal window-system 'w32)
  (load "init-windows.el")
  (load "init-linux.el")
  )

(load "init-python.el")
(load "init-js.el")
(load "init-misc.el")

(load "mjr-functions.el")

(load "mjr-hotkeys.el")


(load "mjr-tabbar.el")

(load "mjr-colors.el")


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-auto-start nil)
 '(ac-ignore-case nil)
 '(ac-trigger-key nil)
 '(backup-inhibited t t)
 '(blink-cursor-delay 0.3)
 '(blink-cursor-mode nil)
 '(current-language-environment "UTF-8")
 '(debug-on-error t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(js2-cleanup-whitespace t)
 '(js2-global-externs (list "exports" "template"))
 '(js2-mode-show-strict-warnings t)
 '(require-final-newline t)
 '(show-paren-mode t)
 '(tabbar-cycle-scope (quote tabs))
 '(tabbar-separator (quote (1)))
 '(tabbar-use-images nil)
 '(tool-bar-mode nil)
 '(x-select-enable-clipboard t))


(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(tabbar-button ((t (:inherit tabbar-default :box (:line-width 1 :color "grey50")))))
 '(tabbar-default ((t (:inherit variable-pitch :background "grey50" :foreground "#000d13" :box (:line-width 5 :color "grey50") :weight bold :family "Liberation Mono"))))
 '(tabbar-highlight ((t nil)))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#000D13" :foreground "#ffffff" :box (:line-width 5 :color "#000d13")))))
 '(tabbar-separator ((t (:inherit tabbar-default))))
 '(tabbar-unselected ((t (:inherit tabbar-default :box (:line-width 5 :color "grey50"))))))
(put 'dired-find-alternate-file 'disabled nil)
