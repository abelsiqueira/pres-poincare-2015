using Gadfly

function quad(f::Function, g::Vector, H::Matrix, xm, xM, a, filename)
  fx = f(a); s = a - H\g; fs = f(s)
  m(x) = fx + dot(g,x-a) + 0.5*dot(x-a,H*(x-a))
  lvls = fs + (fx-fs)*( 1.5.^collect(-10:15) )
  x = linspace(xm[1], xM[1], 200)
  y = linspace(xm[2], xM[2], 200)
  fx = round(fx,2)
  p = plot(
    layer(x=x, y=y, z=(x,y)->f([x;y]), Geom.contour(levels=[0.01;fx;2*fx])),
    layer(x=x, y=y, z=(x,y)->m([x;y]), Geom.contour(levels=lvls)),
    layer(x=[a[1],s[1]], y=[a[2],s[2]], Geom.point))
  draw(PNG(filename, 20cm, 15cm), p)
  return s
end

function foo()
  f(x) = (1-x[1])^2 + 4*(x[2]-x[1]^2)^2
  g(x) = [-2+2x[1]-16*x[1]*(x[2]-x[1]^2); 8*(x[2]-x[1]^2)]
  H(x) = [2-16*x[2]+48*x[1]^2 -16*x[1]; -16*x[1] 8]

  lvls = 0.1*linspace(1, 150, 100).^2

  t = linspace(-2, 2, 100)
  p = Gadfly.plot(x=t, y=t, z=(x,y)->f([x;y]), Geom.contour(levels=lvls))
  draw(PNG("rosenbr1.png", 20cm, 15cm), p)

  x = [-0.5;0.0]
  for i = 2:6
    x = quad(f, g(x), H(x), (-2.0,-2.0), (2.0,2.0), x, "rosenbr$i.png")
  end
end

foo()
