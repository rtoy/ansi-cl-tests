;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Sun Jan 26 18:56:39 2003
;;;; Contains: Tests of BIT-ANDC1

(in-package :cl-test)

(deftest bit-andc1.1
  (let* ((s1 (make-array nil :initial-element 0 :element-type 'bit))
	 (s2 (make-array nil :initial-element 0 :element-type 'bit)))
    (values (bit-andc1 s1 s2) s1 s2))
  #0a0
  #0a0
  #0a0)

(deftest bit-andc1.2
  (let* ((s1 (make-array nil :initial-element 1 :element-type 'bit))
	 (s2 (make-array nil :initial-element 0 :element-type 'bit)))
    (values (bit-andc1 s1 s2) s1 s2))
  #0a0
  #0a1
  #0a0)

(deftest bit-andc1.3
  (let* ((s1 (make-array nil :initial-element 0 :element-type 'bit))
	 (s2 (make-array nil :initial-element 1 :element-type 'bit)))
    (values(bit-andc1 s1 s2) s1 s2))
  #0a1
  #0a0
  #0a1)

(deftest bit-andc1.4
  (let* ((s1 (make-array nil :initial-element 1 :element-type 'bit))
	 (s2 (make-array nil :initial-element 1 :element-type 'bit)))
    (values (bit-andc1 s1 s2) s1 s2))
  #0a0
  #0a1
  #0a1)

(deftest bit-andc1.5
  (let* ((s1 (make-array nil :initial-element 0 :element-type 'bit))
	 (s2 (make-array nil :initial-element 0 :element-type 'bit))
	 (s3 (make-array nil :initial-element 1 :element-type 'bit))
	 (result (bit-andc1 s1 s2 s3)))
    (values s1 s2 s3 result (eqt s3 result)))
  #0a0
  #0a0
  #0a0
  #0a0
  t)

(deftest bit-andc1.6
  (let* ((s1 (make-array nil :initial-element 0 :element-type 'bit))
	 (s2 (make-array nil :initial-element 1 :element-type 'bit))
	 (s3 (make-array nil :initial-element 0 :element-type 'bit))
	 (result (bit-andc1 s1 s2 s3)))
    (values s1 s2 s3 result (eqt s3 result)))
  #0a0
  #0a1
  #0a1
  #0a1
  t)

(deftest bit-andc1.7
  (let* ((s1 (make-array nil :initial-element 1 :element-type 'bit))
	 (s2 (make-array nil :initial-element 0 :element-type 'bit))
	 (result (bit-andc1 s1 s2 t)))
    (values s1 s2 result (eqt s1 result)))
  #0a0
  #0a0
  #0a0
  t)


;;; Tests on bit vectors

(deftest bit-andc1.8
  (let ((a1 (copy-seq #*0011))
	(a2 (copy-seq #*0101)))
    (values (check-values (bit-andc1 a1 a2)) a1 a2))
  #*0100 #*0011 #*0101)

(deftest bit-andc1.9
  (let* ((a1 (copy-seq #*0011))
	 (a2 (copy-seq #*0101))
	 (result (check-values (bit-andc1 a1 a2 t))))
    (values result a1 a2 (eqt result a1)))
  #*0100 #*0100 #*0101 t)

(deftest bit-andc1.10
  (let* ((a1 (copy-seq #*0011))
	 (a2 (copy-seq #*0101))
	 (a3 (copy-seq #*0000))
	 (result (check-values (bit-andc1 a1 a2 a3))))
    (values result a1 a2 a3 (eqt result a3)))
  #*0100 #*0011 #*0101 #*0100 t)

(deftest bit-andc1.11
  (let ((a1 (copy-seq #*0011))
	(a2 (copy-seq #*0101)))
    (values (check-values (bit-andc1 a1 a2 nil)) a1 a2))
  #*0100 #*0011 #*0101)

;;; Tests on bit arrays

(deftest bit-andc1.12
  (let* ((a1 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 1)(0 1))))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 0)(1 1))))
	 (result (bit-andc1 a1 a2)))
    (values a1 a2 result))
  #2a((0 1)(0 1))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

(deftest bit-andc1.13
  (let* ((a1 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 1)(0 1))))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 0)(1 1))))
	 (result (bit-andc1 a1 a2 t)))
    (values a1 a2 result))
  #2a((0 0)(1 0))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

(deftest bit-andc1.14
  (let* ((a1 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 1)(0 1))))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 0)(1 1))))
	 (result (bit-andc1 a1 a2 nil)))
    (values a1 a2 result))
  #2a((0 1)(0 1))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

(deftest bit-andc1.15
  (let* ((a1 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 1)(0 1))))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 0)(1 1))))
	 (a3 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 0)(0 0))))
	 (result (bit-andc1 a1 a2 a3)))
    (values a1 a2 a3 result))
  #2a((0 1)(0 1))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0))
  #2a((0 0)(1 0)))

;;; Adjustable arrays

(deftest bit-andc1.16
  (let* ((a1 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 1)(0 1))
			 :adjustable t))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :initial-contents '((0 0)(1 1))
			 :adjustable t))
	 (result (bit-andc1 a1 a2)))
    (values a1 a2 result))
  #2a((0 1)(0 1))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

;;; Displaced arrays

(deftest bit-andc1.17
  (let* ((a0 (make-array '(8) :element-type 'bit
			 :initial-contents '(0 1 0 1 0 0 1 1)))
	 (a1 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 0))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 4))
	 (result (bit-andc1 a1 a2)))
    (values a0 a1 a2 result))
  #*01010011
  #2a((0 1)(0 1))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

(deftest bit-andc1.18
  (let* ((a0 (make-array '(8) :element-type 'bit
			 :initial-contents '(0 1 0 1 0 0 1 1)))
	 (a1 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 0))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 4))
	 (result (bit-andc1 a1 a2 t)))
    (values a0 a1 a2 result))
  #*00100011
  #2a((0 0)(1 0))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

(deftest bit-andc1.19
  (let* ((a0 (make-array '(12) :element-type 'bit
			 :initial-contents '(0 1 0 1 0 0 1 1 1 1 1 0)))
	 (a1 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 0))
	 (a2 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 4))
	 (a3 (make-array '(2 2) :element-type 'bit
			 :displaced-to a0
			 :displaced-index-offset 8))
	 (result (bit-andc1 a1 a2 a3)))
    (values a0 a1 a2 result))
  #*010100110010
  #2a((0 1)(0 1))
  #2a((0 0)(1 1))
  #2a((0 0)(1 0)))

;;; Error tests

(deftest bit-andc1.error.1
  (classify-error (bit-andc1))
  program-error)

(deftest bit-andc1.error.2
  (classify-error (bit-andc1 #*000))
  program-error)

(deftest bit-andc1.error.3
  (classify-error (bit-andc1 #*000 #*0100 nil nil))
  program-error)