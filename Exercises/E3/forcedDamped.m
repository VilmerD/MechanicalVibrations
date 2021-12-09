function [qh, qp] = forcedDamped(M, C, K, tt, r0, v0, P, w)
% Defs
ndof = size(P, 1);

% Undamped free system
[X, W0sq] = eig(K, M);
W0 = diag(sqrt(W0sq));

% Normalization
mu = diag(X'*M*X);
kappa = diag(X'*K*X);
gamma = diag(X'*C*X);

xi = gamma./(2*W0.*mu);
Wd = W0.*sqrt(1 - xi.^2);

qp = zeros(ndof, 1);
qh = qp;
for k = 1:ndof
    xik = xi(k);
    w0k = W0(k);
    wdk = Wd(k);
    
    thetak = X(:, k)*X(:, k)'*M./mu(k);
    % Homogenous
    qh = qh + exp(-xik*w0k*tt).*(cos(wdk*tt) + xik*w0k/wdk*sin(wdk*tt)).*(thetak*r0) + ...
        exp(-xik*w0k*tt).*sin(wdk*tt).*(thetak/wdk*v0);
    
    % Particulate
    muk = mu(k);
    gammak = gamma(k);
    kappak = kappa(k);
    d = atan(gammak*w/(kappak - muk*w^2)) + pi*(w/w0k > 1);
    g = ((1 - (w/w0k)^2)^2 + 4*xik^2*(w/w0k)^2).^(-1/2);
    pk = X(:, k)'*P;
    qp = qp + X(:, k).*pk/kappak*g*(sin(w*tt - d) + exp(-xik*w0k*tt).*...
        (sin(d)*cos(wdk*tt) + (xik*w0k/wdk*sin(d) - w/wdk*cos(d))*sin(wdk*tt)));
end
end