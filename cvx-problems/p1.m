cvx_begin
    variables x1 x2;
    minimize( x1^2 + 9*x2^2)
    subject to
        x1 >= 0
        x2 >= 0
        2 * x1 + x2 >= 1
        x1 + 3 * x2 >= 1
cvx_end
