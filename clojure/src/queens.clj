; Copyright 2018 John Hurst
; John Hurst (john.b.hurst@gmail.com)
; 2018-12-31 (Happy New Year!)

(ns queens)

(defn newBoard [size]
  {:size size, :row 0, :cols 0, :diags1 0, :diags2 0}
)

(defn ok [board col]
  (let [
      size (:size board)
      row (:row board)
      cols (:cols board)
      diags1 (:diags1 board)
      diags2 (:diags2 board)
    ] (and
      (= (bit-and cols (bit-shift-left 1 col)) 0)
      (= (bit-and diags1 (bit-shift-left 1 (+ row col))) 0)
      (= (bit-and diags2 (bit-shift-left 1 (- (+ row size) col 1))) 0)
    )
  )
)

(defn place [board col]
  (let [
      size (:size board)
      row (:row board)
      cols (:cols board)
      diags1 (:diags1 board)
      diags2 (:diags2 board)
    ] {
      :size size,
      :row (+ row 1),
      :cols (bit-or cols (bit-shift-left 1 col)),
      :diags1 (bit-or diags1 (bit-shift-left 1 (+ row col))),
      :diags2 (bit-or diags2 (bit-shift-left 1 (- (+ row size) col 1)))
    }
  )
)

(defn solve [board]
  (let [
      size (:size board)
      row (:row board)
    ]
    (if
      (= row size) 1
      (apply +
        (map (fn [col] (solve (place board col)))
          (filter (fn [col] (ok board col)) (range size))
        )
      )
    )
  )
)

(defn run [size]
  (let [
    start (java.time.Instant/now)
    result (solve (newBoard size))
    end (java.time.Instant/now)
    duration (java.time.Duration/between start end)
    seconds (+ (.get duration java.time.temporal.ChronoUnit/SECONDS)
               (/ (.get duration java.time.temporal.ChronoUnit/NANOS) 1000000000.0))
  ]
    (str size "," result "," seconds)
  )
)

(defn -main
  "I don't do a whole lot."
  [from to]
  (doseq [size (range (Integer/parseInt from) (+ (Integer/parseInt to) 1))]
    (println (run size))
  )
)