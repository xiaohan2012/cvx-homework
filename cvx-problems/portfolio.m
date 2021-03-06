%% simple_portfolio_data
n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;

ret = pbar' * x_unif
%all_one = ones(n,1);
%
%cvx_begin
%    variables x(n)
%    minimize( x' * S * x )
%    subject to
%        pbar' * x == ret
%	sum(x) == 0
%	% all_one' * max(-x, 0) <= 0.5
%        % x >= 0
%cvx_end
