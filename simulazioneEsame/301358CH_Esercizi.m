%%  2
clc
clear 
close all

diametro = 0.6;
rho = 1000;
p = 1;
portata = 1000;
beta = 60;
betaRadianti = deg2rad(beta);

velocita = portata/(rho*pi*(diametro/2)^2)

vOrizz = velocita;
u = velocita;

vDeviata = u/cos(betaRadianti);

deltaP = 1/2*rho*(0^2-(vDeviata*sin(betaRadianti))^2)


Fx = (deltaP)*pi*(diametro/2)^2
Fy = rho*pi*(diametro/2)^2*u*(vDeviata*sin(betaRadianti))

Ftot = sqrt(Fx^2+Fy^2);

angoloRadianti = acos(Fx/Ftot)



