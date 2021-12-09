function f = rotatingSpringSystem(y, yp, m, k, w, rn, a)
r =     y(1);   adr =   yp(1);
psi =   y(2);   adpsi = yp(2);
dr =    y(3);   ddr =   yp(3);
dpsi =  y(4);   ddpsi = yp(4);

f1 = m*(ddr - w^2*(a*cos(psi) + r) - 2*w*dpsi*r - r*dpsi^2) + k*(r - rn);
f2 = m*(2*w*r*dr + 2*r*dr*dpsi + r^2*ddpsi + w^2*a*r*sin(psi));
f3 = dr - adr;
f4 = dpsi - adpsi;
f = [f1; f2; f3; f4];
end