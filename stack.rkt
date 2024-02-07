#lang racket

(define (stack_push stack item)
  (cons item stack)
)

(define (stack_pop stack)
  (cdr stack)
)

(define (stack_top stack)
  (car stack)
)

(define (pop_multiple stack n)
  (if (equal? n 0)
      stack
      (pop_multiple (stack_pop stack) (- n 1))
  )
)

(provide (all-defined-out))