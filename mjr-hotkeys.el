(define-key global-map [(control z)] 'undo)

(defun dired-current-buffer()
  (interactive)
  (dired nil)
)

(global-set-key [f11] 'dired-current-buffer)

;; tabbar navigation
(global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
(global-set-key (kbd "M-<left>") 'tabbar-backward-tab)
(global-set-key (kbd "M-<up>") 'tabbar-forward-group)
(global-set-key (kbd "M-<down>") 'tabbar-backward-group)


;; moving through windows
(define-key global-map (kbd "C-x <up>") 'windmove-up)
(define-key global-map (kbd "C-x <down>") 'windmove-down)
(define-key global-map (kbd "C-x <left>") 'windmove-left)
(define-key global-map (kbd "C-x <right>") 'windmove-right)

(define-key global-map (kbd "C-v") 'yank)


;;;
; Ctrl-F4 to close tab
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer))
)

(global-set-key [(control f4)] 'kill-current-buffer)


(define-key global-map [f2] 'save-buffer)
(define-key global-map [f1 f1] 'delete-other-windows)
(define-key global-map (kbd "C-x C-1") 'delete-other-windows)
(define-key global-map (kbd "C-x C-2") 'split-window-horizontally)
(define-key global-map (kbd "C-x C-3") 'split-window-vertically)
(define-key global-map [f7] 'flymake-mode)

;;;
; Commenting
(defun my-comment-or-uncomment-region (arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not mark-active) (save-excursion (beginning-of-line) (not (looking-at "\\s-*$"))))
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  (comment-dwim arg)))

(global-set-key (kbd "C-/") 'my-comment-or-uncomment-region)


;; Full-screen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))
(define-key global-map [f12] 'toggle-fullscreen)



;;;
; Flymake
;
(defun flymake-errors-on-current-line ()
  "Return the errors on the current line or nil if none exist"
  (let* ((line-no (flymake-current-line-no)))
    (nth 0 (flymake-find-err-info flymake-err-info line-no))))


(defun flymake-display-err-message-for-current-line ()
  "Display a message with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (message-data        (flymake-make-err-menu-data line-no line-err-info-list)))
    (if message-data (progn (princ (car message-data) t)
                            (mapcar (lambda (m)
                                      (terpri t)
                                      (princ (caar m) t))
                                    (cdr message-data)))
      (flymake-log 1 "no errors for line %d" line-no))))

(defun flymake-load-and-check-if-not-loaded (trigger-type)
  "If flymake is not loaded, load and start a check and return t. Otherwise return nil."
  (if flymake-mode
      nil
    (flymake-mode-on-without-check)
    (flymake-start-syntax-check trigger-type)
    t))

(defun show-next-flymake-error ()
  "Load flymake.el if necessary. Jump to next error and display it."
  (interactive)
  (when (not (flymake-load-and-check-if-not-loaded "edit"))
    ;; if the cursor is on an error line and the user didn't just
    ;; cycle through error lines, just show the error of the current
    ;; line and don't skip to the next one
    (when (or (member last-command '(show-next-flymake-error show-prev-flymake-error))
              (not (flymake-errors-on-current-line)))
      (flymake-goto-next-error))
    (flymake-display-err-message-for-current-line)))

(defun show-prev-flymake-error ()
  "Jump to the previous flymake error and display it"
  (interactive)
  (when (not (flymake-load-and-check-if-not-loaded "edit"))
    (flymake-goto-prev-error)
    (flymake-display-err-message-for-current-line)))

;; (global-set-key

(global-set-key (kbd "S-SPC") 'flymake-display-err-message-for-current-line)
(global-set-key (kbd "C-<down>") 'show-next-flymake-error)
(global-set-key (kbd "C-<up>") 'show-prev-flymake-error)

