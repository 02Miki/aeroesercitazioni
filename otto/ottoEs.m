% % 1
clc
clear
close all


diametro = 0.0135;
R = diametro/2;
L = 30;
deltaP = 1500;
viscositaCinematica = 1.3*10^-6; % ni
densitaAcqua = 1000;
viscositaDinamica = viscositaCinematica*densitaAcqua; % mu


u = @(r) R^2/(4*viscositaDinamica)*deltaP/L*(1-r.^2./R^2).*r;

portata = integral(@(r) u(r).*2*pi, 0, R) % m^3/sec

LITRI_TO_M3 = 1000;
SECONDI_TO_MINUTI = 60;

portataCorretta = portata*LITRI_TO_M3*SECONDI_TO_MINUTI

vMedia = portata/(pi*R^2)
Re = vMedia*diametro/viscositaCinematica

% teta = linspace(0,2*pi);
% lunghezza = linspace(0, L);
% raggio = meshgrid(linspace(0, R), linspace(0, R), linspace(0, R));
% [TETA, LUNGHEZZA] = meshgrid(teta, lunghezza);
% [X, Y, Z] = pol2cart(TETA, R, LUNGHEZZA);
% % [X,Y,Z] = meshgrid(x,y,z);
% [x,y,z] = pol2cart(teta, R, lunghezza);
% [XT, YT, ZT] = meshgrid(x,y,z);
% 
% hold on
% surf(Z, Y, X)
% [verts, ~] = streamslice(ZT,YT,XT, zeros(100,100,100),  zeros(100, 100,100), u(raggio), [],[],[1,2,3,4,5])
% 
% streamtube(verts,1)
% lighting gouraud
% shading interp

%% 2

clc
clear
close all








%% 2
clc
clear

viscositaCinematica = 4.5*10^-6; %m^2/st6
densita = 0.917; %g/cm^3



