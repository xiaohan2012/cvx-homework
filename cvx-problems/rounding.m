rng(0,'v5uniform');
n=100;
m=300;
A=rand(m,n);
b=A*ones(n,1)/2;
c=-rand(n,1);

rand('state',0);

cvx_begin
    variables x(n)
    minimize( c' * x)
    subject to
         A * x <= b
         0 <= x <= 1
cvx_end

k = 100;
ts = linspace(0, 1, k);
objvals = zeros(1, k);
for i = 1:k
  x_rounded = (x >= ts(i));
  max_viol = max(A * x_rounded - b);
  if max_viol > 0
    objvals(i) = Inf;
  else
    objvals(i) = c' * x_rounded
  end    
end
gap = objvals - cvx_optval;
