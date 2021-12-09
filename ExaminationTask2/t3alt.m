%% Task 3:2
M = diag([1 2 3])/2;
K = [3 -1 -1; -1 3 -1; -1 -1 3]*1e3;
C = 5e-3*K;

%% Diagonalization
[X, D] = eig(K, M);
w0 = sqrt(diag(D));

m = enorm(X, M);
g = enorm(X, C);
k = enorm(X, K);

xi = g./(2*m.*w0);
wd = sqrt(1 - xi.^2).*w0;

%% Problem
P = [0 1 0]'*1e3;
w = 30;

%% Solving problem
F = 0;
for k = 1:3
    F = F + X(:, k)*X(:, k)'/(w0(k)^2 - w^2 + 2j*w0(k)*w*xi(k))/m(k);
end
tt = linspace(0, 1, 1000);
q = imag(F*P*exp(1j*w*tt));

f = figure();
plot(tt, q);
xlabel('Time');
ylabel('q');
lgd = legend('$x_1$', '$x_2$', '$x_3$');
set(lgd, 'Interpreter', 'Latex');
title('Solution to forced problem');
%% Functions
function V = enorm(X, A)
V = diag(X'*A*X);
end