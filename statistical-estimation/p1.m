ml_estim_incr_signal_data_norng;

D = (diag(ones(N, 1)) + diag(-ones(N-1, 1), 1));
D = D(1:end-1, :);

cvx_begin
    cvx_quiet
    variables x_ml(N);
    y_hat = conv(h,x_ml)
    minimize( norm( y_hat(1:end-3)- y, 2))
    subject to
        x_ml >= 0
        x_ml(1:end-1) <= x_ml(2:end)
cvx_end

x_ml
ml_optval = cvx_optval

cvx_begin
    cvx_quiet
    variables x_ml_free(N);
    y_hat = conv(h,x_ml_free)
    minimize( norm( y_hat(1:end-3)- y, 2))
cvx_end

x_ml_free
ml_free_optval = cvx_optval
ml_optval
