clc
clear
close all

M=1;   %Number of Antennas
plotter(M);
M=100;
plotter(M);
M=1000;
plotter(M);

title('Interference plot');
xlabel('Angle of Interfering UE [degree] with BS: \phi _{0}^{1}');
ylabel('g(\phi _{0}^{0},\phi _{0}^{1})');
legend({'M=1','M=100','M=1000'});
grid on
hold off

function plotter(M) 
    dH=0.5; %Antenna spacing
    Ti= ((-pi):(pi/180):(pi)); % Angle of Interfering UE with BS
    Td = pi/4;    %Angle of desired UE with BS
    s = find((Ti==Td)); %All same angles
    m = find(Ti==(pi-Td)); %All mirror angles
    g =(sin(pi*dH*M*(sin(Td)-sin(Ti))).^2)./(M*(sin(pi*dH*(sin(Td)-sin(Ti))).^2)); 
    g(s)=M; %g=M; if both angles are equal
    g(m)=M; %g=M; if both angles are supplementary (mirror; sum is 180 degrees)
    semilogy(Ti*180/pi,g);
    hold on
end