;; Loading django
(when (load "flymake" t)
  (defun flymake-pylint-init (&optional trigger-type)
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name)))
           (options (when trigger-type (list "--trigger-type" trigger-type))))
      (list python-executable (append (list (expand-file-name (concat basedir "flymake-python/pyflymake.py"))) options (list local-file )))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init))
  ;; Do not lint html
  (delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
  )
(add-hook 'find-file-hook 'flymake-find-file-hook)


(defun init-python-callback ()
  (set-variable 'py-indent-offset 4)
  (set-variable 'indent-tabs-mode nil)
  (define-key python-mode-map (kbd "RET") 'newline-and-indent)
  (auto-complete-mode t)
  )
(add-hook 'python-mode-hook 'init-python-callback)

(require 'pony-mode)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

