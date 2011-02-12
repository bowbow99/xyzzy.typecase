;;; -*- mode: lisp; package: typecase -*-
;;;
;;; typecase.l --- DESCRIPTION
;;;
;;; Author:     bowbow99  <bowbow99@gmail.com>
;;; Version:    0.00.00
;;; Category:   Lisp Libraries
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

;;; Macro `typecase`
(defmacro lisp:typecase (keyform &rest clauses)
  `(let ((#1=#:key-object ,keyform))
     (cond ,@(labels ((expand (clauses)
                        (cond ((null clauses) nil)
                              ((and (null (cdr clauses))
                                    (member (caar clauses) '(t otherwise)))
                               `((t ,@(cdar clauses))))
                              (t
                               `((,(optimize-type-check '#1# (caar clauses))
                                  (progn,@(cdar clauses)))
                                 ,@(expand (cdr clauses)))))))
               (expand clauses)))))

;;; Macro `etypecase`
(defmacro lisp:etypecase (keyform &rest clauses)
  `(let ((#1=#:key-object ,keyform))
     (cond ,@(mapcar (lambda (clause)
                       `(,(optimize-type-check '#1# (car clause))
                         (progn ,@(cdr clause))))
               clauses)
           (t (error 'type-error :datum #1#
                     :expected-type '(or ,@(mapcar #'car clauses)))))))

;;; Macro `ctypecase`
(defmacro lisp:ctypecase (place &rest clauses)
  `(prog (#1=#:key-object)
     #2=#:ctypecase-root
     (setf #1# ,place)
     (cond ,@(mapcar (lambda (clause)
                       `(,(optimize-type-check '#1# (car clause))
                         (return (progn ,@(cdr clause)))))
               clauses)
           (t (restart-case
                  (error 'type-error :datum #1#
                         :expected-type '(or ,@(mapcar #'car clauses)))
                (store-value (new)
                  :report ,(format nil "`~S' ÇÃílÇïœçXÇ∑ÇÈ" place)
                  :interactive
                  (lambda ()
                    (list (ed:read-value (format nil "`~S' ÇÃíl: " ',place))))
                  (setf ,place new)
                  (go #2#)))))))

;;; typecase.l ends here.
