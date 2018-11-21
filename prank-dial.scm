(use posix s)
(define targets `("19005551212"
                  "17005551212"))
(define zz 2)
(define hangup-after #f)
(define dtmf 6)

(process-run "killall" `("-9" "baresip"))
(sleep 2)
(define-values
  (inp outp pid)
  (process "baresip"))
(define outgoing-domain "@aol.com")
(define (write-response inp #!optional (a 0))
  (and-let* ((i  (read-line inp))
             (x  (not (eq? i #!eof)))
             (x  (not (> a 10))))
    (print i)
    (set! a (add1 a))
    (write-response inp a)))
(let ((c 1))
  (define (y)
    (let ((cfg
           (file-open
            "/tmp/.cid_baresip"
            (+ open/wronly open/creat))))
         (file-write cfg (sprintf "sip:1~A~A~A~A"
                                  (+ 200 (random 799))
                                  (+ 200 (random 799))
                                  (+ 1000 (random 8999))
                                  outgoing-domain)))
    (print "Call # " c)
    (for-each (lambda(t)
                (write-line
                 (sprintf "/dial ~A" t) outp))
              targets)
    (sleep zz)
    (when hangup-after
      (write-line "/hangup call" outp))
    (set! c (add1 c))
    (y))
  (y))



