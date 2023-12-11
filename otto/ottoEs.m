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


%% es extra file

clc
clear
close all

viscositaDinamica = 0.035;
densita = 910;
lunghezza = 25;
diametro = 0.0254;
raggio = diametro/2;
portataStorpia = 5.85; % LITRI/MINUTO
litri2metri3= 1/1000;
minuti2secondi = 1/60;
portata = portataStorpia * litri2metri3 * minuti2secondi;
% portata = velocita * area = velocita * pi*(diametro/2)^2
velocita = portata/(pi*(diametro/2)^2)
reynoldsLimite = 2300;
% re = densita*velocita*lunghezza/viscositaDinamica
reynolds = densita*velocita*diametro/viscositaDinamica

if reynolds < reynoldsLimite
    disp("--- Flusso laminare ---")
    lambda = 64/reynolds
end

% portata = -pi/8 * R^4/mu * dp/dx
deltaP = -portata*8*viscositaDinamica*lunghezza/(pi*raggio^4)

u = @(r) -raggio^2/(4*viscositaDinamica)*deltaP/lunghezza*(1-r.^2./raggio^2);

u(raggio-0.005)



%% problema di stokes

% non usiamo ode, ma un'altra funzione che ci permette (?)

clc
clear
close all

yEnd = 1000;
% sbagliato, non fa linspace perché vogliamo solo determinati istanti di
% tempo, per poter tracciare il grafico
t = linspace(0,5);

viscositaCinematica = 1.5*10^-6; % ni
f0 = [1, 0]; % condizioni al contorno


% sbagliato
etaSpan = y./(2.*sqrt(viscositaCinematica.*t));


% vorticita = -du/dy = -d(f*U)/dy = -df/deta * deta/dy
% calcoliamo anche deltaStar = spessore di spostamento
% calcolare problema di blasius con sta roba
