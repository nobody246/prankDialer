(use posix s)
(define targets `("19005551212"
                  "17005551212"))
(define zz 2)

(process-run "killall" `("-9" "baresip"))
(sleep 2)
(define-values
  (inp outp pid)
  (process "baresip"))
(define outgoing-domain "@aol.com")

(letrec
    ((c 1)
     (y
      (lambda()
        (let ((cfg
               (file-open
                "/tmp/.cid_baresip"
                (+ open/wronly open/creat))))
          (file-write
           cfg
           (sprintf "sip:1~A~A~A~A"
                    (+ 200 (random 799))
                    (+ 200 (random 799))
                    (+ 1000 (random 8999))
                    outgoing-domain))
          (file-close cfg))
        (for-each
         (lambda(t)
           (write-line
            (sprintf
             "/dial ~A"
             t)
            outp)
           (write-line
            "/listcalls"
            outp))
         targets)
        (set! c (add1 c)))))
  (define (x)
    (condition-case
        ((lambda()
           (y)))
      ((exn)
       (print 
        "Error placing call in prank-dial.scm. Trying again")))
    (sleep zz)
    (x))
  (x))
