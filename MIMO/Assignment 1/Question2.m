%Question 2: Capacity plot for fixed SIMO channel (h known):

clear % Precaution to prevent previous values from corrupting the present data.
clc 

%1. No of receive antennas:
nr=4; 
%{
2. Note: In the below step, randn() takes values from a
   standard normal distribution with mean 0 and standard deviation 1.
   So the generated complex gaussian random variable will be of mean 0 and
   variance 2. In order to deal with it, (to normalize) we divide it by
   the new standard deviation: sqrt(2). 
%}
%3. Generating (nr by 1) h entries with zero mean and unity variance: 
std=sqrt(2);
h=(complex(randn(nr,1),randn(nr,1))/std)
%4: Calculating L2 norm square of the complex vector h with size nr x 1:
sqnorm_simo_h=norm(h)^2

%5. Generating SNR[dB] values from 0 to 40 in steps of 5:
snrdB=0:5:40
%6. Changing Snr from dB to linear scale:
snr=10.^(snrdB/10)

%7. Note: The h vector for AWGN can be modelled as follows, for easy comparison:
sqnorm_awgn_h=(norm([1,1,1,1]))^2 

%8. Capacity calculations:
cap_simo=log2(1+sqnorm_simo_h*snr); %calculating the capacity of fixed channel SIMO
cap_awgn=log2(1+sqnorm_awgn_h*snr); %calculating the capacity of AWGN channel SIMO 

%9. Capacity plots:
ln1=plot(snrdB,cap_simo);
ln1.Marker = 'o';
ln1.MarkerEdgeColor = 'k';
hold on 
ln2=plot(snrdB,cap_awgn);
ln2.Marker = 'o';
ln2.MarkerEdgeColor = 'r';
legend('Fixed SIMO ','AWGN SIMO');
xlabel('SNR(dB)');
ylabel('Capacity(bps/hz)');
title('Comparison capacity plot for fixed and AWGN SIMO channels');
grid on;