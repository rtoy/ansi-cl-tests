;-*- Mode:     Lisp -*-
;;;; Author:   Paul Dietz
;;;; Created:  Wed Jan 21 06:21:11 2004
;;;; Contains: Tests of FILE-LENGTH

(in-package :cl-test)

(deftest file-length.error.1
  (signals-error (file-length) program-error)
  t)

(deftest file-length.error.2
  (signals-error
   (with-open-file (is "file-length.lsp" :direction :input)
		   (file-length is nil))
   program-error)
  t)

(deftest file-length.error.3
  (loop for x in *mini-universe*
	unless (or (typep x 'file-stream)
		   (typep x 'broadcast-stream)
		   (handler-case (progn (file-length x) nil)
				 (type-error () t)
				 (condition () nil)))
	collect x)
  nil)

(deftest file-length.error.4
  (signals-error (with-input-from-string (s "abc") (file-length s))
		 type-error)
  t)

(deftest file-length.error.5
  (signals-error
   (with-open-file
    (is "file-length.lsp" :direction :input)
    (with-open-file
     (os "tmp.txt" :direction :output :if-exists :supersede)
     (let ((s (make-two-way-stream is os)))
       (unwind-protect (file-length s) (close s)))))
   type-error)
  t)

(deftest file-length.error.6
  (signals-error
   (with-open-file
    (is "file-length.lsp" :direction :input)
    (with-open-file
     (os "tmp.txt" :direction :output :if-exists :supersede)
     (let ((s (make-echo-stream is os)))
       (unwind-protect (file-length s) (close s)))))
   type-error)
  t)

(deftest file-length.error.7
  (signals-error
   (let ((s (make-broadcast-stream)))
     (unwind-protect (file-length s) (close s)))
   type-error)
  t)

(deftest file-length.error.8
  (signals-error
   (with-open-file
     (os "tmp.txt" :direction :output :if-exists :supersede)
     (let ((s (make-broadcast-stream os)))
       (unwind-protect (file-length s) (close s))))
   type-error)
  t)

(deftest file-length.error.9
  (signals-error
   (let ((s (make-concatenated-stream)))
     (unwind-protect (file-length s) (close s)))
   type-error)
  t)

(deftest file-length.error.10
  (signals-error
   (with-open-file
    (is "file-length.lsp" :direction :input)
    (let ((s (make-concatenated-stream is)))
      (unwind-protect (file-length s) (close s))))
   type-error)
  t)

(deftest file-length.error.11
  (signals-error
   (let ((s (make-string-input-stream "abcde")))
     (unwind-protect (file-length s) (close s)))
   type-error)
  t)

(deftest file-length.error.12
  (signals-error
   (let ((s (make-string-output-stream)))
     (unwind-protect (file-length s) (close s)))
   type-error)
  t)


; more stream error tests here

;;; Non-error tests

(deftest file-length.1
  (let ((results (multiple-value-list
		  (with-open-file
		   (is "file-length.lsp" :direction :input)
		   (file-length is)))))
    (and (= (length results) 1)
	 (typep (car results) '(integer (0)))
	 t))
  t)

(deftest file-length.2
  (loop for i from 1 to 32
	for etype = `(unsigned-byte ,i)
	for e = (max 0 (- (ash 1 i) 5))
	for os = (open "tmp.dat" :direction :output
			       :if-exists :supersede
			       :element-type etype)
	do (loop repeat 17 do (write-byte e os))
	do (finish-output os)
	unless (= (file-length os) 17)
	collect (list i (file-length os))
	do (close os))
  nil)

(deftest file-length.3
  (loop for i from 1 to 32
	for etype = `(unsigned-byte ,i)
	for e = (max 0 (- (ash 1 i) 5))
	for os = (open "tmp.dat" :direction :output
			       :if-exists :supersede
			       :element-type etype)
	for len = 0
	do (loop repeat 17 do (write-byte e os))
	do (close os)
	unless (let ((is (open "tmp.dat" :direction :input
			       :element-type etype)))
		 (prog1
		     (= (file-length is) 17)
		   (close is)))
	collect i)
  nil)

(deftest file-length.4
  (loop for i from 33 to 100
	for etype = `(unsigned-byte ,i)
	for e = (max 0 (- (ash 1 i) 5))
	for os = (open "tmp.dat" :direction :output
			       :if-exists :supersede
			       :element-type etype)
	do (loop repeat 17 do (write-byte e os))
	do (finish-output os)
	unless (= (file-length os) 17)
	collect (list i (file-length os))
	do (close os))
  nil)

(deftest file-length.5
  (loop for i from 33 to 100
	for etype = `(unsigned-byte ,i)
	for e = (max 0 (- (ash 1 i) 5))
	for os = (open "tmp.dat" :direction :output
			       :if-exists :supersede
			       :element-type etype)
	for len = 0
	do (loop repeat 17 do (write-byte e os))
	do (close os)
	unless (let ((is (open "tmp.dat" :direction :input
			       :element-type etype)))
		 (prog1
		     (= (file-length is) 17)
		   (close is)))
	collect i)
  nil)		 

(deftest file-length.6
  (with-open-file
   (*foo* "file-length.lsp" :direction :input)
   (declare (special *foo*))
   (let ((s (make-synonym-stream '*foo*)))
     (unwind-protect
	 (typep* (file-length s) '(integer (0)))
	(close s))))
  t)
