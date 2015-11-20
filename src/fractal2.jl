using Images

function fractal(F, J, xm, xM, roots;
    W = 640, H = 640, ϵ = 1e-2, max_iter = 20)
  M = zeros(Int, W, H)
  I = zeros(Int, W, H)
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
      I[i,j] = iter
    end
  end
  return M, I
end

function frac_save(M, I, filename)
  (m,n) = size(M)
  img = zeros(n, m, 3)
  max_iter = maximum(I)
  for i = 1:m
    for j = 1:n
      r = (max_iter-I[i,n-j+1])/max_iter
      img[j,i,1] = M[i,n-j+1]%2 * r
      img[j,i,2] = div(M[i,n-j+1],2)%2 * r
      img[j,i,3] = div(M[i,n-j+1],4)%2 * r
    end
  end
  imwrite(Images.colorim(img), filename)
end

function foo()
  F(x,y) = [x^2+y^2-4; x*y-1]
  J(x,y) = [2*x 2*y; y x]
  r,s = sqrt(2+sqrt(3)), sqrt(2-sqrt(3))
  roots = [r s -r -s; s r -s -r]
  M, I = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, I, "fractal3.png")

  F(x,y) = [x^3-3*x*y^2-1; 3*x^2*y-y^3]
  J(x,y) = [3*x^2-3*y^2 -6*x*y; 6*x*y 3*x^2-3*y^2]
  roots = [cos([0 2pi/3 4pi/3]); sin([0 2pi/3 4pi/3])]
  M, I = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, I, "fractal4.png")

  F(x,y) = [x*(y-x^2); (x^2-1)*(y+1)]
  J(x,y) = [y-3*x^2 x; 2x*(y+1) x^2-1]
  roots = [0.0 1.0 -1.0; -1.0 1.0 1.0]
  M, I = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, I, "fractal5.png")

  F(x,y) = [x^4-6*x^2*y^2+y^4-1; -4*x^3*y+4*x*y^3]
  J(x,y) = [4*x^3-12*x*y^2 -12*x^2*y+4*y^3;
      -12*x^2*y+4*y^3 -4*x^3+12*x*y^2]
  roots = [1.0 0.0 -1.0 0.0; 0.0 1.0 0.0 -1.0]
  M, I = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, I, "fractal6.png")

  F(x,y) = [3x^2-3x; 2y]
  J(x,y) = [6x-3 0.0; 0.0 2.0]
  roots = [1.0 -1.0; 0.0 0.0]
  M, I = fractal(F, J, (-2.0,-2.0), (2.0,2.0), roots)
  frac_save(M, I, "fractal7.png")
end

foo()
