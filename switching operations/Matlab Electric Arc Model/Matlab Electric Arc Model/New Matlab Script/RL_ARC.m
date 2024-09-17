%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation if an AC arc in series with a resistor and an inductance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Jonathan ANDREA - 2021
%Arc simulation using the arc model described in :
%"The electric arc as a circuit component,"
%IECON 2015, pp. 003027-003034, doi: 10.1109/IECON.2015.7392564.

clear all
close all
clc

%Model parameters
a=47;
Rc=3000;
b=1.47;
Tau=3e-5;

%Static characteristic VI of the arc
F =@(x)a*Rc*x./(Rc*x.*atan(b*x)+a);

%Simulation parameters
Te=1e-7;            %Sampling period
N=1e6;              %Number of sample
t=Te*[0:N-1];       %Time vector

%Circuit parameters
R=14;                   %Resistance value
L=3e-3;                 %Inductance value
Vg=300*sin(2*pi*50*t);  %Generator voltage vector


%Output vectors initialization
I=zeros(1,N);
V=zeros(1,N);

%Main Loop
m=Te/Tau;
for k=2:N   
    I(k)=Te*(-R/L*I(k-1)-V(k-1)/L+Vg(k-1)/L)+I(k-1);
    V(k)=1/(1+m)*(m*F(I(k)+(1/m)*(I(k)-I(k-1)))+V(k-1)); 
end

%Plot results
figure,
title('Arc in series in a RL circuit')
xlabel('Time [s]')
hold on

yyaxis left
plot(t,I)
ylabel('Arc Current [A]')
axis([0 N*Te -100 100])

yyaxis right
plot(t,V)
plot(t,Vg)
ylabel('Arc and Generator Voltage [V]')
axis([0 N*Te -310 310])