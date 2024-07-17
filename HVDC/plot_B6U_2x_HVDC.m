%% Phasenplot einer 12-pulsigen Gleichrichterschaltung ungesteuert (Monopole, Ground Return)
    % Vout: Am Lastwiderstand abfallende Spannung (Addition der beiden B6
    % Schaltungen)
    % V1 & V2: Gleichgerichtete Spannungen an den beiden B6 Schaltungen
    
sim('B6U_2x_HVDC')
fontname = 'Helvetica';

t = out.Vout.time;
Vout = out.Vout.Data;
Iout = out.Iout.Data;
V1 = out.V1.Data;
V2 = out.V2.Data;

figure;

subplot(2,1,1);

plot(t,Vout, t,V1, t,V2, 'LineWidth', 2)
legend('Vout', 'V1', 'V2', 'FontSize', 14,'Location', 'east');
xlabel('Time (s)');
ylabel('Amplitude U (V)');
title('Spannungsverlauf');
set(gca, 'FontSize', 14);
xticks([0, 0.01, 0.02]);

subplot(2,1,2);
plot(t,Iout,'LineWidth', 2)
legend('Iout', 'FontSize', 14,'Location', 'east');
xlabel('Time (s)');
ylabel('Amplitude I (A)');
title('Stromverlauf');
set(gca, 'FontSize', 14);
xticks([0, 0.01, 0.02]);

sgtitle('Netzgeführter 12-Puls Brückengleichrichter', 'FontSize', 17);

figure;

Vab = out.Vab.Data/sqrt(2); %RMS
Vbc = out.Vbc.Data/sqrt(2);
Vca = out.Vca.Data/sqrt(2);

plot(t,Vout,'LineWidth', 2.5);
hold on;
plot(t,Vab,'--','LineWidth', 1);
plot(t,Vbc,'--','LineWidth', 1);
plot(t,Vca,'--','LineWidth', 1);

legend('Vout', 'Vab', 'Vbc', 'Vca', 'FontSize', 14,'Location', 'east');
xlabel('Time (s)');
ylabel('Amplitude U (V)');
title('Spannungsverläufe');
set(gca, 'FontSize', 14);
xticks([0, 0.01, 0.02]);