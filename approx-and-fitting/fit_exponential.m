n = 201;
t = linspace(-3, 3, n)';
y = exp(t);
T_numer = [ones(n, 1), t, t.^2];
T_denum = [t, t.^2];

lower = 0;
upper = 21;
eps = 0.001;
while(abs(upper - lower) >= eps)
  gamma = mean([lower, upper]);

  cvx_begin quiet
    % cvx_quiet;
    variables a(3) b(2);
    subject to
      abs((T_numer * a)  - y .* (1 + T_denum * b)) <= gamma * (1 + T_denum * b)
  cvx_end   

  if(strcmp(cvx_status,'Solved'))
    upper = gamma;
    feas_a = a;
    feas_b = b;
    feas_opt = cvx_optval;
  else
    lower = gamma;
  end
  sprintf('lower, upper = %f, %f', lower, upper)
end  

lower
upper
feas_a
feas_b
feas_opt
