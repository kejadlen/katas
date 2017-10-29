#lang br
(require basic/parser basic/tokenizer brag/support rackunit)

(define (parse str)
    (parse-to-datum (apply-tokenizer make-tokenizer str)))

(check-equal?
  (parse #<<HERE
10 print "hello" : print "world"
20 goto 9 + 10 + 11
30 end
HERE
)
  '(b-program
    (b-line 10 (b-print "hello") (b-print "world"))
    (b-line 20 (b-goto (b-expr (b-sum 9 10 11))))
    (b-line 30 (b-end))))

(check-equal?
  (parse #<<HERE
30 rem print 'ignored'
35
50 print "never gets here"
40 end
60 print 'three' : print 1.0 + 3
70 goto 11. + 18.5 + .5 rem ignored
10 print "o" ; "n" ; "e"
20 print : goto 60.0 : end
HERE
)
  '(b-program
    (b-line 30 (b-rem "rem print 'ignored'"))
    (b-line 35)
    (b-line 50 (b-print "never gets here"))
    (b-line 40 (b-end))
    (b-line 60 (b-print "three") (b-print (b-expr (b-sum 1.0 3))))
    (b-line 70 (b-goto (b-expr (b-sum 11.0 18.5 0.5))) (b-rem "rem ignored"))
    (b-line 10 (b-print "o" "n" "e"))
    (b-line 20 (b-print) (b-goto (b-expr (b-sum 60.0))) (b-end))))
