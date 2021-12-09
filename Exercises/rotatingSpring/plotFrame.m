function plotFrame(ax, t, y, w, a, rn)
R = 1;
mR = 0.05;
r = y(1);
psi = y(2);
theta = w*t;
Rm = [cos(theta) -sin(theta)
     sin(theta) cos(theta)];

V = [a + r*cos(psi)
     r*sin(psi)];
V0 = Rm*V;
A = Rm*[a; 0];
PV = [A V0];

plotCircle(ax, V0(1), V0(2), mR);       % Mass
plot(ax, PV(1, :), PV(2, :), 'r');      % Spring
plotCircle(ax, 0, 0, R);                % Disk
N = [[0; 0], Rm*[0; R]];
plot(ax, N(1, :), N(2, :), 'k');
end

function plotCircle(ax, x, y, r)
tt = linspace(0, 2*pi, 50);
plot(ax, x + r*cos(tt), y + r*sin(tt), 'k');
end