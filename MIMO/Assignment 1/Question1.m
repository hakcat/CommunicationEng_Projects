%Question 1: Capacity plot for AWGN SISO channel:
clear % Precaution to prevent previous values from corrupting the present data.
clc 
%1. Generating SNR in steps of 5, from 0dB to 40dB:
snrdB=0:5:40
%2. Converting the generated SNR's to linear scale:
snr=(10.^(snrdB/10))
%3. Calculating the capacity with the SNR's in linear scale:
capacity=log2(1+snr)
%4. Plotting SNR[dB] along the horizontal axis with the capacity along vertical axis: 
ln=plot(snrdB,capacity);

%4. Plot customizations:
ln.Marker = 'o';
ln.MarkerEdgeColor = 'b';
xlabel('SNR(dB)');
ylabel('Capacity (bps/hz)');
title('Capacity plot for AWGN SISO channel');
grid on;

