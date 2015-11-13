using Images

function fractal(F, J, xm, xM, roots;
    W = 640, H = 640, ϵ = 1e-2, max_iter = 20)
  M = zeros(Int, W, H)
  N = size(roots, 2)
  d = zeros(2)
  for (i,a) in enumerate(linspace(xm[1], xM[1], W))
    for (j,b) in enumerate(linspace(xm[2], xM[2], H))
      x,y = a,b
      iter = 0
      while norm(F(x,y)) > ϵ
        try
          d = -J(x,y)\F(x,y)
        catch
          break
        end
        x += d[1]
        y += d[2]
        iter += 1
        if iter >= max_iter
          break
        end
      end
      if norm(F(x,y)) < ϵ
        M[i,j] = indmin( [norm(roots[:,k]-[x;y]) for k = 1:N] )
      end
    end
  end
  return M
end

function frac_save(M, filename)
  (m,n) = size(M)
  img = zeros(n, m, 3)
  for i = 1:m
    for j = 1:n
      img[j,i,1] = M[i,j]%2
      img[j,i,2] = div(M[i,j],2)%2
      img[j,i,3] = div(M[i,j],4)%2
    end
  end
  imwrite(Images.colorim(img), filename)
end

function foo()
  F(x,y) = [x^2+y^2-4; x*y-1]
  J(x,y) = [2*x 2*y; y x]
  r,s = sqrt(2+sqrt(3)), sqrt(2-sqrt(3))
  roots = [r s -r -s; s r -s -r]
  M = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, "ex1.png")

  F(x,y) = [x^3-3*x*y^2-1; 3*x^2*y-y^3]
  J(x,y) = [3*x^2-3*y^2 -6*x*y; 6*x*y 3*x^2-3*y^2]
  roots = [cos([0 2pi/3 4pi/3]); sin([0 2pi/3 4pi/3])]
  M = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, "ex2.png")
end

foo()
