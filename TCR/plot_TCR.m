%% 1) Change a to change firing angle
    % run simulation then run second section

open_system('TCR_Simulation')
a = 110;
sim('TCR_Simulation')
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
title('I_ (TCR) -Abhängigkeit vom Zündwinkel a');

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca, 'FontSize', 14);

x = ((a+360)/360) * (1/50);
xline(x,'--', ['a = ', num2str(a),'°'],'LabelVerticalAlignment', 'top' ,'LineWidth', 1.5, 'FontSize', 14);
legend('Load Voltage U', 'TCR Current I', 'FontSize', 14);

hold off;

%%
% Define array of firing angles to analyze
angles = [160, 165, 170, 175, 180];  % Example angles to analyze

% Initialize arrays to store harmonic content percentages
harmonic_percentages = zeros(length(angles), 5);  % Store percentages of first 5 harmonics

% Loop through each firing angle
for i = 1:length(angles)
    a = angles(i);
    sim('TCR_Simulation');  % Run simulation for current firing angle
    
    % Extract output voltage waveform and time vector from simulation data
    t = out.Load_Voltage.time;
    U_a = out.Load_Voltage.Data;

    % Perform FFT on output voltage waveform U_a
    Fs = 1 / (t(2) - t(1));  % Sampling frequency (assuming uniform time steps)
    L = length(U_a);         % Length of signal
    Y = fft(U_a);            % Compute FFT
    P2 = abs(Y / L);         % Compute two-sided spectrum
    P1 = P2(1:L/2+1);        % Single-sided spectrum
    P1(2:end-1) = 2 * P1(2:end-1);  % Adjust amplitude for one-sided FFT

    % Frequency vector
    f = Fs * (0:(L/2)) / L;

    % Calculate harmonic content percentages
    % Find indices of first 5 harmonics in frequency vector
    harmonic_indices = 1:5;
    harmonic_frequencies = f(harmonic_indices);
    harmonic_amplitudes = P1(harmonic_indices);
    
    % Calculate total amplitude of these harmonics
    total_harmonic_amplitude = sum(harmonic_amplitudes);
    
    % Calculate percentages of individual harmonics
    harmonic_percentages(i, :) = harmonic_amplitudes / total_harmonic_amplitude * 100;

end

% Plotting
figure;
plot(angles, harmonic_percentages, 'o-');
xlabel('Firing Angle a (degrees)');
ylabel('Percentage (%)');
title('Percentage of First 5 Harmonics vs. Firing Angle a');
legend('Harmonic 1', 'Harmonic 2', 'Harmonic 3', 'Harmonic 4', 'Harmonic 5', 'Location', 'best');
grid on;


