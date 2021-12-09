function animate(f, t, y, w, a, rn)
ny = size(y, 2);
set(f, 'Position', [300 300 600 600]);
ax = axes('Position', [0.05, 0.05, 0.9, 0.9]);
for k = 1:ny
    cla(ax);
    axis(ax, [-1.5, 1.5, -1.5, 1.5]);
    hold(ax, 'ON');
    plotFrame(ax, t(k), y(:, k), w, a, rn);
    pause(0.05)
end
end