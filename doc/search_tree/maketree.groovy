// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-04-06

@Grab("org.apache.xmlgraphics:batik-transcoder:1.9.1")
@Grab("org.apache.xmlgraphics:batik-codec:1.9.1")
import groovy.xml.DOMBuilder
import groovy.xml.StreamingMarkupBuilder
import org.apache.batik.transcoder.image.PNGTranscoder
import org.apache.batik.transcoder.TranscoderInput
import org.apache.batik.transcoder.TranscoderOutput

import static java.lang.Integer.parseInt

def cli = new CliBuilder(usage: "maketree.groovy [options] size",
                         header: "Generate tree of N-Queens solutions.\nOptions:")
cli.h(longOpt: "help", args: 0, "Help")
cli._(longOpt: "lr", args: 0, "Generate LR (left->right digraph instead of top-bottom")

def options = cli.parse(args)
if (options.help || !options.arguments()) {
  cli.usage()
  System.exit(1)
}

int size = parseInt(options.arguments()[0])
Board board = new Board(size: size)
println """
digraph tree {
${options.lr ? "rankdir=LR;" : ""}
${board.node}"""
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
            ${this.name} -> ${next.name} [style="bold"; arrowsize="2.0"];""".stripIndent()
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
    def builder = new StreamingMarkupBuilder()
    def xml = builder.bind {
      namespaces << ["": "http://www.w3.org/2000/svg", "xl": "http://www.w3.org/1999/xlink"]
      svg(version: "1.1", viewBox: "-5 -5 ${size*100+10} ${size*100+10}", width: "${size*100}", height: "${size*100}") {
        def svg = delegate
        defs {
          style(type: "text/css", """
            .piece { font-size: 90px; font-weight: 400; }
            .blackp { fill: black; }
            .whitep { fill: white; stroke: black; stroke-width: 2px;}
          """)
          rect(id: "whitesquare", width: "100", height: "100", stroke: "black", "stroke-width": "3", fill: "#fff")
          rect(id: "blacksquare", width: "100", height: "100", stroke: "black", "stroke-width": "3", fill: "#ccc")
          g(id: "oddrow") {
            for (col in 1..size) {
              svg.use("xl:href": (col%2==0) ? "#blacksquare" : "#whitesquare", x: "${(col-1)*100}", y: "0")
            }
          }
          g(id: "evenrow") {
            for (col in 1..size) {
              svg.use("xl:href": (col%2==0) ? "#whitesquare" : "#blacksquare", x: "${(col-1)*100}", y: "0")
            }
          }
          g(id: "board") {
            for (row in 1..size) {
              svg.use("xl:href": (row%2==0) ? "#evenrow" : "#oddrow", x: "0", y: "${(row-1)*100}")
            }
            rect(x: "0", y: "0", width: "${size*100}", height: "${size*100}", stroke: "black", "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "8", fill: "none")
          }
          text(id: "blackqueen") {
            tspan(class: "blackp piece", x: "5", y: "80", "♛")
          }
        }
        g {
          svg.use("xl:href": "#board", x: "0", y: "0")
          positions.eachWithIndex {col, i ->
            svg.use("xl:href": "#blackqueen", x: "${(col-1)*100}", y: "${i*100}")
          }
        }
      }
    }
    def doc = DOMBuilder.parse(new StringReader(xml.toString()), false, true)
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

