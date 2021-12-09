%% Solving system
F = @(t) ((1.5.^t).^t - 1).*(t < 2.5);
M = [1, 1];
l = 1;
k = 2;

f = @(t, y, yp) movingPendulumSystem(t, y, yp, M, l, k, F);
y0 = [0, 0, 0, 0]';
yp0 = [0, 0, 0, 0]';
tspan = 0:0.1:10;
[t, y] = ode15i(f, tspan,y0, yp0);

%%
x = y(:, 1);
theta = y(:, 2);
px = x + l*sin(theta);
py = -l*cos(theta);
plot(px, py);

%%
f = figure;
animate(f, y', F(t));