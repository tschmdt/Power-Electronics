%% TCSC 
    %The TCSC can operate in capacitive or inductive mode, although the latter is rarely used in practice
    %The capacitive mode is achieved with firing angles 69-90deg


open_system('TCSC_original');
out = sim('TCSC_original');

time = out;
%% separate plots
    %Power, Z, alpha
fontname = 'Helvetica';

figure;
plot(P, 'LineWidth', 2);
xlabel('Zeit (s)');
ylabel('MW');
title('Power', 'FontSize', 12);
set(gca, 'FontSize', 12);

figure;
plot(Ztcsc,'LineWidth', 2);
xlabel('Zeit (s)');
ylabel('Ohm');
title('Z_{TCSC}', 'FontSize', 12,'Interpreter', 'tex');
set(gca, 'FontSize', 12);

figure;
plot(alpha,'LineWidth', 2)
xlabel('Zeit (s)');
ylabel('deg');
title('\alpha', 'FontSize', 14,'Interpreter', 'tex');
set(gca, 'FontSize', 12);

%% Power, Z, alpha one figure
fontname = 'Helvetica';

figure;

subplot(3, 1, 1); 
plot(P, 'LineWidth', 2, 'Color', [0 0.4470 0.7410]);
ylabel('MW');
title('Power', 'FontSize', 12);
set(gca, 'FontSize', 12, 'FontName', fontname);
set(gca, 'XTick', []);
xlabel('')

subplot(3, 1, 2); 
plot(Ztcsc, 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]);
ylabel('Ohm');
title('Z_{TCSC}', 'FontSize', 12, 'Interpreter', 'tex');
set(gca, 'FontSize', 12, 'FontName', fontname);
set(gca, 'XTick', []);
xlabel('');
x = [0.3 0.218];  % arrow beginn 0.75/25; end 0.53/75; normalized
y = [0.45 0.5];
annotation('textarrow',x,y, 'String', ' start regulation to Z_{ref}= 128 Ohm', LineWidth= 1.1, FontSize=11)

subplot(3, 1, 3); 
plot(alpha, 'LineWidth', 2, 'Color', [0.9290 0.6940 0.1250]);
xlabel('Zeit (s)');
ylabel('deg');
title('alpha', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'tex');
set(gca, 'FontSize', 12, 'FontName', fontname);


%% U,I 
    % capacitor voltage and current at steady state operation in the capacitive
    %region
fontname = 'Helvetica';

figure;
plot(I_cap,'LineWidth', 2.5)
xlim([1.5 1.6]);
xlabel('Zeit (s)');
yticks([]);
ylabel('I (A)');
title('Kondensatorstrom (einphasig)', 'FontSize', 14);
set(gca, 'FontSize', 12);

figure;
plot(Utcsc,'LineWidth', 2.5);
xlim([1.5 1.6]);
xlabel('Zeit (s)');
yticks([]);
ylabel('U (V)');
title('Kondensatorspannung (einphasig)', 'FontSize', 14);
set(gca, 'FontSize', 12);
%% I_tcr, I_klemm, I_cap

plot(Icap,'LineWidth', 2.5);
xlim([1.5 1.6]);
hold on;
plot(I_klemm,'LineWidth', 2.5);
xlim([1.5 1.6]);
plot(I_tcr,'LineWidth', 2.5);
xlabel('Zeit (s)');
yticks([]);
xticks([]);
ylabel('I (A)');
title('Stromverläufe TCSC (einphasig)', 'FontSize', 14);
set(gca, 'FontSize', 12);
legend({'I_{cap}', 'I_{klemm}', 'I_{tcr}'}, 'Location', 'best', 'FontSize', 12);




%% U,I one figure
fontname = 'Helvetica';

figure;
yyaxis left;
plot(Utcsc, 'LineWidth', 2.5);
xlabel('Zeit (s)');
ylabel('U (V)');

set(gca, 'FontSize', 12);
xlim([1.5 1.6]);
yyaxis right;
plot(I_cap, 'LineWidth', 2.5);
ylabel('I (A)');
xlabel('Zeit (s)');

legend('U_{tcsc}', 'I_{cap}', 'Location', 'Best');

yyaxis left;
yticks([]);
yyaxis right;
yticks([]);
set(gca, 'FontSize', 12);
title(''); 
title('Kondensatorstrom und -spannung (einphasig) im kapazitiven Betriebsbereich')
%%

fontname = 'Helvetica';

figure;
subplot(3,1,1);

