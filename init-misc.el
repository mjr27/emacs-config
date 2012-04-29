(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;;;
; Do not complie scss
(setq scss-compile-at-save nil)


(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            ))
