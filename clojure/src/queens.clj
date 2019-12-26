; Copyright 2018 John Hurst
; John Hurst (john.b.hurst@gmail.com)
; 2018-12-31 (Happy New Year!)

(ns queens
  (:gen-class))

(defrecord Board [^Long size ^Long row ^Long cols ^Long diags1 ^Long diags2])

(defn new-board [size]
  (->Board size 0 0 0 0))

(defn ok [board ^Long col]
  (let [^Long size   (:size board)
        ^Long row    (:row board)
        ^Long cols   (:cols board)
        ^Long diags1 (:diags1 board)
        ^Long diags2 (:diags2 board)]
      (and
        (= (bit-and cols   (bit-shift-left 1 col)) 0)
        (= (bit-and diags1 (bit-shift-left 1 (+ row col))) 0)
        (= (bit-and diags2 (bit-shift-left 1 (- (+ row size) col 1))) 0))))

(defn place [board ^Long col]
  (let [^Long size   (:size board)
        ^Long row    (:row board)
        ^Long cols   (:cols board)
        ^Long diags1 (:diags1 board)
        ^Long diags2 (:diags2 board)]
        (->Board
          size
          (+ row 1)
          (bit-or cols (bit-shift-left 1 col))
          (bit-or diags1 (bit-shift-left 1 (+ row col)))
          (bit-or diags2 (bit-shift-left 1 (- (+ row size) col 1))))))

(defn solve [board]
  (let [^Long size (:size board)
        ^Long row  (:row board)]
    (if
      (= row size) 1
      (reduce +
        (map (fn [col] (solve (place board col)))
          (filter (fn [col] (ok board col)) (range size)))))))

(defn run [^Long size]
  (let [start (java.time.Instant/now)
        result (solve (new-board size))
        end (java.time.Instant/now)
        duration (java.time.Duration/between start end)
        seconds (+ (.get duration java.time.temporal.ChronoUnit/SECONDS)
                   (/ (.get duration java.time.temporal.ChronoUnit/NANOS) 1000000000.0))]
    (str size "," result "," seconds)))

(defn -main
  [from to]
  (doseq [size (range (Integer/parseInt from) (+ (Integer/parseInt to) 1))]
    (println (run size))))