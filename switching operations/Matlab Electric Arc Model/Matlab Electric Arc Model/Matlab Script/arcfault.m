% SIMULATION OF AN ARCING FAULT IN A RESISTIVE CIRCUIT
% J. Andrea - 2015

%Clear Workspace.
clear all;
close all;
clc;

%Time vector.
N=2050;             %Length of time vector.
Te=1/20000;         %Sampling period [s].
t=Te*(0:N-1);       %Time vector t [s].

%RL circuit parameters.
R=47.5;                 %Circuit resistance [Ohm].
L=1e-3;                 %Circuit inductance [Henry].
Vamp=230*sqrt(2);       %Generator voltage amplitude [V].
f=50;                   %Generator frequency.
Vg=Vamp*sin(2*pi*f*t);  %Generator voltage signal [V].

%Static arc equation Vt=F(It) parameters.
alpha=49.0874;      %Parameter alpha.
Rc=2221.4;          %Corona, glowing or melted bridge resistance [Ohm].
beta=1.4614;        %Parameter beta.
tau=1.3176e-05;     %Arc time constant [s].
F =@(x)alpha*Rc*x./(Rc*x.*atan(beta*x)+alpha);

%Initialize output matrices.
Varc=zeros(1,N);    %Arc voltage [V].
Iarc=zeros(1,N);    %Arc current [A].
Iarc(1)=Vg(1)/R;    %Initial current (before openning).
Iarc(2)=Vg(2)/R;    %Initial current (before openning).

%Vector x for static arc compution.
x=[ [-150:0.1:-5] [-5:0.001:5] [5:0.1:150] ];
%      Rarc area         Rc area          Rarc area

%For each time instant k of vetor time (t=k*Te),
%compute arc voltage and current:
for k=3:N
    
    %Update of circuit equation for time index k.
    Eq =@(x)F(x)-Vg(k)+R*x+L*(x-Iarc(k-1))/Te;
    
    %Solve circuit equation for polarisation current It at time index k,
    %provide more than one solution.
    indices =@(x)abs( diff( sign( Eq(x) ) ) );
    solutions=find([0 indices(x)]>=1); 
    solutions=x(solutions);
    
    %Test all the possible solutions.
    if isempty(solutions)==1       %if no solution for It:
        Iarc(k)= 0;                %there is no arc.
        
    elseif length(solutions)==1;   %if one solution for It:
        It=solutions(1);            %compute Iarc from It.          
        Iarc(k)=1/(1+tau/Te)*(It+(tau/Te)*Iarc(k-1));
        
    else    %else, we have to choose the right solution.
        
        dPmin=1e10000;       %Minimum power variation dP.
                
        %Evaluate each solutions
        for n=1:length(solutions)
            %Compute the possible arc current Ik for solution n.
            Itk=solutions(n);
            Ik=1/(1+tau/Te)*(Itk+(tau/Te)*Iarc(k-1));

            %Compute the possible arc voltage Vk for solution n.
            Vk=Vg(k)-R*Ik-L*(Ik-Iarc(k-1))/Te;
            
            %Compute the possible power Pk for solution n.
            Pk=Vk*Ik;
            
            %Compute the real power at previous time index k-1.
            Pk_1=Varc(k-1)*Iarc(k-1);
            
            %Compute possible variation of power for solution n.
            dP=abs(Pk-Pk_1);
            
            %Choose solution n if variation of power is minimal.
            if dP<dPmin
                dPmin=dP;
                Iarc(k)=Ik;
                It=solutions(n);
            end
        end     
    end
    
    %Compute Varc from right solution It
    Vt(k)=F(It);
    Varc(k)=1/(1+tau/Te)*(Vt(k)+(tau/Te)*Varc(k-1));

end

%Display Results.
figure,

%Plot arc voltage
subplot(2,1,1),plot(t,Varc);
axis([0 N*Te -200 200]);
ylabel('Arc voltage [V]');
xlabel('Time [s]');

%Plot arc current
subplot(2,1,2),plot(t,Iarc);
axis([0 N*Te -10 10]);
ylabel('Arc current [A]');
xlabel('Time [s]');
