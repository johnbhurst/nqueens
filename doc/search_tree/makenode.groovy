// Copyright 2018 John Hurst
// john.b.hurst@gmail.com
// 2018-04-06

// Print nxn partially filled N-Queens board.
// makenode.groovy size pos1 pos2 pos3 ...

import groovy.xml.StreamingMarkupBuilder
import groovy.xml.XmlUtil

int size = args[0] as int
List<Integer> positions = args.tail().collect {it as int}

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
          svg.use("xl:href": (col%2==0) ? "whitesquare" : "#blacksquare", x: (col-1)*100, y: 0)
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

println XmlUtil.serialize(writer)