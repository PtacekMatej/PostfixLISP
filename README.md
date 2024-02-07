# LISP, but not as good

## Lists

- everything in this language is a list
- lists can be evaluated
- if you don't want a list to be evaluated, you have two options:
- - if the first element of a list is **~**, the list (without the ~) is pushed to stack without evaluating
- - if the first element of a list is **\~~**, the list is pushed to the stack without evaluating (including the \~~). In the rest of this README, I call this kind of list a **strong list**
- if there are multiple items left on the stack after the evaluation of a list is done, the top element is considered a result of that evaluation

## Operators

- all operators work in postfix notation
- arity of each operator in this readme is marked with a number in brackets, eg. (2) 

#### Arithmetic operators

- **\+** (2) sums two numbers
- **\-** (2) substracts second argument form the first
- **\*** (2) multiplies two numbers
- **/** (2) devides first argument by the second argument
- **%** (2) returns first argument modulo second argument
- **>** (2) returns true if and only if the first argument is greater than the second argument
- **<** (2) returns true is and only if the first argument is lower than the second argument
- **=**  (2)returns true if and only if the first argument equals the second argument

#### Logic operators

- **&&** (2) logic and
- **||** (2) logic or
- **!** (1) logic not

#### Other operators

- **cons** (2) returns a pair (first argument . second argument)
- **first** (1) returns the first element of the argument
- **rest** (1) returns the second element of the argument
- **list?** (1) returns true is and only if its argument is a list
- **null?** (1) returns true if and only if its argument is a empty list
- **equal?** (2) returns true if and only if both of its arguments are the same
- **cpy** (1) pushes a copy of its argument to the stack (also leaves the argument on the stack as well)
- **exe** (1) forces execution of its argument (works for "strong lists" only)

## Conditions

- the keyword for conditions is **if**
- it is used in postfix notation
- `(condition) (if_true) (if_false) if`
- the if evaluates the condition and based of the result evaluates one of the other two arguments

## Lambdas

- lambda is a list, that looks like this: `(lambda (params) (body))`
- it takes the same number of arguments as it has params
- it takes the arguments in prefix notation
- it takes the arguments in this order: `1 2 3 (lambda (x y z)(body))` x will be 1, y will be 2 and z will be 3
- if you want to define a lambda, but not execute it right away, you can use `(~~ lambda (params)(body))` or `(~ lambda (params)(body))`
- see examples in the *examples.rkt* file

## Writing and running the code

#### How to run the code

- import *main.rkt* to the file you want to execute your code in
- use `(execute '( your_code ))`
- see examples in the *examples.rkt* or *tests.rkt* file

#### How to write recursion

- write your lambda as a strong list
- the lambda has to take a function as the last argument
- you call the lambda by adding `cpy exe` behind it
- to make the recursive call, write `args f cpy exe` (assuming that the last param is named f)
- see *examples.rkt* for some examples

