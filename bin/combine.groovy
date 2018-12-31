// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-12-31

def answers = [1L, 1L, 0L, 0L, 2L, 10L, 4L, 40L, 92L, 352L,
724L, 2680L, 14200L, 73712L, 365596L, 2279184L, 14772512L, 95815104L, 666090624L, 4968057848L, ]
//39029188884L, 314666222712L, 2691008701644L, 24233937684440L, 227514171973736L, 2207893435808352L, 22317699616364044L, 234907967154122528L]
def results = [:].withDefault {[:]}
def langs = []
args.each {fileName ->
  def lang = fileName - ".csv"
  new File(fileName).eachLine {line ->
    def (fileLang, size, result, time) = line.split(",") as List
    assert fileLang == lang
    assert result as Long == answers[size as int]
    if (!langs.contains(lang)) langs << lang
    results[size][lang] = time
  }
}

println "N,${langs.join(",")}"
results.each {size, langResults ->
  print "$size,"
  langs.each {lang ->
    print(langResults.containsKey(lang) ? "${langResults[lang]}," : ",")
  }
  println ""
}
