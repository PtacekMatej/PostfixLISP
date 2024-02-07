#lang racket

(require "./operations.rkt")
(require "./stack.rkt")

(define (find? lst what)
  (foldl (lambda (a acc)(or (equal? a what) acc)) #f lst)
)

; lambdas '(lambda (params)(body))
(define (is_lambda lst)
  (and (list? lst) (and (not (null? lst))(equal? (car lst) 'lambda)))
)

(define (is_lambda2 lst)
  (find? lst 'lambda)
)

(define (find_params lst)
  (if (equal? (car lst) 'lambda)
      (cadr lst)
      (find_params (cdr lst))
  )
)

(define (is_param lst name)
  (find? (find_params lst) name)
)

(define (insert_value name value body)
  (map (lambda(x)(cond [(list? x)(if (and (is_lambda2 x)(is_param x name)) x (insert_value name value x))]
                       [(equal? name x) value]
                       [#t x]
                  )
       )
       body
  )
)

(define (insert_reversed_values names stack body)
  (if (null? names)
      body
      (insert_reversed_values (cdr names)(cdr stack)(insert_value (car names)(car stack) body ))
  )
)

(define (reverse_lst lst)
  (foldl cons '() lst)
)

(define (insert_values names stack body)
  (insert_reversed_values (reverse_lst names) stack body)
)

(define (execute_lambda l stack )
  (execute (insert_values (cadr l) stack (caddr l)))
)

(define (lambda_arity l)
  (foldl (lambda (a acc)(+ 1 acc)) 0 (cadr l))
)
; end of lambdas

(define (eval_condition stack)
 (ternary_operation (lambda (c t f)(if (execute c)(execute t)(execute f))) stack)
)

(define (force_execute stack)
  (execute_one (stack_pop stack)(cdr (stack_top stack)))
)

(define (execute_one stack instruction)
  (cond [(is_lambda instruction)(execute_one (pop_multiple stack (lambda_arity instruction)) (execute_lambda instruction stack))]
        [(list? instruction)(stack_push stack
                                        (cond [(is_list instruction)(cdr instruction)]
                                              [(is_strong_list instruction) instruction]
                                              [#t (execute instruction)]
                                        )
                            )
        ]
        [(or (or (number? instruction)(boolean? instruction)) (equal? instruction '~))(stack_push stack instruction)]
        [(equal? instruction 'if)(eval_condition stack)]
        [(equal? instruction 'exe)(force_execute stack)]
        [#t(evaluate_operation stack instruction)]
  )
)

(define (execute code)
  (if (and (and (list? code) (not (null? code))) (not (is_strong_list code)))
      (car (foldl (lambda (instruction stack)(execute_one stack instruction)) '() code))
      code
  )
)

(provide (all-defined-out))
