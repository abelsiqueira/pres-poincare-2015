function foo()
  β = 4
  f(x) = (1-x[1]^2) + β*(x[2]-x[1]^2)^2
  g(x) = [2*(x[1]-1) - 4*β*x[1]*(x[2]-x[1]^2);
          2*β*(x[2]-x[1]^2)]
  H(x) = [2 - 4*β*x[2] + 12*β*x[1]^2 -4*β*x[1];
          -4*β*x[1] 2*β]

  #f(x) = 5*x[1]^2 + 6*x[1]*x[2] + 5*x[2]^2
  #g(x) = [10*x[1]+6*x[2]; 6*x[1]+10*x[2]]
  #H(x) = [10 6; 6 10]

  x = [-0.5; 0.0]

  rnd(a) = ceil(a,4)

  file = open("conicas.list", "w")

  while norm(g(x)) > 0.10
    fx = f(x); gx = g(x); Hx = H(x);
    h = gx - Hx*x
    fplus = f(x) - dot(gx,x) + 0.5*dot(x,Hx*x)
    a, b, c = rnd(Hx[1,1]/2), rnd(Hx[2,1]), rnd(Hx[2,2]/2)
    d, e = rnd(h[1]), rnd(h[2])
    fset = rnd(fx)
    L(x) = a*x[1]^2 + b*x[1]*x[2] + c*x[2]^2 + d*x[1] + e*x[2] + fplus
    xv = rnd(x[1])
    yv = rnd(x[2])
    x = x - Hx\gx
    fmin = ceil(L(x)+1e-4, 4)
    write(file, "$a $b $c $d $e $(rnd(fplus)) $fset $fmin $xv $yv\n")
  end

  close(file)
end

foo()
