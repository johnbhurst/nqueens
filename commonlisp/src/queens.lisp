(defpackage queens
  (:use :cl)
  (:export :main))
(in-package :queens)

(defstruct board
  (size    0)
  (row     0)
  (cols    0)
  (diags1  0)
  (diags2  0))

(defun range (start end)
  "Return the range start inclusive and end exclusive."
  (loop for i from start to (- end 1) collect i))

(defun ok (board col)
  (let ((size   (board-size board))
        (row    (board-row board))
        (cols   (board-cols board))
        (diags1 (board-diags1 board))
        (diags2 (board-diags2 board)))
    (and (equalp 0 (logand cols   (ash 1 col)))
         (equalp 0 (logand diags1 (ash 1 (+ row col))))
         (equalp 0 (logand diags2 (ash 1 (- (+ row size) col 1)))))))

(defun place (board col)
  (let ((size   (board-size board))
        (row    (board-row board))
        (cols   (board-cols board))
        (diags1 (board-diags1 board))
        (diags2 (board-diags2 board)))
    (make-board :size   size
                :row    (+ row 1)
                :cols   (logior cols   (ash 1 col))
                :diags1 (logior diags1 (ash 1 (+ row col)))
                :diags2 (logior diags2 (ash 1 (- (+ row size) col 1))))))

(defun solve (board)
  (let ((size (board-size board))
        (row  (board-row  board)))
    (if (equalp row size)
        1
        (reduce #'+
                (map 'list
                     (lambda (col) (solve (place board col)))
                     (remove-if-not (lambda (col) (ok board col)) (range 0 size)))))))

(defun run (size)
  (let ((start  (get-internal-real-time))
        (result (solve (make-board :size size)))
        (end    (get-internal-real-time)))
    (format t
      "~a,~a,~a seconds~%"
      size
      result
      (float (/ (- end start) 1000)))))

(defun main (args)
  (dolist (size (range (parse-integer (second args))
		       (+ (parse-integer (third  args)) 1)))
    (run size)))
