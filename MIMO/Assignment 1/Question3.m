%Question 3: Capacity plot for fast-fading SIMO channel:
clear % Precaution to prevent previous values from corrupting the present data.
clc 
%1. Predefined:
nr=4; %Number of antennas
nSamples=1000; %Number of realizations of fading channel h
std=sqrt(2); %Scale factor (Standard Deviation) for normalizing h
snrdB=0:5:40; %SNR values in steps of 5dB from 0 to 40dB

%2. SNR and Capacity calculation: 
snr=10.^(snrdB/10); % Calculate linear SNR
Capacity=zeros(size(snr)); %Initializing the capacity vector

for j=1:nSamples % For nSamples(here:1000) number of iteratons, perform:
    h=(complex(randn(nr,1),randn(nr,1))/std); % Calculate an instantiation of h
    sqnorm_h=norm(h)^2; % Normalize
    Capacity=Capacity+(log2(1+sqnorm_h*snr))/nSamples; % Calculating the Expected Capacity 
end

%3. Plot:
ln1=plot(snrdB,Capacity);
ln1.Marker = 'o';
ln1.MarkerEdgeColor = 'b';
xlabel('SNR(dB)');
ylabel('Capacity(bps/hz)');
title('Capacity plot of fast-fading SIMO Channel');
grid on;
