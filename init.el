(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "./")
(set 'basedir "~/.emacs.d/")
(setq nfsdir basedir)

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

(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-step 1)
(global-hl-line-mode 1)
(setq display-time-interval 1)
(setq display-time-format "%H:%M:%S")


(global-linum-mode 1)

(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)


(setq c-basic-offset 2)
(setq js-indent-level 2)




(if (equal window-system 'w32)
  (load-file "init-windows.el")
  (load-file "init-linux.el")
  )

(load-file "init-python.el")
(load-file "init-js.el")

(load-file "mjr-hotkeys.el")

(load-file "mjr-tabbar.el")

(load-file "mjr-colors.el")


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
 '(cua-mode t nil (cua-base))
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
 '(tool-bar-mode nil)
 '(x-select-enable-clipboard t))

