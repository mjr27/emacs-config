;; Loading django
(require 'django-html-mode)
(require 'django-mode)

(add-to-list 'auto-mode-alist '("\\.html?$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . django-mode))

(yas/load-directory "~/.emacs.d/django-mode/snippets")


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
	       '("\\.py\\'" flymake-pylint-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)
