%Simulation of a SVC Facts-Element in a three phase system (1 TCR + 3 TSCs)

open_system('SVC_Simulation_V2');
sim('SVC_Simulation_V2');

%%
fontname = 'Helvetica';

time = scopeData.time;
VaIa = scopeData.signals(1).values;
Q = scopeData.signals(2).values;
VmeasVref = scopeData.signals(3).values;
alpha = scopeData.signals(4).values;
TCS_number = scopeData.signals(5).values;

numSignals = length(scopeData.signals);
titles = {'V_{a}, I_{a} ', 'Q', 'V', 'alpha', 'TSC number'};
legends = {{'Va', 'Ia '}, 'Q (Mvar)', {'Vref ', 'Vmeas '}, 'alpha (deg)', 'TCS number'};

% Plot Version 1: 4 Subplots

yLabels = {'pu','Mvar', 'pu','','test'};

figure;

for i = 1:numSignals
    if i == 4
        continue;
    end
    subplot(numSignals-1, 1, i - (i > 4)); 
    if i == 3 
        plot(time, scopeData.signals(i).values(:,2), 'LineWidth', 1.5, 'Color', [.7 .7 .7], 'LineStyle','--');
        hold on
        plot(time, scopeData.signals(i).values(:,1), 'LineWidth', 2);
        legend(legends{i}, 'Location', 'best', 'FontSize', 10);
        ylabel('pu')
    else
        plot(time, scopeData.signals(i).values, 'LineWidth', 2); 
    end

    title(titles{i}, 'FontSize', 16, 'FontWeight', 'bold');

    if i == numSignals
        xlabel('Time (s)', 'FontSize', 14);
    else
        set(gca,'XTickLabel', []);
    end
    if i == 1
        legend(legends{i}, 'Location', 'south', 'FontSize', 10);
        ylabel('pu')
    end
    if i == 2
        ylabel('Mvar')
    end
    set(gca, 'FontSize', 10);
    grid off; 
end
sgtitle('SVC Verhalten (dynamische Regelung)', 'FontSize', 17);
%% Plot Version 2: 3 Subplots

indicesToPlot = [2, 3, 5];
numPlots = length(indicesToPlot);
yLabels = {'Mvar', 'pu',''};

figure;


for plotIndex = 1:numPlots
   
    i = indicesToPlot(plotIndex);
    subplot(numPlots, 1, plotIndex); 

    if i == 3 
        plot(time, scopeData.signals(i).values(:,2), 'LineWidth', 2.5, 'Color', [.7 .7 .7], 'LineStyle','--');
        hold on
        plot(time, scopeData.signals(i).values(:,1), 'LineWidth', 4);
        legend(legends{i}, 'Location', 'best', 'FontSize', 16);
    else
        if plotIndex == numPlots
            plot(time, scopeData.signals(i).values, 'LineWidth', 4,'Color', [0.85 0.5 0.1]); 
            xlabel('Zeit (s)', 'FontSize', 18);
        else
            plot(time, scopeData.signals(i).values, 'LineWidth', 4); 
            set(gca, 'XTickLabel', []);
        end
    end
   
    title(titles{i}, 'FontSize', 16, 'FontWeight', 'bold');

    ylabel(yLabels{plotIndex}, 'FontSize', 19)
    
   
   
    set(gca, 'FontSize', 19);
    grid off; 
end
%sgtitle('SVC Verhalten (dynamische Regelung)', 'FontSize', 17);

