


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

numSignals = length(signals);
titles = {'Va Ia (pu)', 'Q', 'Vmeas Vref', 'alpha', 'TCS number'};
legends = {{'Va (pu)', 'Ia (pu)'}, 'Q (Mvar)', {'Vmeas (pu)', 'Vref (pu)'}, 'alpha (deg)', 'TCS number'};



figure;

for i = 1:numSignals
    subplot(numSignals, 1, i); 
    plot(time, signals(i).values, 'LineWidth', 1.3); 
    title(titles{i}, 'FontSize', 14, 'FontWeight', 'bold');
    if i == numSignals
        xlabel('Time (s)', 'FontSize', 12);
    else
        set(gca,'XTickLabel', []);
    end
    legend(legends{i}, 'Location', 'best', 'FontSize', 10);
    set(gca, 'FontSize', 9);
    grid off; 
end
sgtitle('SVC Verhalten dynamische Regelung', 'FontSize', 17);
