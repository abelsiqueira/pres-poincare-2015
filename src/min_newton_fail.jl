using Gadfly

function quad(f::Function, g::Vector, H::Matrix, xm, xM, a, lvls, filename)
  fx = f(a); s = a - H\g; fs = f(s)
  m(x) = fx + dot(g,x-a) + 0.5*dot(x-a,H*(x-a))
  qlvls = fs + (fx-fs)*( 1.5.^collect(-10:15) )
  x = linspace(xm[1], xM[1], 200)
  y = linspace(xm[2], xM[2], 200)
  fx = round(fx,2)
  p = plot(
    layer(x=x, y=y, z=(x,y)->f([x;y]), Geom.contour(levels=lvls)),
    layer(x=[a[1]], y=[a[2]], Geom.point), Theme(key_position=:none))
  draw(PNG("$filename-1.png", 20cm, 15cm), p)
  p = plot(
    layer(x=x, y=y, z=(x,y)->m([x;y]), Geom.contour(levels=qlvls)),
    layer(x=x, y=y, z=(x,y)->f([x;y]), Geom.contour(levels=lvls)),
    layer(x=[a[1]], y=[a[2]], Geom.point), Theme(key_position=:none))
  draw(PNG("$filename-2.png", 20cm, 15cm), p)
  p = plot(
    layer(x=x, y=y, z=(x,y)->m([x;y]), Geom.contour(levels=qlvls)),
    layer(x=x, y=y, z=(x,y)->f([x;y]), Geom.contour(levels=lvls)),
    layer(x=[a[1],s[1]], y=[a[2],s[2]], Geom.point), Theme(key_position=:none))
  draw(PNG("$filename-3.png", 20cm, 15cm), p)
  return s
end

function foo()
  f(x) = x[1]^3-3*x[1] + x[2]^2
  g(x) = [3*x[1]^2-3; 2*x[2]]
  H(x) = [6*x[1] 0.0; 0.0 2.0]

  lvls = linspace(f([1.0;0.0]), f([-1.0;-2.0]), 30)
  lvls = sort([lvls; f([-1.0;0.0])])

  t = linspace(-2, 2, 200)

  x = [0.5;0.0]
  for i = 1:3
    x = quad(f, g(x), H(x), (-2.0,-2.0), (2.0,2.0), x, lvls, "min-newton-works$i")
  end

  x = [-0.5;0.0]
  for i = 1:3
    x = quad(f, g(x), H(x), (-2.0,-2.0), (2.0,2.0), x, lvls, "min-newton-fail$i")
  end
end

foo()
