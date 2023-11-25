%% 2
diametro = 0.6;
densita = 1000;
pressione = 100000;
beta = 60;
betaRadianti = deg2rad(beta);
portata = 1000;

velocitaIniziale = portata/(densita*pi*(diametro/2)^2)
area = pi*(diametro/2)^2;

Fx = area*pressione*(1-cos(betaRadianti)) + densita * velocitaIniziale^2 * area * (1-cos(betaRadianti))
Fy = -(densita * velocitaIniziale^2 * sin(betaRadianti) + pressione * sin(betaRadianti)*area)

F = sqrt(Fx^2+Fy^2)

angolo = atan2(Fy,Fx)