using Winston

function newtonplot(f, fd, xlim, ylim, a, filename)
  p = FramedPlot()
  x = linspace(xlim[1], xlim[2], 100)
  s = a - f(a)/fd(a)
  add(p, Curve(x, f(x)))
  setattr(p, "xrange", xlim)
  setattr(p, "yrange", ylim)
  add(p, Curve(x, 0*x, linestyle="dashed"))
  add(p, Points([a], [f(a)], color="red", symbolkind="circle"))
  savefig(p, "$filename-s1.png", "width", 640, "height", 480)
  add(p, Curve(x, f(a) + fd(a)*(x-a), color="red"))
  savefig(p, "$filename-s2.png", "width", 640, "height", 480)
  add(p, Points([s], [f(s)], color="red", symbolkind="circle"))
  add(p, Curve([s;s], [0;f(s)], color="red", linestyle="dashed"))
  savefig(p, "$filename-s3.png", "width", 640, "height", 480)
  for i = 1:3
    run(`mogrify -fuzz 10% -transparent white $filename-s$i.png`)
  end
  return s
end

function foo()
  f(x) = exp(x).*x - 1
  fd(x) = exp(x) + exp(x).*x
  x = 0.2
  x = newtonplot(f, fd, (0,1), (-1,1.5), x, "newton1d1")
  x = newtonplot(f, fd, (0,1), (-1,1.5), x, "newton1d2")
  x = newtonplot(f, fd, (0,1), (-1,1.5), x, "newton1d3")
end

foo()
