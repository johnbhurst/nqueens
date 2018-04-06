// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-04-06

import groovy.xml.StreamingMarkupBuilder
import groovy.xml.XmlUtil

import static java.lang.Integer.parseInt

int size = parseInt(args[0])
Board board = new Board(size: size)
println """
digraph tree {
  ${board.name} [image="${board.name}.svg", label="", shape=none];
"""
board.save()
board.solve()
println "}"

class Board {
  private int size
  private List<Integer> positions = []
  private int row
  private long cols
  private long diags1
  private long diags2

  private Board place(int col) {
    return new Board(
      size: this.size,
      positions: this.positions + (col+1),
      row: this.row + 1,
      cols: this.cols | 1 << col,
      diags1: this.diags1 | 1 << (this.row + col),
      diags2: this.diags2 | 1 << (this.row - col + this.size - 1)
    )
  }

  private boolean ok(int col) {
    return (this.cols & (1 << col)) == 0 &&
      (this.diags1 & (1 << this.row + col)) == 0 &&
      (this.diags2 & (1 << this.row - col + this.size - 1)) == 0
  }

  public int solve() {
    if (this.row == this.size) {
      return 1
    }
    else {
      int result = 0
      for (int col = 0; col < this.size; col++) {
        if (ok(col)) {
          Board next = place(col)
          println """
          ${next.name} [image="${next.name}.svg", label="", shape=none];
          ${this.name} -> ${next.name};
          """
          next.save()
          result += next.solve()
        }
      }
      return result
    }
  }

  String getName() {
    return "board_${size}_${positions.join('_')}"
  }

  void save() {
    File file = new File(name + ".svg")
    assert !file.exists(), "file $file.name already exists"

    def xml = new StreamingMarkupBuilder()
    def writer = xml.bind {
      mkp.xmlDeclaration(version: "1.0", encoding: "utf-8")
      mkp.declareNamespace(xl: "http://www.w3.org/1999/xlink")
      svg(version: "1.1", xmlns: "http://www.w3.org/2000/svg", viewBox: "-5 -5 ${size*100+10} ${size*100+10}", width: size*100, height: size*100) {
        def svg = delegate
        defs {
          style(type: "text/css") {
            mkp.yieldUnescaped("""<![CDATA[
            .piece { font-size: 90px; font-weight: 400; }
            .blackp { fill: black; }
            .whitep { fill: white; stroke: black; stroke-width: 2px;}
          ]]>""")
          }
          rect(id: "whitesquare", width: 100, height: 100, stroke: "black", "stroke-width": 3, fill: "#ddd")
          rect(id: "blacksquare", width: 100, height: 100, stroke: "black", "stroke-width": 3, fill: "#666")
          g(id: "oddrow") {
            for (col in 1..size) {
              svg.use("xl:href": (col%2==0) ? "#blacksquare" : "#whitesquare", x: (col-1)*100, y: 0)
            }
          }
          g(id: "evenrow") {
            for (col in 1..size) {
              svg.use("xl:href": (col%2==0) ? "#whitesquare" : "#blacksquare", x: (col-1)*100, y: 0)
            }
          }
          g(id: "board") {
            for (row in 1..size) {
              svg.use("xl:href": (row%2==0) ? "#evenrow" : "#oddrow", x: 0, y: (row-1)*100)
            }
            rect(x: 0, y: 0, width: size*100, height:size*100, stroke: "black", "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": 8, fill: "none")
          }
          text(id: "blackqueen") {
            tspan(class: "blackp piece", x: "5", y: "80") {
              mkp.yieldUnescaped("&#x265B;")
            }
          }
        }
        g {
          svg.use("xl:href": "#board", x: "0", y: "0")
          positions.eachWithIndex {col, i ->
            svg.use("xl:href": "#blackqueen", x: (col-1)*100, y: i*100)
          }
        }
      }
    }

    file.text = XmlUtil.serialize(writer)
  }
}

