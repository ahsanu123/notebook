#import "@preview/lilaq:0.5.0" as lq
#let weierstrass(x, k: 8) = {
  range(k).map(k => calc.pow(0.5, k) * calc.cos(calc.pow(5, k) * x)).sum()
}

#let xs = lq.linspace(-0.5, .5, num: 1000)
#let xs-fine = lq.linspace(-0.05, 0, num: 1000)

#show: lq.set-grid(stroke: none)

#lq.diagram(
  ylim: (0, 2),
  margin: (x: 2%),

  lq.plot(xs, weierstrass, mark: none),

  lq.rect(-0.05, 1.5, width: .05, height: .3),

  lq.place(
    60%, 100% - 1.2em, 
    align: bottom,
    lq.diagram(
      width: 2cm, height: 1cm, 
      margin: 0%,
      ylim: (1.5, 1.8),
      fill: white,
      lq.plot(xs-fine, weierstrass, mark: none),
    )
  )
)
