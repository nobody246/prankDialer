(use posix)

(define zz 120)
(define pid #f)
(define (x)
  (when pid
    (process "kill" `("-9" ,pid)))
  (define-values (i o pid)
    (process "csi" `("scambc.scm")))
  (sleep zz)
  (x))
(x)
