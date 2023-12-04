% % 1
clc
clear
close all


diametro = 0.0135;
R = diametro/2;
lunghezza = 30;
deltaP = 1500;
viscositaCinematica = 1.3*10^-6;
densitaAcqua = 1000;
viscositaDinamica = viscositaCinematica*densitaAcqua;


u = @(r) R^2/(4*viscositaDinamica)*deltaP/lunghezza*(1-r.^2./R^2);

portata = integral(@(r) R^2/(4*viscositaDinamica)*deltaP/lunghezza*(1-r.^2./R^2)*2*pi, 0, R)

portataFatta = -pi/8*R^4/viscositaDinamica*deltaP/lunghezza % m3/s






%% 2
clc
clear

viscositaCinematica = 4.5*10^-6; %m^2/st6
densita = 0.917; %g/cm^3



