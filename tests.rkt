#lang racket

(require "./main.rkt")
(require compatibility/defmacro)


(define-macro (assert left right)
  `(unless (equal? ,left ,right)
       (error (format "Failed assertion (L~a): '(assert ~a ~a)'\n left:  ~a\n right: ~a" (syntax-line #'here) ',left ',right ,left ,right))
   )
)



(assert (execute '(1 2 +)) 3)
(assert (execute '(3 1 -)) 2)
(assert (execute '(4 5 *)) 20)
(assert (execute '(10 5 /)) 2)
(assert (execute '(10 3 %)) 1)
(assert (execute '(2 3 <)) #t)
(assert (execute '(3 2 <)) #f)
(assert (execute '(2 3 >)) #f)
(assert (execute '(3 2 >)) #t)
(assert (execute '(1 1 =)) #t)
(assert (execute '(1 2 =)) #f)
(assert (execute '(#t #t &&)) #t)
(assert (execute '(#t #f &&)) #f)
(assert (execute '(#f #t &&)) #f)
(assert (execute '(#f #f &&)) #f)
(assert (execute '(#t #t ||)) #t)
(assert (execute '(#t #f ||)) #t)
(assert (execute '(#f #t ||)) #t)
(assert (execute '(#f #f ||)) #f)
(assert (execute '(#t !)) #f)
(assert (execute '(#f !)) #t)
(assert (execute '(1 2 cons)) '(1 . 2))
(assert (execute '(1 () cons)) '(1))
(assert (execute '(1 (~) cons)) '(1))
(assert (execute '(1 (~ 3) cons)) '(1 3))
(assert (execute '(1 (~~ 2 3) cons)) '(~~ 1 2 3))
(assert (execute '(1 list?)) #f)
(assert (execute '(~ list?)) #f)
(assert (execute '(() list?)) #t)
(assert (execute '(() null?)) #t)
(assert (execute '((~) null?)) #t)
(assert (execute '((~~) null?)) #t)
(assert (execute '((~ 1) null?)) #f)
(assert (execute '(#t null?)) #f)
(assert (execute '((~ 4 1 2 3) first)) 4)
(assert (execute '((~~ 4 1 2 3) first)) 4)
(assert (execute '((~ 4 1 2 3) rest)) '(1 2 3))
(assert (execute '((~~ 4 1 2 3) rest)) '(~~ 1 2 3))
(assert (execute '(1 1 equal?)) #t)
(assert (execute '(1 2 equal?)) #f)
(assert (execute '(() () equal?)) #t)
(assert (execute '(() (~) equal?)) #t)
(assert (execute '((~ 1 2 ()) (~ 1 2 ()) equal?)) #t)
(assert (execute '((~ 1 2 (1 2)) (~ 1 2 (1 2)) equal?)) #t)
(assert (execute '((~) (~~) equal?)) #f)
(assert (execute '( 1 cpy cpy + +)) 3)
(assert (execute '((~ 1 2 3) cpy cons)) '((1 2 3) 1 2 3))
(assert (execute '(#t 1 2 if)) 1)
(assert (execute '(#f 1 2 if)) 2)
(assert (execute '((~ 1 2 <) 1 2 if)) 1)
(assert (execute '((~ 1 2 >) 1 (~ 1 1 +) if)) 2)
(assert (execute '((~ 2 2 =) (~ 3 2 *) (~ 1 1 +) if)) 6)
(assert (execute '((~ 2 2 =) (~~ 3 2 *) (~ 1 1 +) if)) '(~~ 3 2 *))
(assert (execute '(())) '())
(assert (execute '((~))) '())
(assert (execute '((~~))) '(~~))
(assert (execute '(~~)) '(~~))
(assert (execute '(~)) '~)
(assert (execute '(1)) 1)
(assert (execute '(#t)) #t)
(assert (execute '((~~ 1 1 +))) '(~~ 1 1 +)) 
(assert (execute '((~~ 1 1 +) exe)) 2)
(assert (execute '(2 3 (lambda (x y)(x x y + *)))) 10)
(assert (execute '(1 (lambda (x)(~~ x (lambda(x)(x)))))) '(~~ 1 (lambda(x)(x))))
(assert (execute '(1 2 (lambda (x y)(~~ x y (lambda(x)(x y)))))) '(~~ 1 2 (lambda(x)(x 2))))
(assert (execute '(1 (~~ lambda (x)(1 x +))(lambda (x f)(x f exe)))) 2)






























