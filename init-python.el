;; Loading django
(require 'django-html-mode)
(require 'django-mode)

(add-to-list 'auto-mode-alist '("\\.html?$" . django-html-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . django-mode))

(yas/load-directory "~/.emacs.d/django-mode/snippets")

(require 'html-helper-mode)

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

(define-derived-mode django-html-mode html-mode  "django-html"
  "Major mode for editing Django html templates (.djhtml).

\\{django-html-mode-map}"
  :group 'django-html

  ;; it mainly from nxml-mode font lock setting
  (set (make-local-variable 'font-lock-defaults)
       '((django-html-font-lock-keywords)
         nil t nil nil
         (font-lock-syntactic-keywords
          . html-helper-font-lock-keywords))))


(defconst django-html-font-lock-keywords
  (append
   html-helper-font-lock-keywords

   `(;; comment
     (,(rx (eval django-html-open-comment)
           (1+ space)
           (0+ (not (any "#")))
           (1+ space)
           (eval django-html-close-comment))
      . font-lock-comment-face)

     ;; variable font lock
     (,(rx (eval django-html-open-variable)
           (1+ space)
           (group (0+ (not (any "}"))))
           (1+ space)
           (eval django-html-close-variable))
      (1 font-lock-variable-name-face))

     ;; start, end keyword font lock
     (,(rx (group (or (eval django-html-open-block)
                      (eval django-html-close-block)
                      (eval django-html-open-comment)
                      (eval django-html-close-comment)
                      (eval django-html-open-variable)
                      (eval django-html-close-variable))))
      (1 font-lock-builtin-face))

     ;; end prefix keyword font lock
     (,(rx (eval django-html-open-block)
           (1+ space)
           (group (and "end"
                       ;; end prefix keywords
                       (or "autoescape" "block" "blocktrans" "cache" "comment"
                           "filter" "for" "if" "ifchanged" "ifequal"
                           "ifnotequal" "spaceless" "trans" "with")))
           (1+ space)
           (eval django-html-close-block))
      (1 font-lock-keyword-face))

     ;; more words after keyword
     (,(rx (eval django-html-open-block)
           (1+ space)
           (group (or "autoescape" "block" "blocktrans" "cache" "comment"
                      "cycle" "debug" "else" "empty" "extends" "filter" "firstof" "for"
                      "if" "ifchanged" "ifequal" "ifnotequal" "include"
                      "load" "now" "regroup" "spaceless" "ssi" "templatetag"
                      "trans" "url" "widthratio" "with"))

           ;; TODO: is there a more beautiful way?
           (0+ (not (any "}")))

           (1+ space)
           (eval django-html-close-block))
      (1 font-lock-keyword-face))

     ;; TODO: if specific cases for supporting "or", "not", and "and"

     ;; for sepcific cases for supporting in
     (,(rx (eval django-html-open-block)
           (1+ space)
           "for"
           (1+ space)

           (group (1+ (or word ?_ ?.)))

           (1+ space)
           (group "in")
           (1+ space)

           (group (1+ (or word ?_ ?.)))

           (group (? (1+ space) "reverse"))

           (1+ space)
           (eval django-html-close-block))
      (1 font-lock-variable-name-face) (2 font-lock-keyword-face)
      (3 font-lock-variable-name-face) (4 font-lock-keyword-face)))))
