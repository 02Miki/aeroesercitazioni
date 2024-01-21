%% 1 -- INUTILE, FATTO SU XFOIL E POI SU CARTA, FATTO SOLO GRAFICO QUA
clc
clear
close all
lambda = 9.2;
NACA = '4215';
cl = 0;
% 
% alfa zero qua viene -3.7879
% minimoAlfa = -50;
% minimaDifferenza = 50;
% for alfa=linspace(-5, 5)
%     try 
%     diff = abs(xfoil(strcat('NACA',NACA), alfa).CL - cl);
%     if (diff < minimaDifferenza)
%         minimaDifferenza = diff
%         minimoAlfa = alfa
%     end
%     catch excp
%         disp("Errore a " + alfa)
%     end
% end





% xF = @(alfa) xfoil(strcat('NACA',NACA), alfa).CL - cl
% 
% alfa = lsqnonlin(@(alfa) xF(alfa) , alfaGuess)

clPrimo = 7.08;
alfa = deg2rad(1.55);
deltaAlfa = linspace(-alfa/2, alfa/2);
deltaCL_CL = clPrimo/(1+clPrimo/(pi*lambda))*deltaAlfa/cl;

plot(linspace(-50, 50), deltaCL_CL*100)
grid on
xlabel("Variazione percentuale alfa")
ylabel("Variazione percentuale Cl")




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