%% Setup system
m = 0.5;
k = 10;
w = 1;
rn = 0.3;
a = 0.2;
c = m*w^2/k; fprintf('System valid: %i\n', c < 1);

f = @(t, y, yp) rotatingSpringSystem(y, yp, m, k, w, rn, a);
tt = linspace(0, 20, 200);

%% Initial conditions
r0 = (rn + c*a)/(1 - c)*0.95;
y0 = [r0 0 0 0]';
ddr0 = w^2*(a + r0) - k/m*(r0 - rn);
yp0 = [0 0 ddr0 0]';

%% Solve
f0 = norm(f(0, y0, yp0), 2); fprintf('IVs valid: %i\n', f0<4*sqrt(eps))

[t, y] = ode15i(f, tt, y0, yp0);

%% Plot
f = figure;
animate(f, t, y', w, a, rn);

%%
f = figure;
ax = nexttile;
r = y(:, 1);
psi = y(:, 2);
hold(ax, 'on');
yyaxis(ax, 'left');
plot(ax, t, r.*cos(psi));
yyaxis(ax, 'right');
plot(ax, t, r.*sin(psi));