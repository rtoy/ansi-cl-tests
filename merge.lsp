;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Fri Sep  6 07:24:17 2002
;;;; Contains: Tests for MERGE

(in-package :cl-test)

(deftest merge-list.1
  (let ((x (list 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'list x y #'<))
  (1 2 3 4 5 7 8 8 10 11))

(deftest merge-list.2
  (let ((x nil)
	(y (list 2 4 5 8 11)))
    (merge 'list x y #'<))
  (2 4 5 8 11))

(deftest merge-list.3
  (let ((x nil)
	(y (list 2 4 5 8 11)))
    (merge 'list y x #'<))
  (2 4 5 8 11))

(deftest merge-list.4
  (merge 'list nil nil #'<)
  nil)

(deftest merge-list.5
  (let ((x (vector 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'list x y #'<))
  (1 2 3 4 5 7 8 8 10 11))

(deftest merge-list.6
  (let ((x (list 1 3 7 8 10))
	(y (vector 2 4 5 8 11)))
    (merge 'list x y #'<))
  (1 2 3 4 5 7 8 8 10 11))

(deftest merge-list.7
  (let ((x (vector 1 3 7 8 10))
	(y (vector 2 4 5 8 11)))
    (merge 'list x y #'<))
  (1 2 3 4 5 7 8 8 10 11))

(deftest merge-list.8
  (let ((x (sort (list 1 3 7 8 10) #'>))
	(y (sort (list 2 4 5 8 11) #'>)))
    (merge 'list x y #'< :key #'-))
  (11 10 8 8 7 5 4 3 2 1))

(deftest merge-list.9
  (let ((x (list 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'list x y #'< :key nil))
  (1 2 3 4 5 7 8 8 10 11))

(deftest merge-list.10
  (let ((x (list 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'list x y '<))
  (1 2 3 4 5 7 8 8 10 11))

(deftest merge-list.11
  (let ((x (vector)) (y (vector)))
    (merge 'list x y #'<))
  nil)

(deftest merge-list.12
  (let ((x nil) (y (vector 1 2 3)))
    (merge 'list x y #'<))
  (1 2 3))

(deftest merge-list.13
  (let ((x (vector)) (y (list 1 2 3)))
    (merge 'list x y #'<))
  (1 2 3))

(deftest merge-list.14
  (let ((x nil) (y (vector 1 2 3)))
    (merge 'list y x #'<))
  (1 2 3))

(deftest merge-list.15
  (let ((x (vector)) (y (list 1 2 3)))
    (merge 'list y x #'<))
  (1 2 3))

;;; Tests yielding vectors

(deftest merge-vector.1
  (let ((x (list 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'vector x y #'<))
  #(1 2 3 4 5 7 8 8 10 11))

(deftest merge-vector.2
  (let ((x nil)
	(y (list 2 4 5 8 11)))
    (merge 'vector x y #'<))
  #(2 4 5 8 11))

(deftest merge-vector.3
  (let ((x nil)
	(y (list 2 4 5 8 11)))
    (merge 'vector y x #'<))
  #(2 4 5 8 11))

(deftest merge-vector.4
  (merge 'vector nil nil #'<)
  #())

(deftest merge-vector.5
  (let ((x (vector 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'vector x y #'<))
  #(1 2 3 4 5 7 8 8 10 11))

(deftest merge-vector.6
  (let ((x (list 1 3 7 8 10))
	(y (vector 2 4 5 8 11)))
    (merge 'vector x y #'<))
  #(1 2 3 4 5 7 8 8 10 11))

(deftest merge-vector.7
  (let ((x (vector 1 3 7 8 10))
	(y (vector 2 4 5 8 11)))
    (merge 'vector x y #'<))
  #(1 2 3 4 5 7 8 8 10 11))

(deftest merge-vector.8
  (let ((x (sort (list 1 3 7 8 10) #'>))
	(y (sort (list 2 4 5 8 11) #'>)))
    (merge 'vector x y #'< :key #'-))
  #(11 10 8 8 7 5 4 3 2 1))

(deftest merge-vector.9
  (let ((x (list 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'vector x y #'< :key nil))
  #(1 2 3 4 5 7 8 8 10 11))

(deftest merge-vector.10
  (let ((x (list 1 3 7 8 10))
	(y (list 2 4 5 8 11)))
    (merge 'vector x y '<))
  #(1 2 3 4 5 7 8 8 10 11))

(deftest merge-vector.11
  (let ((x (vector)) (y (vector)))
    (merge 'vector x y #'<))
  #())

(deftest merge-vector.12
  (let ((x nil) (y (vector 1 2 3)))
    (merge 'vector x y #'<))
  #(1 2 3))

(deftest merge-vector.13
  (let ((x (vector)) (y (list 1 2 3)))
    (merge 'vector x y #'<))
  #(1 2 3))

(deftest merge-vector.14
  (let ((x nil) (y (vector 1 2 3)))
    (merge 'vector y x #'<))
  #(1 2 3))

(deftest merge-vector.15
  (let ((x (vector)) (y (list 1 2 3)))
    (merge 'vector y x #'<))
  #(1 2 3))

(deftest merge-vector.16
  (let ((x (make-array '(10) :initial-contents '(2 5 8 9 11 12 14 15 18 30)
		       :fill-pointer 5))
	(y (list 1 6 10)))
    (merge 'vector x y #'<))
  #(1 2 5 6 8 9 10 11))

(deftest merge-vector.16a
  (let ((x (make-array '(10) :initial-contents '(2 5 8 9 11 12 14 15 18 30)
		       :fill-pointer 5))
	(y (list 1 6 10)))
    (merge 'vector y x #'<))
  #(1 2 5 6 8 9 10 11))

(deftest merge-vector.17
  (let* ((x (make-array '(10) :initial-contents '(2 5 8 9 11 12 14 15 18 30)
			:fill-pointer 5))
	 (result (merge 'vector x () #'<)))
    (values
     (array-element-type result)
     result))
  t
  #(2 5 8 9 11))

;;; Tests on strings

(deftest merge-string.1
  (let ((x (list #\1 #\3 #\7 #\8))
	(y (list #\2 #\4 #\5 #\9)))
    (merge 'string x y #'char<))
  "12345789")

(deftest merge-string.1a
  (let ((x "1378")
	(y (list #\2 #\4 #\5 #\9)))
    (merge 'string x y #'char<))
  "12345789")

(deftest merge-string.1b
  (let ((x (list #\1 #\3 #\7 #\8))
	(y "2459"))
    (merge 'string x y #'char<))
  "12345789")

(deftest merge-string.1c
  (let ((x "1378")
	(y "2459"))
    (merge 'string x y #'char<))
  "12345789")

(deftest merge-string.1d
  (let ((x "1378")
	(y "2459"))
    (merge 'string y x #'char<))
  "12345789")

(deftest merge-string.2
  (let ((x nil)
	(y (list #\2 #\4 #\5 #\9)))
    (merge 'string x y #'char<))
  "2459")

(deftest merge-string.3
  (let ((x nil)
	(y (list #\2 #\4 #\5 #\9)))
    (merge 'string y x #'char<))
  "2459")

(deftest merge-string.4
  (merge 'string nil nil #'char<)
  "")

(deftest merge-string.8
  (let ((x (list #\1 #\3 #\7 #\8))
	(y (list #\2 #\4 #\5)))
    (merge 'string x y #'char< :key #'nextdigit))
  "1234578")
	   
(deftest merge-string.9
  (let ((x (list #\1 #\3 #\7 #\8))
	(y (list  #\2 #\4 #\5 #\9)))
    (merge 'string x y #'char< :key nil))
  "12345789")

(deftest merge-string.10
  (let ((x (list #\1 #\3 #\7 #\8))
	(y (list  #\2 #\4 #\5 #\9)))
    (merge 'string x y 'char<))
  "12345789")

(deftest merge-string.11
  (let ((x (vector)) (y (vector)))
    (merge 'string x y #'char<))
  "")

(deftest merge-string.12
  (let ((x nil) (y (vector #\1 #\2 #\3)))
    (merge 'string x y #'char<))
  "123")

(deftest merge-string.13
  (let ((x (vector)) (y (list #\1 #\2 #\3)))
    (merge 'string x y #'char<))
  "123")

(deftest merge-string.13a
  (let ((x (copy-seq "")) (y (list #\1 #\2 #\3)))
    (merge 'string x y #'char<))
  "123")

(deftest merge-string.14
  (let ((x nil) (y (vector #\1 #\2 #\3)))
    (merge 'string y x #'char<))
  "123")

(deftest merge-string.14a
  (let ((x (copy-seq "")) (y (vector #\1 #\2 #\3)))
    (merge 'string y x #'char<))
  "123")

(deftest merge-string.15
  (let* ((x (make-array '(10) :initial-contents "adgkmpruwv"
			:fill-pointer 5 :element-type 'character))
	 (y (copy-seq "bci")))
    (merge 'string x y #'char<))
  "abcdgikm")

(deftest merge-string.16
  (let* ((x (make-array '(10) :initial-contents "adgkmpruwv"
			:fill-pointer 5 :element-type 'character))
	 (y (copy-seq "bci")))
    (merge 'string y x #'char<))
  "abcdgikm")

(deftest merge-string.17
  (let* ((x (make-array '(10) :initial-contents "adgkmpruwv"
			:fill-pointer 5 :element-type 'character)))
    (merge 'string nil x #'char<))
  "adgkm")

(deftest merge-string.18
  (let* ((x (make-array '(10) :initial-contents "adgkmpruwv"
			:fill-pointer 5 :element-type 'character)))
    (merge 'string x nil #'char<))
  "adgkm")

;;; Tests for bit vectors

(deftest merge-bit-vector.1
  (let ((x (list 0 0 1 1 1))
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.2
  (let ((x nil)
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*00011)

(deftest merge-bit-vector.3
  (let ((x nil)
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector y x #'<))
  #*00011)

(deftest merge-bit-vector.4
  (merge 'bit-vector nil nil #'<)
  #*)

(deftest merge-bit-vector.5
  (let ((x (vector 0 0 1 1 1))
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.5a
  (let ((x (copy-seq #*00111))
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.5b
  (let ((x (list 0 0 1 1 1))
	(y (copy-seq #*00011)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.5c
  (let ((x (copy-seq #*00111))
	(y (copy-seq #*00011)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.5d
  (let ((x (copy-seq #*11111))
	(y (copy-seq #*00000)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.5e
  (let ((x (copy-seq #*11111))
	(y (copy-seq #*00000)))
    (merge 'bit-vector y x #'<))
  #*0000011111)

(deftest merge-bit-vector.6
  (let ((x (list 0 0 1 1 1))
	(y (vector 0 0 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.7
  (let ((x (vector 0 0 1 1 1))
	(y (vector 0 0 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*0000011111)

(deftest merge-bit-vector.8
  (let ((x (list 1 1 1 0 0))
	(y (list 1 1 0 0 0)))
    (merge 'bit-vector x y #'< :key #'-))
  #*1111100000)

(deftest merge-bit-vector.9
  (let ((x (list 0 0 1 1 1))
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector x y #'< :key nil))
  #*0000011111)

(deftest merge-bit-vector.10
  (let ((x (list 0 0 1 1 1))
	(y (list 0 0 0 1 1)))
    (merge 'bit-vector x y '<))
  #*0000011111)

(deftest merge-bit-vector.11
  (let ((x (copy-seq #*)) (y (copy-seq #*)))
    (merge 'bit-vector x y #'<))
  #*)

(deftest merge-bit-vector.12
  (let ((x (copy-seq #*)) (y (copy-seq #*011)))
    (merge 'bit-vector x y #'<))
  #*011)
  
(deftest merge-bit-vector.13
  (let ((x (copy-seq #*)) (y (list 0 1 1)))
    (merge 'bit-vector x y #'<))
  #*011)

(deftest merge-bit-vector.14
  (let ((x nil) (y (vector 0 1 1)))
    (merge 'bit-vector y x #'<))
  #*011)

(deftest merge-bit-vector.15
  (let ((x (copy-seq #*)) (y (list 0 1 1)))
    (merge 'bit-vector y x #'<))
  #*011)

(deftest merge-bit-vector.16
  (let* ((x (make-array '(10) :initial-contents #*0001101010
			:fill-pointer 5 :element-type 'bit))
	 (y (copy-seq #*001)))
    (merge 'bit-vector x y #'<))
  #*00000111)

(deftest merge-bit-vector.17
  (let* ((x (make-array '(10) :initial-contents #*0001101010
			:fill-pointer 5 :element-type 'bit))
	 (y (copy-seq #*001)))
    (merge 'bit-vector y x #'<))
  #*00000111)

(deftest merge-bit-vector.18
  (let* ((x (make-array '(10) :initial-contents #*0001101010
			:fill-pointer 5 :element-type 'bit)))
    (merge 'bit-vector nil x #'<))
  #*00011)

(deftest merge-bit-vector.19
  (let* ((x (make-array '(10) :initial-contents #*0001101010
			:fill-pointer 5 :element-type 'bit)))
    (merge 'bit-vector x nil #'<))
  #*00011)


;;; Cons (which is a recognizable subtype of list)

(deftest merge-cons.1
  (merge 'cons (list 1 2 3) (list 4 5 6) #'<)
  (1 2 3 4 5 6))

;;; Null, which is a recognizable subtype of list

(deftest merge-null.1
  (merge 'null nil nil #'<)
  nil)

;;; Vectors with length

(deftest merge-vector-length.1
  (merge '(vector * 6) (list 1 2 3) (list 4 5 6) #'<)
  #(1 2 3 4 5 6))
  
(deftest merge-bit-vector-length.1
  (merge '(bit-vector  6) (list 0 1 1) (list 0 0 1) #'<)
  #*000111)
  
;;; Tests of error situations

(deftest merge-error.1
  (handler-case  (merge 'symbol (list 1 2 3) (list 4 5 6) #'<)
		 (error () :caught))
  :caught)

(deftest merge-error.2
  (classify-error (merge '(vector * 3) (list 1 2 3) (list 4 5 6) #'<))
  type-error)

(deftest merge-error.3
  (classify-error (merge '(bit-vector 3) (list 0 0 0) (list 1 1 1) #'<))
  type-error)

(deftest merge-error.4
  (classify-error (merge '(vector * 7) (list 1 2 3) (list 4 5 6) #'<))
  type-error)

(deftest merge-error.5
  (classify-error (merge '(bit-vector 7) (list 0 0 0) (list 1 1 1) #'<))
  type-error)

(deftest merge-error.6
  (classify-error (merge 'null (list 1 2 3) (list 4 5 6) #'<))
  type-error)


   
  
