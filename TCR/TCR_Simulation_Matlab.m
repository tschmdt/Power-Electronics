%% 1) Change a to change firing angle
    % run simulation then run second section

open_system('TCR_Simulation')
a = 140;
out= sim('TCR_Simulation')

%% 2) Plot

fontname = 'Helvetica';

t = out.Load_Voltage.time;
U_a = out.Load_Voltage.Data;
I_a = out.I_TCR.Data;

plot(t, U_a, t, I_a, 'LineWidth', 2)

hold on;

% Add labels
xlabel('Time (s)');
ylabel('Amplitude U,I');
title('I_{TCR} -Abhängigkeit vom Zündwinkel \alpha');

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca, 'FontSize', 14);

x = ((a + 360) / 360) * (1 / 50);

if a == 90
    xline(x, '--', ['\alpha = ', num2str(a), '°'], ...
        'LabelHorizontalAlignment', 'right', ...
        'LabelOrientation', 'horizontal', ...
        'LineWidth', 1.5,'FontSize', 14);
elseif a > 90 && a < 165
    xline(x, '--', ['\alpha > 90° (\alpha = ', num2str(a), '°)'], ...
        'LabelHorizontalAlignment', 'right', ...
        'LabelOrientation', 'horizontal', ...
        'LineWidth', 1.5,'FontSize', 14);
elseif a >= 165 && a <= 180
    xline(x, '--', ['\alpha ~ 180° (\alpha = ', num2str(a), '°)'], ...
        'LabelHorizontalAlignment', 'right', ...
        'LabelOrientation', 'horizontal', ...
        'LineWidth', 1.5,'FontSize', 14);
end




legend('Load Voltage U', 'TCR Current I', 'FontSize', 14);

hold off;

%% 1 Plot with 3 subplots
% difficult to achieve, since the signals need to get overwritten by
% restarting the simulation 

fontname = 'Helvetica';

t = out.Load_Voltage.time;
U_a = out.Load_Voltage.Data;
I_a = out.I_TCR.Data;

firing_angle = [90, 125, 165];

figure;

for i = firing_angle
    out= sim('TCR_Simulation')
    subplot(length(i, 1, i)

    plot(t, U_a, t, I_a, 'LineWidth', 2)
   

end

