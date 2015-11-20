include("aux.jl")

function foo()
  p = FramedPlot()
  t = linspace(-2.6, 2.6, 100)
  f(x) = x.^4-5x.^2+4 + sin((x-1)*3) + exp(-(x+1).^2)
  fd(x) = 4x.^3 - 10x + 3*cos((x-1)*3) - 2*(x-1)*exp(-(x+1).^2)
  add(p, Curve(t, f(t)))
  add(p, Curve( [t[1],t[end]], [0.0;0.0], linestyle="dashed"))
  xlim = [t[1],t[end]]
  setattr(p, "xrange", xlim)
  setattr(p, "yrange", [-3,5])
  createplotfile(p, "funex-1.png")
  a = 0.5
  add(p, Points( [a;a], [0.0;f(a)], symbolkind="circle", color="red"))
  add(p, Curve( [a;a], [0.0;f(a)], color="red", linestyle="dashed") )
  add(p, Curve( xlim, f(a) + fd(a)*(xlim-a), color="red") )
  createplotfile(p, "funex-2.png")
  b = a - f(a)/fd(a)
  add(p, Points( [b], [0.0], color="blue", symbolkind="circle") )
  createplotfile(p, "funex-3.png")
end

foo()
