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

%% Power, Z ONE PLOT
fontname = 'Helvetica';

%figure;
figure('Position', [100, 100, 750, 700]);

yyaxis left
plot(Ztcsc.Time, -Ztcsc.Data(:,2), 'LineWidth', 3); 
ylabel('Ohm');
set(gca, 'FontSize', 19);
%set(gca, 'XTick', []); 
xlabel('Zeit (s)', 'FontSize', 19); 

%title('Wirkleistungsfluss-Änderung durch Impedanz-Regelung', 'FontSize', 21, 'FontWeight', 'bold');

yyaxis right
plot(P.Time, P.Data, 'LineWidth', 3, 'LineStyle','--'); 
ylabel('MW');  
set(gca, 'FontSize', 19, 'FontName', fontname);
set(gca, 'YTick', [0, 200, 400, 600, 800, 1000]);


legend('Z_{TCSC}','P')

x = [0.35 0.27]; 
y = [0.25 0.3];
annotation('textarrow', x, y, 'String', ' start regulation to Z_{ref} = 128 \Omega', 'LineWidth', 2, 'FontSize', 16);

%% Power, X ONE PLOT

fontname = 'Helvetica';

figure('Position', [100, 100, 750, 750]);

plot(P.Time, P.Data, 'LineWidth', 3, 'LineStyle', '-', 'Color',[0 0.4470 0.7410]);  
hold on;

plot(Ztcsc.Time, -Ztcsc.Data(:,2), 'LineWidth', 3,'Color',[0.8500 0.3250 0.0980]); 
%ylabel('Ohm');

xlim([0.2 2.5]);

x = [0.4 0.25]; 
y = [0.3 0.25];
annotation('textarrow', x, y, 'String', ' start regulation', 'LineWidth', 2, 'FontSize', 16);

ax = gca;
%set(gca, 'YTick', [-400, -200, 0, 200, 400, 600, 800, 1000]);
set(gca, 'YTickLabel', []);

ax.XAxisLocation = "origin";
ax.YAxisLocation = "origin";
ax.LineWidth = 1.5;
box off;

set(gca, 'FontSize', 19, 'FontName', fontname);

axesPosition = get(gca, 'Position');

annotation('arrow', [axesPosition(1), axesPosition(1)], [axesPosition(2)+axesPosition(4), axesPosition(2)+axesPosition(4)+0.05], 'LineWidth', 1.5);

annotation('arrow', [axesPosition(1), axesPosition(1)], [axesPosition(2), axesPosition(2)-0.05], 'LineWidth', 1.5);


%Labels and Ticks manual + colors
yticks = [-200, 0, 200, 400, 600, 800]; 
ylabels = {'-200', '0', '200', '400', '600', '800'} ;  

colors = {[0.8500 0.3250 0.0980], "black", [0 0.4470 0.7410], [0 0.4470 0.7410], [0 0.4470 0.7410], [0 0.4470 0.7410]};

for i = 1:length(yticks)
    text(0.15, yticks(i), ylabels{i}, 'Color', colors{i}, 'FontSize', 19, 'FontName', fontname, 'HorizontalAlignment', 'right');
end

xlabel('Zeit (s)', 'FontSize', 20); 

%Add custom labels since y axis merges two axes (X and P)
text(-0.17, 950, 'P (MW)', 'FontSize', 20, 'FontName', fontname, 'Color', [0 0.4470 0.7410], 'FontWeight', 'bold');  % Label for P (above 0)
text(-0.11, -300, 'X_{TCSC} (\Omega) ', 'FontSize', 20, 'FontName', fontname, 'Color', [0.8500 0.3250 0.0980], 'FontWeight', 'bold');  
%%

fontname = 'Helvetica';

% Create the figure
figure('Position', [100, 100, 750, 700]);

% Left y-axis for Ztcsc Data
yyaxis left
plot(Ztcsc.Time, -Ztcsc.Data(:,2), 'LineWidth', 3); 
ylabel('Ohm');
set(gca, 'FontSize', 19);
xlabel('Zeit (s)', 'FontSize', 19); 

% Right y-axis for P Data
yyaxis right
plot(P.Time, P.Data, 'LineWidth', 3, 'LineStyle','--'); 
ylabel('MW');
set(gca, 'FontSize', 19, 'FontName', fontname);

% Set y-ticks for the right axis
set(gca, 'YTick', [0, 200, 400, 600, 800, 1000]);

% Adjust y-limits to align zeros
% Assuming Ztcsc.Data(:,2) goes negative, set limits for left y-axis
left_ylim = [0,-140]; % Adjust as needed
right_ylim = [0,1000)]; % Assuming P.Data is non-negative

% Set the y-limits for both axes
yyaxis left
ylim(left_ylim); 

yyaxis right
ylim(right_ylim);

% Legend
legend('Z_{TCSC}', 'P', 'Location', 'best');

% Add annotation
x = [0.35 0.27]; 
y = [0.25 0.3];
annotation('textarrow', x, y, 'String', ' start regulation to Z_{ref} = 128 \Omega', 'LineWidth', 2, 'FontSize', 16);

% Optional: Ensure the x-axis limits fit your data
xlim([min(Ztcsc.Time), -max(Ztcsc.Time)]);


%%











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

figure('Position', [100, 100, 750, 700]);

plot(I_cap,'LineWidth', 4);
xlim([1.5 1.6]);
hold on;
plot(I_klemm,'LineWidth', 4);
xlim([1.5 1.6]);
plot(I_tcr,'LineWidth', 4);
xlabel('Zeit (s)');
yticks([]);
xticks([]);
ylabel('I (A)');
%title('Stromverläufe TCSC (einphasig)', 'FontSize', 14);
title([]);
set(gca, 'FontSize', 18);
legend({'I_{cap}', 'I_{klemm}', 'I_{tcr}'}, 'Location', 'best', 'FontSize', 16);




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

