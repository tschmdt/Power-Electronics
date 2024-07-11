%% Phasenplot einer 12-pulsigen Gleichrichterschaltung ungesteuert (Monopole, Ground Return)
    % Vout: Am Lastwiderstand abfallende Spannung (Differenz der beiden B6
    % Schaltungen)
    % V1 & V2: Gleichgerichtete Spannungen an den beiden B6 Schaltungen

sim('B6U_2x_HVDC')

t = out.Vout.time
Vout = out.Vout.Data
V1 = out.V1.Data
V2 = out.V2.Data 

plot(t,Vout, t,V1, t,V2)

legend('Vout', 'V1', 'V2');
xlabel('Time (s)');
ylabel('Amplitude U');
title('netzgeführter 12-Puls Brückengleichrichter');

