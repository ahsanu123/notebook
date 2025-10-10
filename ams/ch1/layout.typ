#import "@preview/cetz:0.4.2"

#set page(flipped: true)
// #set heading(numbering: "1.1.")
// #set figure(numbering: "Fig 1.1.")
// #set math.equation(numbering: "Eq1.1.")
// #set par(justify: true)

/*
* div(
*   footer()
* )
* */

#let HEIGHT = 16
#let WIDTH = 25
#let START_POINT = (0,0)


#cetz.canvas({
  import cetz.draw: *

  grid(START_POINT, (WIDTH, HEIGHT), help-lines: true, step: 0.2)

  rect((0,HEIGHT), (WIDTH, HEIGHT - 2), name: "header")
  content("header", [ = Header], anchor: "north-east")

})
