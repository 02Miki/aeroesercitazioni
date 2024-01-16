%% 3 -- SBAGLIATO, VELOCITA è SBAGLIATA DI 3 ORDINI DI GRANDEZZA, MA IL NUMERO GIUSTO
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

velocitaMax = viscositaCinematica/diametro * reCritico%* 10^-3 per qualche motivo ordine di grandezza è sbagliato
portata = velocitaMax*densita*pi*(diametro/2)^2

% portata = -pi/8 * R^4/mu * dp/dx
dp_dx = -portata * viscositaDinamica/(diametro/2)^4 * 8/pi

pExit = 0.5*100000 + dp_dx*lunghezza


