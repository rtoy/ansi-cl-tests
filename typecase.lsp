;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Fri Oct 18 22:51:25 2002
;;;; Contains: Tests for TYPECASE

(in-package :cl-test)

(deftest typecase.1
  (typecase 1 (integer 'a) (t 'b))
  a)

(deftest typecase.2
  (typecase 1 (symbol 'a))
  nil)

(deftest typecase.3
  (typecase 1 (symbol 'a) (t 'b))
  b)

(deftest typecase.4
  (typecase 1 (t (values))))

(deftest typecase.5
  (typecase 1 (integer (values)) (t 'a)))

(deftest typecase.6
  (typecase 1 (bit 'a) (integer 'b))
  a)

(deftest typecase.7
  (typecase 1 (otherwise 'a))
  a)

(deftest typecase.8
   (typecase 1 (t (values 'a 'b 'c)))
   a b c)

(deftest typecase.9
   (typecase 1 (integer (values 'a 'b 'c)) (t nil))
   a b c)

(deftest typecase.10
  (let ((x 0))
    (values
     (typecase 1
       (bit     (incf x)   'a)
       (integer (incf x 2) 'b)
       (t       (incf x 4) 'c))
     x))
  a 1)

(deftest typecase.11
   (typecase 1 (otherwise 'a))
   a)

(deftest typecase.12
  (typecase 1 (integer) (t 'a))
  nil)

(deftest typecase.13
  (typecase 1 (symbol 'a) (t))
  nil)

(deftest typecase.14
  (typecase 1 (symbol 'a) (otherwise))
  nil)

(deftest typecase.15
  (typecase 'a
    (number 'bad)
    (#.(find-class 'symbol nil) 'good))
  good)

(deftest typecase.16
  (block done
    (tagbody
     (typecase 'a (symbol (go 10)
			  10
			  (return-from done 'bad)))
     10
     (return-from done 'good)))
  good)

(deftest typecase.17
  (block done
    (tagbody
     (typecase 'a
       (integer 'bad)
       (t (go 10)
	  10
	  (return-from done 'bad)))
     10
     (return-from done 'good)))
  good)

(deftest typecase.error.1
  (signals-error (funcall (macro-function 'typecase)) program-error)
  t)

(deftest typecase.error.2
  (signals-error (funcall (macro-function 'typecase)
			   '(typecase t)) program-error)
  t)

(deftest typecase.error.3
  (signals-error (funcall (macro-function 'typecase)
			   '(typecase t)
			   nil nil) program-error)
  t)



