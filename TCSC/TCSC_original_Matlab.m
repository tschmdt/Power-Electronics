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
plot(P, 'LineWidth', 2.5);
xlabel('Zeit');
ylabel('MW');
title('Power', 'FontSize', 12);
set(gca, 'FontSize', 12);

figure;
plot(Ztcsc,'LineWidth', 2.5);
xlabel('Zeit');
ylabel('Ohm');
title('Z_{TCSC}', 'FontSize', 12,'Interpreter', 'tex');
set(gca, 'FontSize', 12);

figure;
plot(alpha,'LineWidth', 2.5)
xlabel('Zeit');
ylabel('deg');
title('\alpha', 'FontSize', 14,'Interpreter', 'tex');
set(gca, 'FontSize', 12);

%% Power, Z, alpha one figure
fontname = 'Helvetica';

figure;

subplot(3, 1, 1); 
plot(P, 'LineWidth', 2);
ylabel('MW');
title('Power', 'FontSize', 12);
set(gca, 'FontSize', 12, 'FontName', fontname);
set(gca, 'XTick', []);
xlabel('')

subplot(3, 1, 2); 
plot(Ztcsc, 'LineWidth', 2);
ylabel('Ohm');
title('Z_{TCSC}', 'FontSize', 12, 'Interpreter', 'tex');
set(gca, 'FontSize', 12, 'FontName', fontname);
set(gca, 'XTick', []);
xlabel('')

subplot(3, 1, 3); 
plot(alpha, 'LineWidth', 2);
xlabel('Zeit (s)');
ylabel('deg');
title('alpha', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'tex');
set(gca, 'FontSize', 12, 'FontName', fontname);


%% U,I 
    % capacitor voltage and current at steady state operation in the capacitive
    %region
fontname = 'Helvetica';

figure;
plot(Icap,'LineWidth', 2.5)
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
plot(Icap, 'LineWidth', 2.5);
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


