;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Wed Jul 28 00:20:46 2004
;;;; Contains: Tests of format with ~| directive

(in-package :cl-test)

(deftest format.page.1
  (format nil "~0|")
  "")

(deftest format.page.2
  (let ((s (format nil "~|")))
    (cond
     ((string= s "") nil)
     ((> (length s) 1) (values s :too-long))
     (t
      (let ((c (elt s 0)))
	(loop for i from 2 to 100
	      for s = (format nil (format nil "~~~D|" i))
	      unless (and (= (length s) i)
			  (every #'(lambda (c2) (char= c c2)) s))
	      collect i)))))
  nil)

(deftest format.page.3
  (let ((s (format nil "~|")))
    (cond
     ((string= s "") nil)
     ((> (length s) 1) (values s :too-long))
     (t
      (let ((c (elt s 0)))
	(loop for i from 2 to 100
	      for s = (format nil "~v|" i)
	      unless (and (= (length s) i)
			  (every #'(lambda (c2) (char= c c2)) s))
	      collect i)))))
  nil)

(deftest format.page.4
  (format nil "~V|" 0)
  "")

(deftest format.page.5
  (string=t (format nil "~v|" nil)
	    (format nil "~|"))
  t)

  
	