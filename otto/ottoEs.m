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

portata = integral(@(r) u(r).*2*pi, 0, R); % m^3/sec

LITRI_TO_M3 = 1000;
SECONDI_TO_MINUTI = 60;

portataCorretta = portata*LITRI_TO_M3*SECONDI_TO_MINUTI

vMedia = portata/(pi*R^2)
Re = vMedia*diametro/viscositaCinematica;

if Re < 2300
    disp("Il flusso è laminare")
    coefficienteResistenza = 64/Re % Coefficiente di resistenza
else
    disp("Il flusso non è laminare")
end

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

viscositaCinematica = 4.5*10^-6; %m^2/st6  ni

densitaStorpia = 0.917; %g/cm^3
densita = densitaStorpia/1000*(1000*1000);
portataStorpia = 10; % l/min
portata = portataStorpia/(60*1000);
reynolds = 2000;

% portata = u*a = u * pi * R^2
% u = portata/(pi*R^2)
% re = portata/(pi*R^2)*2*R/viscositaCinematica
% R = portata/(pi*R)*2/(viscositaCinematica*reynolds)
R = 2*portata/(pi*viscositaCinematica*reynolds);
D = 2*R

deltaP = -8*portata*densita*viscositaCinematica/(pi*R^4)


