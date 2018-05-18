// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-04-06

@Grab("org.apache.xmlgraphics:batik-transcoder:1.9.1")
@Grab("org.apache.xmlgraphics:batik-codec:1.9.1")
import groovy.xml.StreamingDOMBuilder
import groovy.xml.XmlUtil
import groovy.xml.QName
import org.apache.batik.transcoder.image.PNGTranscoder
import org.apache.batik.transcoder.TranscoderInput
import org.apache.batik.transcoder.TranscoderOutput
import org.apache.batik.anim.dom.SVGDOMImplementation
import org.apache.batik.anim.dom.SVGOMDocument
import org.apache.batik.dom.util.DOMUtilities
import org.apache.batik.util.SVGConstants

import static java.lang.Integer.parseInt

int size = parseInt(args[0])
Board board = new Board(size: size)
println """
digraph tree {
  ${board.node}
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
          ${next.node}
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

  String getNode() {
    return """${this.name} [image="${this.name}.png", label="", shape=none];"""
  }

  void save() {
    def builder = new StreamingDOMBuilder()
    def xml = builder.bind {
      mkp.declareNamespace("": "http://www.w3.org/2000/svg")
      mkp.declareNamespace("xl": "http://www.w3.org/1999/xlink")
      //namespaces << ["": "http://www.w3.org/2000/svg", "xl": "http://www.w3.org/1999/xlink"]
      svg(version: "1.1", viewBox: "-5 -5 ${size*100+10} ${size*100+10}", width: "${size*100}", height: "${size*100}") {
        def svg = delegate
        svg.use("xl:href": "tryme.svg")

        // defs {
          // style(type: "text/css", """
          //   .piece { font-size: 90px; font-weight: 400; }
          //   .blackp { fill: black; }
          //   .whitep { fill: white; stroke: black; stroke-width: 2px;}
          // """)
          // rect(id: "whitesquare", width: "100", height: "100", stroke: "black", "stroke-width": "3", fill: "#ddd")
          // rect(id: "blacksquare", width: "100", height: "100", stroke: "black", "stroke-width": "3", fill: "#666")
          // g(id: "oddrow") {
          //   for (col in 1..size) {
          //     svg.use("xl:href": (col%2==0) ? "#blacksquare" : "#whitesquare", x: "${(col-1)*100}", y: "0")
          //   }
          // }
          // g(id: "evenrow") {
          //   for (col in 1..size) {
          //     svg.use("xl:href": (col%2==0) ? "#whitesquare" : "#blacksquare", x: "${(col-1)*100}", y: "0")
          //   }
          // }
          // g(id: "board") {
          //   for (row in 1..size) {
          //     svg.use("xl:href": (row%2==0) ? "#evenrow" : "#oddrow", x: "0", y: "${(row-1)*100}")
          //   }
          //   rect(x: "0", y: "0", width: "${size*100}", height: "${size*100}", stroke: "black", "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "8", fill: "none")
          // }
          // text(id: "blackqueen") {
          //   tspan(class: "blackp piece", x: "5", y: "80", "♛")
          // }
        // }
        // g {
        //   svg.use("xl:href": "#board", x: "0", y: "0")
        //   positions.eachWithIndex {col, i ->
        //     svg.use("xl:href": "#blackqueen", x: "${(col-1)*100}", y: "${i*100}")
        //   }
        // }
      }
    }

    def doc = xml()
    println "doc class = [${doc.getClass()}]"
    def root = doc.documentElement
    println "root class = [${root.getClass()}]"
    println "namespace URI = [${root.namespaceURI}]"
    println "localName = [${root.localName}]"
    println "tagName = [${root.tagName}]"
    println "prefix = [${root.prefix}]"
    println "baseURI = [${root.baseURI}]"
    println "nodeName = [${root.nodeName}]"
    println "isDefaultNamespace = [${root.isDefaultNamespace()}]"
    println "root XML = [${XmlUtil.serialize(root)}]"
    // def childList = root.childNodes
    // println "childList class = [${childList.getClass()}]"
    // println "child list length = [${childList.size()}]"
    def firstChild = root.firstChild
    println "firstChild class = [${firstChild.getClass()}]"
    println "namespace URI = [${firstChild.namespaceURI}]"
    println "localName = [${firstChild.localName}]"
    println "tagName = [${firstChild.tagName}]"
    println "prefix = [${firstChild.prefix}]"
    println "baseURI = [${firstChild.baseURI}]"
    println "nodeName = [${firstChild.nodeName}]"
    println "isDefaultNamespace = [${firstChild.isDefaultNamespace()}]"

    def attrs = firstChild.attributes
    println "attrs class = [${attrs.getClass()}]"
    def item = attrs.item(0)
    println "item class = [${item.getClass()}]"
    println "namespace URI = [${item.namespaceURI}]"
    println "localName = [${item.localName}]"
    println "prefix = [${item.prefix}]"
    println "baseURI = [${item.baseURI}]"
    println "nodeName = [${item.nodeName}]"
    println "isDefaultNamespace = [${item.isDefaultNamespace()}]"


    File file = new File(name + ".png")
    assert !file.exists(), "file $file.name already exists"
    PNGTranscoder transcoder = new PNGTranscoder()
    TranscoderInput input = new TranscoderInput(doc)
    file.withOutputStream {os ->
      TranscoderOutput output = new TranscoderOutput(os)
      transcoder.transcode(input, output)
    }
  }
}

