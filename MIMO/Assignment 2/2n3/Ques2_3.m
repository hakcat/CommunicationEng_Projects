clc
clear
close all
M=5:5:100; % Total no of antennas at Base station
b=0.1; %Ratio of intra cell and inter cell gain= -10dB
SNR0=1; %SNR of UE at cell0= 0dB
nSamples=10000; %No of realisation taken to average the SE 
%% Q2
[SE_LOS_CL]=SE_LOS_ClosedForm(nSamples,M,b,SNR0); 
[SE_NLOS_LB]=SE_NLOS_LowerBound(M,b,SNR0); 
plot(M,SE_LOS_CL,'--r');hold on;
plot(M,SE_NLOS_LB,':b');hold on;

%% Q3
[SE_LOS,SE_NLOS]=Avg_SE(nSamples,b,SNR0);
plot(M,SE_LOS,'-dk');hold on;
plot(M,SE_NLOS,'->g');

%%
legend('LOS(closed form)','NLOS(lower bound)','Deterministic LOS',' Average NLOS');
xlabel('BaseStation Antennas(M)');
ylabel('Average SE [bits/s/Hz]');
title('Spectral Efficiency')
grid on;

%%  Functions Below are Used for Ques 2
%%  Averaging SE of LOS over different angles of Td and Ti which is uniformly  distributed over [0,2*pi] 
function[SE_LOS,g]=SE_LOS_ClosedForm(nSamples,M,b,SNR0) 
phi=unifrnd(0,2*pi,nSamples,2);
g=angleCalculation(phi,M);
SE_LOS=log2(1+M./(b.*g+(1/SNR0))); %( M x  nsamples)matrix
SE_LOS=sum(SE_LOS)/nSamples;% Averaging it over all realisations
end
%% Calculating the g(,) for different values of UE angles
function [g]=angleCalculation(phi,M)
dH=0.5;
 g=sin(pi*dH*M.*(sin(phi(:,1)-sin(phi(:,2))))).^2./(M.*(sin(pi*dH*(sin(phi(:,1))-sin(phi(:,2)))).^2)) ;
end
%% Finding the lower bound of NLOS
function [SE]=SE_NLOS_LowerBound(M,b,SNR0)
SE=log2(1+(M-1)/( b +(1/SNR0)));
end
%% Functions Below are Used for Ques 3
%%
function[SE_LOS,SE_NLOS]=Avg_SE(nSamples,b,SNR0) 
b00=1; %Assuming intra cell channel gain to be unity
b01=b*b00; %Inter cell channel gain
p=1; %Assuming power of the Signal to be unity
NoiseVar=p/SNR0; %Std of Noise
SE_LOS=zeros(20,1);
SE_NLOS=zeros(20,1);
for i=1:20 %For antennas
    m=i*5;
    phi=unifrnd(0,2*pi,nSamples,2); %Generating samples for UE Angles in cell 0 and cell 1
    for j=1:nSamples %Average SE Using the Realisation Generated
        %LOS Case
        h00=sqrt(b00)*angleToVector(phi(j,1),m);%Channel response of BS at cell 0 and user at cell 0
        h01=sqrt(b01)*angleToVector(phi(j,2),m);%Channel response of BS at cell 0 and user at cell 1
        SE_LOS(i)=SE_LOS(i)+GeneralizedSE(h00,h01,p,NoiseVar);
        %NLOS Case
         h00=(complex(randn(m,1),randn(m,1))*sqrt(b00/2));%Channel response of BS at cell 0 and user at cell 0
         h01=(complex(randn(m,1),randn(m,1))*sqrt(b01/2));%Channel response of BS at cell 0 and user at cell 1
        SE_NLOS(i)=SE_NLOS(i)+GeneralizedSE(h00,h01,p,NoiseVar);
    end  
end
SE_LOS=SE_LOS/nSamples;
SE_NLOS=SE_NLOS/nSamples;
end
%% calculating SE expression(generalized form) by the channel gains 
function [SE]=GeneralizedSE(h0,h1,p,NoiseVar) % For one realization
normh0=norm(h0);
t=abs(ctranspose(h0)*h1)^2;
t=t/(normh0^2);   
SE=log2(1+ (p*normh0^2/(p*t+NoiseVar)));
end
%% Finding the Channel gain from the UE angle
function h=angleToVector(phi,m)
M=0:m-1;
dH=0.5;
h=exp(2*pi*dH*sin(phi)*M*1j);
h=transpose(h);
end
%%
