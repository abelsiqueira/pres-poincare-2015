using Winston

include("aux.jl")

const colors = ["red", "blue", "green", "yellow"]

function ex1()
  t = linspace(-2,2,100)
  p = FramedPlot()
  f(x) = x.^2-1
  fd(x) = 2*x
  add(p, Curve(t, f(t)))
  add(p, Curve([-2;2], [0;0], linestyle="dashed"))
  setattr(p, "xrange", (-2,2))
  setattr(p, "yrange", (-1.5,2))
  createplotfile(p, "conv-ex1-1.png")
  a = 0.6
  for (i,x) = enumerate([-a;0;a])
    add(p, Points([x], [f(x)], color=colors[i], symbolkind="circle"))
    add(p, Curve(t, f(x)+fd(x)*(t-x), color=colors[i]))
  end
  createplotfile(p, "conv-ex1-2.png")
  add(p, Curve([1e-2;2.0], [0;0], color=colors[3]))
  add(p, Curve([-1e-2;-2.0], [0;0], color=colors[1]))
  createplotfile(p, "conv-ex1-3.png")
end

function ex2()
  t = linspace(-2,2,100)
  p = FramedPlot()
  f(x) = x.^3-x
  fd(x) = 3*x.^2-1
  add(p, Curve(t, f(t)))
  add(p, Curve([-2;2], [0;0], linestyle="dashed"))
  setattr(p, "xrange", (-2,2))
  setattr(p, "yrange", (-2,2))
  createplotfile(p, "conv-ex2-1.png")
  a, b = sqrt(5)/5, sqrt(3)/3
  L = [-b-2e-1;b+2e-1;a; b; -1.4; 1.4; -a; -b]
  for (i,x) = enumerate(L)
    j = (i-1)%length(colors)+1
    add(p, Points([x], [f(x)], color=colors[j], symbolkind="circle"))
    add(p, Curve(t, f(x)+fd(x)*(t-x), color=colors[j]))
  end
  add(p, Curve([a;a], [0;f(a)], color=colors[3], linestyle="dashed"))
  add(p, Curve([-a;-a], [0;f(-a)], color=colors[3], linestyle="dashed"))
  createplotfile(p, "conv-ex2-2.png")
  add(p, Curve([-1e-2-b;-2.0], [0;0], color=colors[1]))
  add(p, Curve([b+1e-2;2.0], [0;0], color=colors[2]))
  add(p, Curve([-a+1e-2;a-1e-2], [0;0], color=colors[3]))
  createplotfile(p, "conv-ex2-3.png")

  q = FramedPlot()
  qlog = FramedPlot()
  xlim = (floor(a,3),ceil(b,3))
  fl = floor(a,5)
  xloglim = (1e-5,ceil(b,5)-fl)
  setattr(q, "xrange", xlim)
  setattr(q, "yrange", (-1,1))
  setattr(qlog, "xrange", xloglim)
  setattr(qlog, "yrange", (-1,1))
  add(q, Curve([b+1e-5; xlim[2]], [0;0], color=colors[2]))
  add(q, Curve([xlim[1]; a-1e-5], [0;0], color=colors[3]))
  add(q, Points([a;b], [0;0], color="black", symbolkind="circle"))
  setattr(qlog, "xlog", true)
  add(qlog, Points([a-fl;b-fl], [0;0], color="black", symbolkind="circle"))
  s = b-1e-2
  while s > a+1e-5
    new = s
    while abs(new) < b
      new = new - f(new)/fd(new)
    end
    j = (new < 0 ? 1 : 2)
    add(q, Points([s], [0], color=colors[j], symbolkind="circle"))
    add(qlog, Points([s-fl], [0], color=colors[j], symbolkind="circle"))
    s = a + (s-a)*0.9
  end
  createplotfile(q, "conv-ex2-4.png")
  createplotfile(qlog, "conv-ex2-5.png")
end

function foo()
  ex1()
  ex2()
end

foo()
