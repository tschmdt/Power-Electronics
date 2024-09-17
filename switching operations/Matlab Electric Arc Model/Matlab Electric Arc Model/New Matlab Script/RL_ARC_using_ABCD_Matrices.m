%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation if an AC Series Arc in a RL circuit with ABCD Matrices
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

%ABCD Matrix of the RL circuit with an series arc
m=Te/Tau;
A=[1-Te*R/L -Te/L; 0 1/(1+m)];
B=[Te/L 0; 0 m/(1+m)];

%State vector initialization
X=zeros(2,N);

%Main loop
for k=3:N
    U=[Vg(k-1); F(X(1,k-1)+(1/m)*(X(1,k-1)-X(1,k-2)))];
    X(:,k)=A*X(:,k-1)+B*U;    
end

%Plot results
figure,
title('Arc in series in a RL circuit')
xlabel('Time [s]')
hold on

yyaxis left
plot(t,X(1,:))
ylabel('Arc Current [A]')
axis([0 N*Te -100 100])

yyaxis right
plot(t,X(2,:))
plot(t,Vg)
ylabel('Arc and Generator Voltage [V]')
axis([0 N*Te -310 310])