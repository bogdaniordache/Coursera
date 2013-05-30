#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; 1

(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

; 2

(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

; 3

(define (list-nth-mod xs n)
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

; 4

(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([next (s)])
        (cons (car next) (stream-for-n-steps (cdr next) (- n 1))))))

; 5

(define funny-number-stream
  (letrec ([f (lambda (x)
                (cons (if (= (remainder x 5) 0) (- x) x)
                      (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; 6

(define dan-then-dog
  (letrec ([f (lambda (b) (cons (if b "dan.jpg" "dog.jpg")
                                (lambda () (f (not b)))))])
    (lambda () (f #t))))

; 7

(define (stream-add-zero s)
  (letrec ([p (s)])
    (lambda () (cons (cons 0 (car p)) (stream-add-zero (cdr p))))))

; 8

(define (cycle-lists xs ys)
  (letrec ([f (lambda (x)
                (cons (cons (list-nth-mod xs x)
                            (list-nth-mod ys x))
                      (lambda () (f (+ x 1)))))])
    (lambda () (f 0))))

; 9

(define (vector-assoc value vector)
  (letrec ([length (vector-length vector)]
	   [vector-assoc-rec
            (lambda (x)
              (cond [(= x length) #f]
                    [(not (pair? (vector-ref vector x))) (vector-assoc-rec (+ x 1))]
                    [(equal? (car (vector-ref vector x)) value) (vector-ref vector x)]
                    [#t (vector-assoc-rec (+ x 1))]))])

    (vector-assoc-rec 0)))

; 10

(define (cached-assoc xs n)
  (letrec ([x 0]
           [memo (make-vector n #f)]
           [f (lambda (v)
                (let ([ans (vector-assoc v memo)])
                  (if ans
                      (cdr ans)
                      (begin
                        (let ([new-ans (assoc v xs)])
                          (vector-set! memo x (cons v new-ans))
                          (set! x (remainder (+ x 1) n))
                          new-ans)))))])
    f))

; 11

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do body)
     (let ([v1 e1])
       (letrec ([loop (lambda ()
                        (let ((v2 body))
                          (if (>= v2 v1)
                              #t
                              (loop))))])
         (loop)))]))