#lang racket

(require "./main.rkt")

;factorial function
;expected result: 120
(execute '(
           5
           
           (~~ lambda (x f)
               (
                 (0 x =)
                 1
                 (~ ((x 1 -) f cpy exe)
                    x
                    *
                 )
                 if
               )
           ) cpy exe
          )
)                                                        
                                                        
;find max in list of non negative numbers
;going through the list right to left
;expected result: 83
(execute '(
           (~~ 1 3 7 2 0 8 9 83 3 4 21 6 7 37 8 0)
           
           (~~ lambda (a f)
               ( (~ a null?)
                 0
                 (~ (~ (a first) ((a rest) f cpy exe) >)
                    (~ a first)
                    (~ (a rest) f cpy exe)
                    if
                 )
                 if
               )
           ) cpy exe
          )
)

;fibbonacci
;1 1 2 3 5 8 13 21 34 55 89 ...
;expected result: 34
(execute '(
           9
           
           (~~ lambda (x f)
               (
                 (~ x 1 = x 2 = ||)
                 1
                 (~ ((x 1 -) f cpy exe)
                    ((x 2 -) f cpy exe)
                    +
                 )
                 if
               )
            ) cpy exe
           )
)

;length of a list
;going through the list left to right
;expected result: 11
(execute '(
           (~~ 1 1 1 5 5 4 4 2 4 5 1)
           
           (lambda (lst)
            (
             lst
             0
             (~~ lambda (lst acc f)
                 ( (~ lst null?)
                   acc
                   (~ (lst rest)(1 acc +) f cpy exe)
                   if
                 )
              ) cpy exe
             )
            )
           )
)

;the "comb" program from HW
;expected result: 3
(execute '(
           (~~ 1 1 1 2)
           4
           
           (lambda (lst num)
             ( lst
               num
               (~~ lambda (lst)                   
                   ( lst
                     (~~ lambda (lst num f)
                         ( ( ~ lst null?)
                           (~~)
                           (~ (lst first) ((num (lst first) +) ((lst rest) num f cpy exe) cons) cons)
                           if
                         )
                     )
                     (~~ lambda (lst all-sums f)
                         ( (~ lst null?)
                           (~~ 0)
                           (~ (((lst rest) all-sums f cpy exe)(lst first) all-sums cpy exe))
                           if
                         )
                     ) cpy exe
                   )
               )
               (~~ lambda (lst num)
                   ( lst
                     num
                     (~~ lambda (bool)
                         (bool 1 0 if)
                         )
                     (~~ lambda (lst num bool-to-num f)
                         ( (~ lst null?)
                           0
                           (~ ((lst rest) num bool-to-num f cpy exe) (((lst first) num =) bool-to-num exe) +)
                           if
                         )
                     ) cpy exe
                   )
               ) 
               (lambda (lst num all-sums count)
                 ( (lst all-sums exe) num count exe)
               )
             )
           )
          )
)
                              
                              
                         
               
                   
                       
                   
           
                 
                 
                              
           
           






