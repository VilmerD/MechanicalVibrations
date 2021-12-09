%% Undamped free system
m = 1;
k = 1e4;
M = m*diag([2 3 1]);
K = k*[5 -3 0; -3 5 -2; 0 -2 3];

[X, W0sq] = eig(K, M);
W0 = sqrt(diag(W0sq));
clear W0sq

%% Damped
C = 1e-3*K;

%% Normalization
mu = diag(X'*M*X);
gamma = diag(X'*C*X);
kappa = diag(X'*K*X);

%% Dampening
xi = gamma./(2*W0.*mu);
Wd = W0.*sqrt(1 - xi.^2);

%% Impendance
Z = @(w) -w^2*M + 1i*w*C + K;
Z11 = @(w) -w^2*M(2:3, 2:3) + 1i*w*C(2:3, 2:3) + K(2:3, 2:3);
a11 = @(w) det(Z11(w));
ww = linspace(0, max(W0), 1000);
av = [];
for k = 1:numel(ww)
    av(k) = abs(a11(ww(k)));
end

plot(ww, av);