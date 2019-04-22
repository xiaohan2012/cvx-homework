clear all; close all;

mu1 = 8;
mu2 = 20;
sigma1 = 6;
sigma2 = 17.5;
rho = -0.25;

N = 100;

r = linspace(-30, 70, N)';
R = log(exp(r) * exp(r'));
mask = (R <= 0);


pr1 = exp(-(r - mu1) .^ 2 / (2 * sigma1^2));
pr1 = pr1 / sum(pr1);

pr2 = exp(-(r - mu2) .^ 2 / (2 * sigma2^2));
pr2 = pr2 / sum(pr2);


cvx_begin
    cvx_quiet
    variables P(N, N);
    maximize( sum(sum(P(mask))))
    subject to
        sum(P, 2) == pr1;
        sum(P, 1)' == pr2;
	(r - mu1)' * P * (r - mu2) == rho * sigma1 * sigma2;
        P >= 0;
	sum(sum(P)) == 1;
cvx_end

P = full(P);
r1p = r*ones(1,N); r2p = ones(N,1)*r';
figure(1); mesh(r1p, r2p, P');
xlabel('R1'); ylabel('R2'); zlabel('density');
print -depsc 'loss_bounds_mesh.png'


figure(2); contour(r1p, r2p, P');
xlabel('R1'); ylabel('R2'); grid on;
print -depsc 'loss_bounds_cont.png'

