;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sat Mar 28 07:33:20 1998
;;;; Contains:  Tests of ADJOIN

(in-package :cl-test)

(deftest adjoin.1
  (adjoin 'a nil)
  (a))

(deftest adjoin.2
  (adjoin nil nil)
  (nil))

(deftest adjoin.3
  (adjoin 'a '(a))
  (a))

;; Check that a NIL :key argument is the same as no key argument at all
(deftest adjoin.4
  (adjoin 'a '(a) :key nil)
  (a))

(deftest adjoin.5
  (adjoin 'a '(a) :key #'identity)
  (a))

(deftest adjoin.6
  (adjoin 'a '(a) :key 'identity)
  (a))

(deftest adjoin.7
  (adjoin (1+ 11) '(4 3 12 2 1))
  (4 3 12 2 1))

;; Check that the test is EQL, not EQ (by adjoining a bignum)
(deftest adjoin.8
  (adjoin (1+ 999999999999) '(4 1 1000000000000 3816734 a "aa"))
  (4 1 1000000000000 3816734 a "aa"))

(deftest adjoin.9
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a))
  ("aaa" aaa "AAA" "aaa" #\a))

(deftest adjoin.10
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a) :test #'equal)
  (aaa "AAA" "aaa" #\a))

(deftest adjoin.11
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a) :test 'equal)
  (aaa "AAA" "aaa" #\a))

(deftest adjoin.12
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a)
	  :test-not (complement #'equal))
  (aaa "AAA" "aaa" #\a))

(deftest adjoin.14
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a)
	  :test #'equal :key #'identity)
  (aaa "AAA" "aaa" #\a))

(deftest adjoin.15
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a)
	  :test 'equal :key #'identity)
  (aaa "AAA" "aaa" #\a))

;; Test that a :key of NIL is the same as no key at all
(deftest adjoin.16
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a)
	  :test #'equal :key nil)
  (aaa "AAA" "aaa" #\a))

;; Test that a :key of NIL is the same as no key at all
(deftest adjoin.17
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a)
	  :test 'equal :key nil)
  (aaa "AAA" "aaa" #\a))

;; Test that a :key of NIL is the same as no key at all
(deftest adjoin.18
  (adjoin (copy-seq "aaa") '(aaa "AAA" "aaa" #\a)
	  :test-not (complement #'equal) :key nil)
  (aaa "AAA" "aaa" #\a))

;;; Ordering in comparison function

(deftest adjoin.19
  (adjoin 10 '(1 2 3) :test #'<)
  (10 1 2 3))

(deftest adjoin.20
  (adjoin 10 '(1 2 3) :test #'>)
  (1 2 3))

(deftest adjoin.21
  (adjoin 10 '(1 2 3) :test-not #'>)
  (10 1 2 3))

(deftest adjoin.22
  (adjoin 10 '(1 2 3) :test-not #'<)
  (1 2 3))


(deftest adjoin.order.1
  (let ((i 0) w x y z)
    (values
     (adjoin (progn (setf w (incf i)) 'a)
	     (progn (setf x (incf i)) '(b c d a e))
	     :key (progn (setf y (incf i)) #'identity)
	     :test (progn (setf z (incf i)) #'eql))
     i w x y z))
  (b c d a e)
  4 1 2 3 4)

(deftest adjoin.order.2
  (let ((i 0) w x y z p)
    (values
     (adjoin (progn (setf w (incf i)) 'a)
	     (progn (setf x (incf i)) '(b c d e))
	     :test-not (progn (setf y (incf i)) (complement #'eql))
	     :key (progn (setf z (incf i)) #'identity)
	     :key (progn (setf p (incf i)) nil))
     i w x y z p))
  (a b c d e)
  5 1 2 3 4 5)

(deftest adjoin.allow-other-keys.1
  (adjoin 'a '(b c) :bad t :allow-other-keys t)
  (a b c))

(deftest adjoin.allow-other-keys.2
  (adjoin 'a '(b c) :allow-other-keys t :foo t)
  (a b c))

(deftest adjoin.allow-other-keys.3
  (adjoin 'a '(b c) :allow-other-keys t)
  (a b c))

(deftest adjoin.allow-other-keys.4
  (adjoin 'a '(b c) :allow-other-keys nil)
  (a b c))

(deftest adjoin.allow-other-keys.5
  (adjoin 'a '(b c) :allow-other-keys t :allow-other-keys nil 'bad t)
  (a b c))

(deftest adjoin.repeat-key
  (adjoin 'a '(b c) :test #'eq :test (complement #'eq))
  (a b c))					      

(deftest adjoin.error.1
  (classify-error (adjoin))
  program-error)

(deftest adjoin.error.2
  (classify-error (adjoin 'a))
  program-error)

(deftest adjoin.error.3
  (classify-error (adjoin 'a '(b c) :bad t))
  program-error)

(deftest adjoin.error.4
  (classify-error (adjoin 'a '(b c) :allow-other-keys nil :bad t))
  program-error)

(deftest adjoin.error.5
  (classify-error (adjoin 'a '(b c) 1 2))
  program-error)

(deftest adjoin.error.6
  (classify-error (adjoin 'a '(b c) :test))
  program-error)

(deftest adjoin.error.7
  (classify-error (adjoin 'a '(b c) :test #'identity))
  program-error)

(deftest adjoin.error.8
  (classify-error (adjoin 'a '(b c) :test-not #'identity))
  program-error)

(deftest adjoin.error.9
  (classify-error (adjoin 'a '(b c) :key #'cons))
  program-error)

(deftest adjoin.error.10
  (classify-error (adjoin 'a (list* 'b 'c 'd)))
  type-error)

