(use posix)

(define zz 120)
(define pid #f)
(define (x)
  (condition-case
      ((lambda() 
         (when pid
           (process "kill" `("-9" ,pid))
           (process "pulseaudio" `("-k"))
           (sleep 1)
           (process "pulseaudio" `("-D")))
         (define-values (i o pid)
           (process "csi" `("scambc.scm")))
         (sleep zz)))
    ((exn) (print "error in controller. trying again.")))
  (x))
(x)
