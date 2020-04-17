# Copyright 2019 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2019-06-22

import csv
import os
import sys

answers = [1, 1, 0, 0, 2, 10, 4, 40, 92, 352,
           724, 2680, 14200, 73712, 365596, 2279184, 14772512, 95815104, 666090624, 4968057848, ]
# 39029188884, 314666222712, 2691008701644, 24233937684440, 227514171973736, 2207893435808352, 22317699616364044, 234907967154122528]

results = {}
langs = []

for arg in sys.argv[1:]:
  lang, ext = os.path.splitext(os.path.basename(arg))
  langs.append(lang)
  with open(arg) as csvfile:
    for row in csv.reader(csvfile):
      size, result, time = row
      assert int(result) == answers[int(size)], f"{arg}: Expected result {answers[int(size)]}, got {result}"
      results.setdefault(size, {})[lang] = time

print("N," + ",".join(langs))
for size in results:
  print(size + "," + ",".join([results[size].get(lang, "") for lang in langs]))
