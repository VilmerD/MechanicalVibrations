%% Task 3.7
m = 1;
k = 1e3;
a = 6e-3;

M = [m 0; 0 m];
K = k*[2 -1; -1 2];
C = a*K;

%% Solution
t0 = 0;
tf = 2;
fs = 1/100;
tt = t0:fs:tf;

r0 = 0.1*[-1; 1];
v0 = [0; 0];

P = 100*[1; 0];
w1 = 35;
w2 = 50;

[qh1, qp1] = forcedDamped(M, C, K, tt, r0, v0, P, w1);
q1 = qh1 + qp1;
[qh2, qp2] = forcedDamped(M, C, K, tt, r0, v0, P, w2);
q2 = qh2 + qp2;

%% Plot
f = figure(1);
label1 = sprintf('$\\omega = %i$', w1);
label2 = sprintf('$\\omega = %i$', w2);
aw  = 0.38;
ah  = 0.82;
awm = 0.10;
ahm = 0.10;

ax1 = axes(f, 'Position', [awm, ahm, aw, ah]);
hold(ax1, 'ON');
plot(ax1, tt, q1(1, :), 'Displayname', label1)
plot(ax1, tt, q2(1, :), 'Displayname', label2)
legend(ax1, 'Interpreter', 'Latex');
xlabel(ax1, 't');
ylabel(ax1, 'x');
title(ax1, 'Position of first mass');

ax2 = axes(f, 'Position', [2*awm + aw, ahm, aw, ah]);
hold(ax2, 'ON');
plot(ax2, tt, q1(2, :), 'Displayname', label1)
plot(ax2, tt, q2(2, :), 'Displayname', label2)
legend(ax2, 'Interpreter', 'Latex');
xlabel(ax2, 't');
ylabel(ax2, 'x');
title(ax2, 'Position of second mass');
%% Amplification
Z = @(s) s^2*M + s*C + K;