
%% es 3

clc
clear
close all

a = 0.5;
u = 35;
circuitazione = 200;

spazio = linspace(0, 2*pi);
syms tetaAngolo
vTeta = @(tetaAngolo) 2*u*sin(tetaAngolo) + circuitazione/(2*pi*a);
% cp = @(teta) 1-(vTeta(teta)./u).^2;
valori = eval(solve(@(tetaAngolo) vTeta(tetaAngolo) == u, tetaAngolo));

for index = 1:length(valori)
    valore = valori(index);
    % nel caso di valori negativi, fai 2pi-valore
    if sign(valore) == -1
        2*pi+valore
    else 
        valore
    end
end




% angoloFinale = -50;
% distanzaMinima = Inf;
% 
% for angolo=spazio
%     valore = vTeta(angolo);
%     distanza = abs(valore-u);
% 
%     if (distanza) < distanzaMinima
%         angoloFinale = angolo
%         distanzaMinima = distanza
%     end
% end
