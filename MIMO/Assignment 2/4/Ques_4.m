clc
clear
close all

MK=1; %Antenna UE Ratio
while(MK<=8) %Plot for MK=1,2,4,8
    plotter(MK); %SE calculation function; defined below
    MK=MK*2;
end

title('Lower bound on the NLoS UL SE');
xlabel('Number of UEs (K)');
ylabel('Average Sum SE (NLOS) [bit/s/Hz/cell]');
legend("M/K=1","M/K=2","M/K=4","M/K=8")
grid on

function plotter(MK)
    B = 10^-1; %Ratio of intra cell and inter cell gain= -10dB
    SNR0 = 1; %SNR of UE at cell0= 0dB
    K=1:20;  %No of UE
    M=K.*MK; %No of antennas increase according to the ratio
    num=M-1; %Numerator of the SE equation
    denom=(K-1)+B.*K+(1/SNR0); %%Denominator of the SE equation
    SE_NLOS=K.*log2(1+ num./denom); %lower bound of SE_LOS
    plot(K,SE_NLOS,'-*');
    hold on;
end
