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

%% Unforced
q0 = [0; 0; 0];
qp0 = [0; 1; -10];

a = X'*M*q0./m;
b = X'*M*qp0./m./w0;

tt = linspace(0, 1, 1000);
q = X*(a.*cos(w0*tt) + b.*sin(w0*tt));
figure;
plot(tt, q);
xlabel('time [s]');
ylabel('y');
lgd = legend('$x_1$', '$x_2$', '$x_3$');
set(lgd, 'Interpreter', 'Latex');

%% Frequency
ww = linspace(0, 5*max(w0), 1000);
% xi = 0.01*ones(3, 1);
F22 = sum((X(2, :))'.*X(2, :)'./(w0.^2 - ww.^2 + 2j*w0*ww.*xi)./m);

figure();
tiledlayout(1, 2);

ax1 = nexttile;
A = abs(F22);
semilogx(ax1, ww, A);
grid(ax1, 'ON');
xlabel(ax1, '$\omega$', 'Interpreter', 'Latex');
ylabel(ax1, '$|F_{22}|$', 'Interpreter', 'Latex');

phi = angle(F22);
ax2 = nexttile;
semilogx(ax2, ww, phi);
grid(ax2, 'ON');
xlabel(ax2, '$\omega$', 'Interpreter', 'Latex');
ylabel(ax2, 'arg$(F_{22})$', 'Interpreter', 'Latex');
axis([ax1, ax2], 'tight');

%% Problem
P = [0 1 0]'*1e3;
w = 30;

%% Solving problem
p = X'*P;
th = w0/w;
damp = ((1 - th.^2).^2 + (2*xi.*th).^2).^(-1/2);
d = atan((2*xi.*th)./(1 - th.^2)) + pi*(th > 1);

tt = linspace(0, 30, 10000);
A = p./k.*damp;
et = A.*sin(w*tt - d);
a = -A.*sin(0-d);
b = (a.*xi.*w0 - A.*cos(0-d)*w)./wd;
q = X*(et + exp(-(xi.*w0)*tt).*(a.*cos(wd*tt) + b.*sin(wd*tt)));

f = figure();
plot(tt, q);
xlabel('t [s]');
ylabel('Amplitude [m]');
lgd = legend('$x_1$', '$x_2$', '$x_3$');
set(lgd, 'Interpreter', 'Latex');
title('Solution to forced problem');

%% Functions
function V = enorm(X, A)
V = diag(X'*A*X);
end