function foo()
  function newton_exemplo(a, file)
    x = copy(a)
    f(x) = x^3-x
    fd(x) = 3*x^2-1
    while abs(f(x)) > 1e-6
      if abs(fd(x)) < 1e-6
        write(file, "f'($a) é muito próximo de zero\n")
      elseif x > sqrt(3)/3
        write(file, "$a --> 1.0\n"); break
      elseif x < -sqrt(3)/3
        write(file, "-1.0 <-- $a\n"); break
      elseif abs(x) < sqrt(5)/5
        write(file, "$a vai pra 0.0\n"); break
      end
      x = x - f(x)/fd(x)
    end
  end

  file = open("ex1.txt", "w")
  for a in linspace(-2, 2, 21)
    newton_exemplo(a, file)
  end
  close(file)

  file = open("ex2.txt", "w")
  a, b = sqrt(3)/3, sqrt(5)/5
  while a > b + 1e-12
    newton_exemplo(a, file)
    a = b + (a-b)/2
  end
  close(file)
end

foo()
