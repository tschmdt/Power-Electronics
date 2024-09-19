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

%% Power, Z, alpha ONE FIGURE
fontname = 'Helvetica';

figure('Position', [100, 100, 600, 800]);

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
x = [0.35 0.27];  % normalized
y = [0.435 0.45];
annotation('textarrow',x,y, 'String', ' start regulation to Z_{ref}= 128 Ohm', LineWidth= 1.1, FontSize=11)

subplot(3, 1, 3); 
plot(alpha, 'LineWidth', 2, 'Color', [0.9290 0.6940 0.1250]);
xlabel('Zeit (s)');
ylabel('deg');
title('alpha', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'tex');
set(gca, 'FontSize', 12, 'FontName', fontname);
ylim([65 95]);

%% Power, Z, alpha ONE PLOT
fontname = 'Helvetica';

%figure;
figure('Position', [100, 100, 750, 700]);

yyaxis left
plot(Ztcsc.Time, Ztcsc.Data, 'LineWidth', 2); 
ylabel('Ohm');
set(gca, 'FontSize', 12);
%set(gca, 'XTick', []); 
xlabel('Zeit (s)'); 

title('Wirkleistungsfluss-Änderung durch Impedanz-Regelung', 'FontSize', 16, 'FontWeight', 'bold');

yyaxis right
plot(P.Time, P.Data, 'LineWidth', 2, 'LineStyle','-.'); 
ylabel('MW');  
set(gca, 'FontSize', 12, 'FontName', fontname);
set(gca, 'YTick', [0, 200, 400, 600, 800, 1000]);


legend('Z_{TCSC}','P')

x = [0.35 0.27]; 
y = [0.25 0.3];
annotation('textarrow', x, y, 'String', ' start regulation to Z_{ref} = 128 \Omega', 'LineWidth', 1.1, 'FontSize', 12);

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
%% Impedance as function of alpha
    %change parameters in simulation:
        % zref: Time[ 0  1  1.5   2.5 ]; Amplitude[1 0.945 1.03 1.06 ]*128
        % bypass threshold 0.25 (within firing unit)

timepoints = Ztcsc.Time;
specific_timepoints = [0.1, 1.2, 1.75, 2.75];
[~, indices] = ismember(specific_timepoints, timepoints);

for i = 1:length(indices)
    Ztcsc_timevalues(i) = Ztcsc.Data(indices(i))
    alpha_timevalues(i) = alpha.Data(indices(i))
end

figure('Position', [100, 100, 600, 600]);
plot(alpha_timevalues, Ztcsc_timevalues, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b', 'LineWidth', 1, 'LineStyle','-', 'Color', 'black'); 
title('Abhängigkeit der Impedanz vom (Zünd-) Winkel', 'FontSize', 16, 'FontWeight', 'bold');
xlabel('$\alpha$', 'Interpreter', 'latex', 'FontSize', 16)
ylabel('Z_{TCSC}(\alpha)', 'FontSize', 12 );
%set(gca, 'FontSize', 12, 'FontName', fontname);
set(gca, 'XTick', [70, 75, 80, 85, 90]);

grid on;

