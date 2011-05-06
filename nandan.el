

;; (when (boundp 'aquamacs-version)
;;   (one-buffer-one-frame-mode))

;; If I want the original files location, I use this, otherwise
;; I've put the old files into vendors/oldAquamacs
;; (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;      (let* ((my-lisp-dir "~/nb/elisp-and-emacs/")
;;            (default-directory my-lisp-dir))
;;         (setq load-path (cons my-lisp-dir load-path))
;;         (normal-top-level-add-subdirs-to-load-path)))

;; (require 'nunb)
;; (require 'lisper)
(lp)
(global-set-key [C-o] 'other-window)

(defn G74204 [])
(switch-to-buffer "*Messages*")


;;; From http://stackoverflow.com/questions/5168262/emacs-write-buffer-to-new-file-but-keep-this-file-open

(defun save-as (new-filename)
  (interactive "FFilename:")
  ;; overwrites file, unfortunately.
  (let* ((fnid (gensym)))
    (insert (format "(defn %s []" fnid))
    (write-region (region-beginning) (region-end) new-filename "append")
    (insert ")")))

(global-set-key (kbd "<f2>w") 'save-as)
 (defn G74205 [])

;; (defn G74202 [])
(defun refactor-fn (new-filename)
  (interactive "FFilename:")
  (let* ((fnid (gensym))
	 (text (delete-and-extract-region (region-beginning) (region-end))))
    (with-current-buffer  (find-file-noselect new-filename)
      (goto-char (point-max))
      (insert (format "(defn %s []
                           %s )" fnid  
			  text))
      (newline)
      (with-temp-message "Writing file..."
	(save-buffer))
      (message "Writing file...done"))))

(global-set-key (kbd "<f2>w") 'extractfn)

 
 
(global-set-key (kbd "<f2>w") 'extractfn)

(unwind-protect
    (let (retval)
      (condition-case ex
          (setq retval (whiler))
        ('error (message (format "Caught exception: [%s]" ex))))
        retval)
  (message "Cleaning up...")
 
(defun whiler ()
  (while t
    (re-search-forward "mini")))

(unwind-protect
    (whiler)
  (message "Done!"))

	 
;; From  http://curiousprogrammer.wordpress.com/2009/06/08/error-handling-in-emacs-lisp/
(defmacro safe-wrap (fn &rest clean-up)
  `(unwind-protect
       (let (retval)
         (condition-case ex
             (setq retval (progn ,fn))
           ('error
            (message (format "Caught exception: [%s]" ex))
            (setq retval (cons 'exception (list ex)))))
         retval)
     ,@clean-up))


(defun extract-last-kill (new-filename)
  "Extract last kill into new file, replacing with gensym"
  (let* ((fnid (gensym))
	 (text (yank))
    (with-current-buffer  (find-file-noselect new-filename)
      (goto-char (point-max))
      (insert (format "(defn %s []
                           %s )" fnid  
			  text))
      (newline)
      (with-temp-message "Extracting to file..."
	(save-buffer))
      (message "Writing file...done"))))


(defun whiler (filename regx)
  (while t
    (re-search-forward regx)
    (paredit-backword-up)
    (paredit-kill)
    (extract-last-kill filename))))


(defn move-all-sexps-to (filename)
  (let* ((reg (read-from-minibuffer "sexp regex? "))
	 (fil (read-from-minibuffer "filename? ")))
    (safe-wrap (whiler fil reg)
	       (message "Refactoring finished, yays!"))))
