function f = movingPendulumSystem(t, y, yp, M, l, k, F)
m = M(1);
mc = M(2);
mt = m + mc;
g = 9.82;

f = [mt*yp(3) + m*l*yp(4)*cos(y(2)) - m*l*y(4)^2 + k*y(1) - F(t)
     m*l*cos(y(2))*yp(3) + m*l^2*yp(4) + m*g*l*sin(y(2))
     yp(1) - y(3)
     yp(2) - y(4)];
end