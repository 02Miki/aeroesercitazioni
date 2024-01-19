%% 1
clc
clear
close all

h = 0.005;
velocita = 0.2;
tau = 2;
densita = 900;
reCritico = 360;
du_dy = velocita/h;
mu = tau/du_dy
velocitaMax = reCritico*mu/(h*densita)

%% 2
clc
clear
close all

portata = 10/60;
densita = 917;
viscositaCinematica = 5*10^-4;
reMax = 2000;
% re = densita*u*l/mu
% portata = u*pi*(diametro/2)^2
% u = portata/(rho*pi*(diametro/2)^2)
diametro = (reMax*viscositaCinematica*pi/(4*portata))^-1
% portata = -2/3 * diametro^2/mu*dp_dx

dp_dx = portata*(-8/pi)*viscositaCinematica*densita/(diametro/2)^4

%% 3 
clc
clear
close all


diametro = 0.01;
lunghezza = 250;
viscositaCinematica = 10^-6;
densita = 1000;
reCritico = 2000;
viscositaDinamica = viscositaCinematica * densita;

% portata = densita*velocita*area

velocitaMedia = viscositaCinematica/diametro * reCritico;
portata = velocitaMedia*pi*(diametro/2)^2

% portata = -pi/8 * R^4/mu * dp/dx
dp_dx = -portata * viscositaDinamica/(diametro/2)^4 * 8/pi;

pExit = 0.5*100000 + dp_dx*lunghezza

%% 4
clc
clear
close all

viscositaDinamica = 0.05;
densita = 900;
diametro = 0.019;
velocitaMedia = 0.3;
lunghezzaCondotto = 45;

reCritico = 2300;
dp_dx = velocitaMedia*8*viscositaDinamica/(diametro/2)^2;
dp = dp_dx*lunghezzaCondotto

% vMax = (diametro/2)^2/(4*viscositaDinamica)*dp_dx

re = densita*diametro*velocitaMedia/viscositaDinamica
distanza = diametro/2-0.007;

velocita7 = (diametro/2)^2/(4*viscositaDinamica)*dp_dx*(1-(distanza/(diametro/2))^2)

%% 5

clc
clear
close all


viscositaDinamica = 0.12;
densita = 900;
diametro = 0.15;
raggio = diametro/2;
vMax = 3;


dp_dx = vMax/raggio^2*4*viscositaDinamica
vMedia = raggio^2/(8*viscositaDinamica)*dp_dx

re = densita*vMedia*diametro/viscositaDinamica

portata = vMedia*pi*raggio^2

lunghezzaCondotto = 500;
pressioneUscita = 0.5*100000;
pressioneEntrata = pressioneUscita + dp_dx*lunghezzaCondotto



