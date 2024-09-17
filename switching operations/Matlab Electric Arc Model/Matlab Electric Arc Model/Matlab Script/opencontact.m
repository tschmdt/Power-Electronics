% SIMULATION OF AN ARC OCCURING AT CONTACT OPENING
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
R=0.12;             %Circuit resistance [Ohm].
L=1e-3;             %Circuit inductance [Henry].
Vamp=36;            %Generator voltage amplitude [V].
Vg=Vamp*ones(1,N);  %Generator voltage signal [V].

%Static arc equation Vt=F(It) parameters.
alpha=24.17;        %Parameter alpha.
Rc=30000;           %Corona, glowing or melted bridge resistance [Ohm].
beta=0.2;           %Parameter beta.
tau=0;4.5e-5;       %Arc time constant [s].

%Initialize output matrices.
Varc=zeros(1,N);    %Arc voltage [V].
Iarc=zeros(1,N);    %Arc current [A].
Iarc(1)=Vg(1)/R;    %Initial current (before openning).
Iarc(2)=Vg(2)/R;    %Initial current (before openning).

%Initialize contact distance matrix d.
%Arc length assumed to be equal to the distance d between the contacts.
Sp=300;                     %Contact opening speed.
Start=200;                  %Opening time instant index.
d=zeros(1,Start);           %Distance is null before opening.
d=[d, Sp*t(1:N-Start)];     %Distance increase linearly after opening.

%Initialize alpha parameter.
%alpha is a linear function of d.
alpha=2.*d; alpha(Start+1:N)=alpha(Start+1:N)+15;

%Vector x for static arc compution.
x=[ [-500:0.1:-0.1] [-0.1:0.0001:0.1] [0.1:0.1:500] ];
%      Rarc area         Rc area          Rarc area

%For each time instant k of vetor time (t=k*Te),
%compute arc voltage and current:
for k=3:N
    
    %Distance changes between two samples, and so does alpha
    %So we update the static arc equation for time index k
    F =@(x)alpha(k)*Rc*x./(Rc*x.*atan(beta*x)+alpha(k));

    %Update of circuit equation for time index k
    Eq =@(x)F(x)-Vg(k)+R*x+L*(x-Iarc(k-1))/Te;
    
    %Solve circuit equation for polarisation current It at time index k,
    %provide more than one solution
    indices =@(x)abs( diff( sign( Eq(x) ) ) );
    solutions=find([0 indices(x)]>=1); 
    solutions=x(solutions);
    
    %Test all the possible solutions.
    if isempty(solutions)==1       %if no solution for It:
        Iarc(k)= 0;                %there is no arc.
        
    elseif length(solutions)==1;   %if one solution for It:
        It=solutions(1);           %compute Iarc from It.          
        Iarc(k)=1/(1+tau/Te)*(It+(tau/Te)*Iarc(k-1));
        
    else    %else, we have to choose the right solution.
        
        dPmin=1e10000;       %Minimum power variation dP.
              
        %Evaluate each solutions.
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
    
    %Compute Varc from right solution It.
    Vt(k)=F(It);
    Varc(k)=1/(1+tau/Te)*(Vt(k)+(tau/Te)*Varc(k-1));

end

%Display Results.
figure,

%Plot contact distance.
subplot(3,1,1),plot(t,d);
axis([0 N*Te 0 35]);
ylabel({'Contact distance';' d [mm]'});
xlabel('Time [s]');

%Plot arc voltage.
subplot(3,1,2),plot(t,Varc);
axis([0 N*Te 0 60]);
ylabel('Arc voltage [V]');
xlabel('Time [s]');

%Plot arc current.
subplot(3,1,3),plot(t,Iarc);
axis([0 N*Te 8 310]);
ylabel('Arc current [A]');
xlabel('Time [s]');
