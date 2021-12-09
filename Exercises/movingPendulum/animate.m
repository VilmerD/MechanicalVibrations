function animate(f, y, F)
ny = size(y, 2);
set(f, 'Position', [300 300 1200 300]);
ax = axes('Position', [0.05, 0.05, 0.9, 0.9]);
for k = 1:ny
    cla(ax);
    axis(ax, [-2, 10, -1.5, 1.5]);
    hold(ax, 'ON');
    plotFrame(ax, y(:, k), F(k));
    pause(0.2);
end
end