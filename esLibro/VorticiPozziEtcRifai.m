%% 2
clc
clear
close all

a = 0.5;
vInf = 40;
v_0_a = 95;
syms circ
solve(@(circ) 2*vInf*sin(pi/2) + circ/(2*pi*a) == v_0_a, circ)



%% es 3

clc
clear
close all

a = 0.5;
u = 35;
circuitazione = 200;

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
