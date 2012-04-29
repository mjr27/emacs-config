(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'flymake)

(when (load "flymake" t)
  (defun flymake-js-init (&optional trigger-type)
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name)))
	   )
      (list js-executable (list (expand-file-name (concat basedir "jslint_runner.js")) (expand-file-name (concat basedir "jslint/jslint.js")) local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.js\\'" flymake-js-init))
)
