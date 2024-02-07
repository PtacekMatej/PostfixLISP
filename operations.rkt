#lang racket

(require "./stack.rkt")

(define (ternary_operation f stack)
  (stack_push
    (stack_pop (stack_pop (stack_pop stack)))
    (f (stack_top (stack_pop (stack_pop stack))) (stack_top (stack_pop stack)) (stack_top stack))
  )
)
                                                                               
(define (binary_operation f stack)
  (stack_push
    (stack_pop (stack_pop stack))
    (f (stack_top (stack_pop stack))(stack_top stack))
  )
)

(define (unary_operation f stack)
  (stack_push
    (stack_pop stack)
    (f (stack_top stack))
  )
)

(define (is_list lst)
  (and (not (null? lst))(equal? (car lst) '~))
)

(define (is_strong_list lst)
  (and (list? lst)(and (not (null? lst))(equal? (car lst) '~~)))
)

(define (evaluate_operation stack operation)
  (cond [(equal? operation '+)(binary_operation + stack)]
        [(equal? operation '-)(binary_operation - stack)]
        [(equal? operation '*)(binary_operation * stack)]
        [(equal? operation '/)(binary_operation / stack)]
        [(equal? operation '%)(binary_operation modulo stack)]
        [(equal? operation '<)(binary_operation < stack)]
        [(equal? operation '>)(binary_operation > stack)]
        [(equal? operation '=)(binary_operation = stack)]
        [(equal? operation '&&)(binary_operation (lambda (a b)(and a b)) stack)]
        [(equal? operation '||)(binary_operation (lambda (a b)(or a b)) stack)]
        [(equal? operation '!)(unary_operation not stack)]
        [(equal? operation 'cons)(binary_operation (lambda (x y)(if (is_strong_list y)(cons '~~ (cons x (cdr y))) (cons x y))) stack)]
        [(equal? operation 'list?)(unary_operation list? stack)]
        [(equal? operation 'null?)(unary_operation (lambda (x) (or (null? x)(equal? x '(~~)))) stack)]
        [(equal? operation 'first)(unary_operation (lambda (lst)(if (is_strong_list lst)(cadr lst)(car lst))) stack)]
        [(equal? operation 'rest)(unary_operation (lambda (lst) (if (is_strong_list lst)(cons '~~ (cddr lst))(cdr lst))) stack)]
        [(equal? operation 'equal?)(binary_operation equal? stack)]
        [(equal? operation 'cpy)(stack_push stack (stack_top stack))]
  )
)

(provide (all-defined-out))