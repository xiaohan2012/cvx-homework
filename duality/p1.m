P = [1 -0.5; -0.5 2];
c = [1 0];

A = [1 2; 1 -4; -1 -1]

vals = [0 -0.1 0.1];
% vals = [0];

p_exact = 8.2222
y_opt = [3.3889 2.4444 0.0000]';

k = length(vals)
results = zeros(k, k);

for i = 1:k
  delta1 = vals(i);
  for j = 1:k
    delta2 = vals(j);
    u1 = -2 + delta1;
    u2 = -3 + delta2;
    b = [u1; u2; 5];

    p_est = p_exact - [delta1 delta2 0] * y_opt;
    
    cvx_begin
        cvx_quiet
        variables x(2);
        dual variable y;
            minimize( quad_form(x, P) - c * x)
        subject to
            y: A * x <= b
    cvx_end
    results(i, j) = p_est - cvx_optval;
  end
end
results


% test KKT

A * x <= b  % feasibility
(A * x - b) .* y  % comlemenary slackness
2 * P * x - c' + A' * y  % derative
