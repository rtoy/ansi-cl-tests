;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Oct 12 09:24:36 2002
;;;; Contains: Tests for LET, LET*

(in-package :cl-test)

;;; LET and LET* are also heavily exercised in the many other tests.

;;; NOTE!  Some of these tests bind a variable with the same name
;;; more than once.  This apparently has underdetermined semantics that
;;; varies in different Lisps.

(deftest let.1
  (let ((x 0)) x)
  0)

(deftest let.2
  (let ((x 0) (y 1)) (values x y))
  0 1)

(deftest let.3
  (let ((x 0) (y 1)) (declare (special x y)) (values x y))
  0 1)

(deftest let.4
  (let ((x 0))
    (let ((x 1))
      x))
  1)

(deftest let.5
  (let ((x 0))
    (let ((#:x 1))
      x))
  0)

(deftest let.6
  (let ((x 0))
    (declare (special x))
    (let ((x 1))
      (values x (locally (declare (special x)) x))))
  1 0)

(deftest let.7
  (let ((x '(a b c)))
    (declare (dynamic-extent x))
    x)
  (a b c))

(deftest let.8
  (let ((x 0) (x 1)) x)
  1)

(deftest let.9
  (let (x y z) (values x y z))
  nil nil nil)

(deftest let.10
  (let ((x 1) x) x)
  nil)

(deftest let.11
  (let ((x 1))
    (list x
	  (let (x x x)
	    (declare (special x))
	    x)
	  x))
  (1 nil 1))

(deftest let.12
  (let ((x 0))
    (values
     (let ((x 20)
	   (x (1+ x)))
       x)
     x))
  1 0)

(deftest let.13
  (flet ((%f () (declare (special x))
	     (if (boundp 'x) x 10)))
    (let ((x 1)
	  (x (1+ (%f))))
      (declare (special x))
      x))
  11)

;;; Tests for LET*

(deftest let*.1
  (let* ((x 0)) x)
  0)

(deftest let*.2
  (let* ((x 0) (y 1)) (values x y))
  0 1)

(deftest let*.3
  (let* ((x 0) (y 1)) (declare (special x y)) (values x y))
  0 1)

(deftest let*.4
  (let* ((x 0))
    (let* ((x 1))
      x))
  1)

(deftest let*.5
  (let* ((x 0))
    (let* ((#:x 1))
      x))
  0)

(deftest let*.6
  (let* ((x 0))
    (declare (special x))
    (let* ((x 1))
      (values x (locally (declare (special x)) x))))
  1 0)

(deftest let*.7
  (let* ((x '(a b c)))
    (declare (dynamic-extent x))
    x)
  (a b c))

(deftest let*.8
  (let* ((x 0) (x 1)) x)
  1)

(deftest let*.9
  (let* (x y z) (values x y z))
  nil nil nil)

(deftest let*.10
  (let* ((x 1) x) x)
  nil)

(deftest let*.11
  (let* ((x 1))
    (list x
	  (let* (x x x)
	    (declare (special x))
	    x)
	  x))
  (1 nil 1))

(deftest let*.12
  (let* ((x 1)
	 (y (1+ x))
	 (x (1+ y))
	 (z (+ x y)))
    (values x y z))
  3 2 5)

(deftest let*.13
  (flet ((%f () (declare (special x)) x))
    (let* ((x 1)
	   (x (1+ (%f))))
      (declare (special x))
      x))
  2)