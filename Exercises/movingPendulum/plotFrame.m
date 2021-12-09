function plotPendulum(ax, y, F)
l = 1;
x = y(1);
theta = y(2);

px = x + l*sin(theta);
py = -l*cos(theta);

ball_radius = 1e-1;
plotCircle(ax, px, py, ball_radius);

plotCar(ax, x, 0);

L = [x 0; px py];
plot(ax, L(:, 1), L(:, 2), 'k');
plot(ax, [x, F], [0, 0], 'r');
plot(ax, [x, 0], [0, 0], 'g');
end

function plotCircle(ax, x, y, r)
tt = linspace(0, 2*pi, 25);
plot(ax, x + r*cos(tt), y + r*sin(tt), 'k');
end

function plotCar(ax, x, y)
l = 0.2;
h = 0.1;
cx = x + l/2*[-1  1 1 -1 -1];
cy = y + h/2*[-1 -1 1  1 -1];
plot(ax, cx, cy, 'k');

wheel_radius = 0.02;
bwx = x - l/2 + wheel_radius;
bwy = y - h/2 - wheel_radius;
plotCircle(ax, bwx, bwy, wheel_radius);

fwx = x + l/2 - wheel_radius;
fwy = y - h/2 - wheel_radius;
plotCircle(ax, fwx, fwy, wheel_radius);
end