rng(12345)
n = 5;
b = rand(n, 1);
one = ones(n, 1);

cvx_begin
    cvx_quiet
    variables x(1);
    dual variable y;
        minimize( norm(x * one - b, Inf))
cvx_end
x
median(b)
mean(b)
mean([max(b), min(b)])
sort(b)
