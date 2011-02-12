;;; -*- mode: lisp; package: typecase -*-
;;;
;;; typecase.l --- DESCRIPTION
;;;
;;; Author:     bowbow99  <bowbow99@gmail.com>
;;; Version:    0.00.00
;;; Category:
;;; License:    MIT (see COPYING.mit)
;;; Commentary: (see README.md)
;;; ChangeLog:  (see ChangeLog)

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "typespec+")
  (require "condition-restart"))

(defpackage :typecase
  (:use :lisp :typespec+))

(in-package :typecase)

(export (mapcar (lambda (name) (intern (string name) :lisp))
          '(#:typecase
            #:etypecase
            #:ctypecase
            #:otherwise))
        :lisp)

#+xyzzy
(mapc (lambda (name)
        (setf (get name 'ed:lisp-indent-hook) 1))
      '(lisp:typecase
        lisp:etypecase
        lisp:ctypecase))

;;; typecase.l ends here.
