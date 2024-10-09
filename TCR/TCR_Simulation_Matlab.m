%% Plot with 4 subplots
    % Change alpha to change firing angle
    % Best if plot @ 90°, 125°, 165°
    
open_system('TCR_Simulation')

a = 125;
out= sim('TCR_Simulation')

fontname = 'Helvetica';

t = out.Load_Voltage.time;
U_a = out.Load_Voltage.Data;
I_a = out.I_TCR.Data*2;

figure;
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
    plot([0.019998 0.019998], [0 390],'--', 'LineWidth', 1, 'Color', [0.6510    0.6510    0.6510]); %fix line
    plot([x x], [0 390], '--', 'LineWidth', 1, 'Color', [0.6510    0.6510    0.6510]); % variable line
    Start = [0.01998 350];
    End = [x 350];
    arrow(Start, End, 'Length', 5, 'Width', .5, 'Color', [0.6510    0.6510    0.6510]);
    text(x+0.001, 353, ['\alpha = ', num2str(a), '°'], 'HorizontalAlignment', 'left', 'FontSize', 14);
elseif a > 90 && a < 165
     plot([0.019998 0.019998], [0 230],'--', 'LineWidth', 1, 'Color', [0.6510    0.6510    0.6510]); %fix line
     plot([x x], [0 230], '--', 'LineWidth', 1,'Color', [0.6510    0.6510    0.6510]); % variable line
     Start = [0.01998 200];
     End = [x 200];
    arrow(Start, End, 'Length', 5, 'Width', .5, 'Color', [0.6510    0.6510    0.6510]);     text(x+0.001, 203, ['\alpha > 90° (\alpha = ', num2str(a), '°)'], 'HorizontalAlignment', 'left', 'FontSize', 14);
elseif a >= 165 && a <= 180
    plot([0.019998 0.019998], [0 140],'--', 'LineWidth', 1, 'Color', [0.6510    0.6510    0.6510]); %fix line
    plot([x x], [0 140], '--', 'LineWidth', 1, 'Color', [0.6510    0.6510    0.6510]); % variable line
    Start = [0.01998 130];
    End = [x 130];
    arrow(Start, End, 'Length', 5, 'Width', .5, 'Color', [0.6510    0.6510    0.6510]);
    text(x+0.001, 133, ['\alpha ~ 180° (\alpha = ', num2str(a), '°)'], 'HorizontalAlignment', 'left', 'FontSize', 14);
end

hold on




legend('Load Voltage U', 'TCR Current I', 'FontSize', 14);

hold off;

%% Plot with 3 subplots

open_system('TCR_Simulation') 

fontname = 'Helvetica';

alpha = [90, 125, 155];

titles = {'\alpha = 90°', '\alpha > 90°', '\alpha ~ 180°'};

figure;

for i = 1: length(alpha)
    a = alpha(i); % aktueller Zündwinkel
    out= sim('TCR_Simulation')
    t = out.Load_Voltage.time;
    U_a = out.Load_Voltage.Data;
    I_a = out.I_TCR.Data*3.5; %scale I_a for better visualization
    x = ((a + 360) / 360) * (1 / 50);
    subplot(length(alpha), 1, i);
    %plot(t, U_a, t, I_a, 'LineWidth', 2)
    h1 = plot(t, U_a, 'LineWidth', 3.5, 'Color', [0.6510    0.6510    0.6510]); 
    hold on;
    h2 = plot(t, I_a, 'LineWidth', 4, 'Color', [0.8500 0.3250 0.0980]); 

    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    set(gca, 'FontSize', 18);
    ylim(ax, [-320 320]);
    xlim(ax, [0.007 0.08]);
    xlabel('Zeit (s)', 'FontSize', 18);
    ylabel('Amplitude U, I', 'FontSize', 18);
    title(titles{i}, 'FontSize', 21, 'FontWeight', 'bold');
    box on;

    Start = [0.01998, 190];
    End = [x, 190];
    arrow(Start, End, 'Length', 5, 'Width', .6, 'Color', [0.502 0.502 0.502])
   
    plot([0.019998 0.019998], [0 220],'--', 'LineWidth', 1.5, 'Color',[0.502 0.502 0.502]); %fix line
    plot([x x], [0 220], '--', 'LineWidth', 1.5, 'Color', [0.502 0.502 0.502]); % variable line

    text(0.01998+0.001, 230, ['\alpha = ', num2str(a), '°'], 'FontSize', 18, 'FontWeight', 'bold', 'Color', [0.502 0.502 0.502]);


   
    if i == 3
        legend([h1, h2], {'Load Voltage U', 'TCR Current I'}, 'Location', 'best', 'FontSize', 16);
    end
       
end


%sgtitle('I_{TCR} -Abhängigkeit vom Zündwinkel \alpha', 'FontSize', 16);

%%
