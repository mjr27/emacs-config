(require 'tabbar)

(defun tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
 This function is a custom function for tabbar-mode's tabbar-buffer-groups.
 This function group all buffers into 3 groups:
 Those Dired, those user buffer, and those emacs buffer.
 Emacs buffer are those starting with “*”."
  (list
   (cond
    ((string-equal "*" (substring (buffer-name) 0 1))
     "X"
     )
    ((eq major-mode 'dired-mode)
     "Dired"
     )
    (t
     (if (and (stringp mode-name) (string-match "[^ ]" mode-name))
	 mode-name
       (symbol-name major-mode)
       )
     )
    )
   )
  )

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
(tabbar-mode 1)

(setq EmacsPortable-global-tabbar 't) ; If you want tabbar
(setq EmacsPortable-popup-menu nil) ; If you want a popup menu.
(setq EmacsPortable-popup-toolbar nil) ; If you want a popup toolbar

(eval-and-compile
  (defalias 'tabbar-display-update
    (if (fboundp 'force-window-update)
        #'(lambda () (force-window-update (selected-window)))
      'force-mode-line-update)))


(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (interactive)
  (setq ad-return-value
	(with-current-buffer (tabbar-tab-value tab)
	  (if (and (buffer-modified-p)
		   (buffer-file-name))
	      (concat "* " ad-return-value)
	    ad-return-value
	    )
	  )
	)
  )

(defun mjr-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update)
  )
(defun mjr-on-buffer-modification ()
  (set-buffer-modified-p t)
  (mjr-modification-state-change))

(add-hook 'after-save-hook 'mjr-modification-state-change)
(add-hook 'after-revert-hook 'mjr-modification-state-change)
(add-hook 'first-change-hook 'mjr-on-buffer-modification)
