(use posix)

(letrec
    ((zz 120)
     (pid #f)
     (reset
      (lambda()
        (process
         "kill"
         `("-9"
           ,pid
           "$(cat /run/user/1000/pulse/pid)"))
        (process
         "pulseaudio" `("-D")))))
    (define (x)
      (condition-case
          ((lambda() 
             (when pid
               (reset))
             (define-values
               (i o pid)
               (process "csi" `("scambc.scm")))
             (sleep zz)))
        ((exn)
         (print "error in controller. trying again.")
         (reset)))
      (x))
    (x))
  
