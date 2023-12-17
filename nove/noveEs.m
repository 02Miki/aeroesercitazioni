%% blasius

clc
clear
close all

viscositaCinematica = 1.5*10^-6; % ni
y = 1000;
f0 = [0,0,1]; % VA UTILIZZATO 0 1 0 PER VENIRE GIUSTO, PERCHè?
% Ipotesi: metto 0 1 0 perché chiudo il "cerchio" di ipotesi allo stesso
% grado di derivazione, e "apro" il cerchio nuovo dopo, così da avere
% condizione iniziale e finale una dietro l'altra
maxEta = 6;
etaSpan = [0, maxEta]; % max valore 11, dopo il solver ha problemi, il warning è utile per capire se soluzione è accettabile o no

[eta, f, fPrimo, fSecondo] = bvpSolveBlasius(etaSpan, f0);


plot(fPrimo, eta, LineWidth=1.5)
grid on

spessoreDiSpostamento = sqrt(2) * (trapz(eta, 1-fPrimo)) % delta star
spessoreQDM = sqrt(2) * (trapz(eta, fPrimo.*(1-fPrimo))) % teta
coefficienteDiForma = spessoreDiSpostamento/spessoreQDM % H

tauWall = fSecondo(1)/sqrt(2)
cf = tauWall/(1/2)

Df = trapz(tauWall)