%% 1
clc
clear
close all

allungamento = 9.2;
naca = 4215;
cl = 0.52;
% preso da xfoil
alfa0 = deg2rad(-3.6909)

% presi da xfoil, dati angoli a caso, per calcolare clPrimo (coefficiente
% angolare cl/alfa senza incidenza indotta)
clAlfa_0 = 0.4574;
clAlfa_5 = 1.0735;

clPrimo = (clAlfa_5-clAlfa_0)/deg2rad(5)

syms alfa
clFun = @(alfa, altroAlfa) clPrimo/(1+clPrimo/(pi*allungamento)) * (alfa-altroAlfa);

% trovo angolo iniziale per la quale il cl è quello dato dal testo
angoloCl = eval(solve(@(alfa) clFun(alfa, alfa0) == cl, alfa));
angoloClGradi = rad2deg(angoloCl)

alfaSpace = linspace(angoloCl - angoloCl/2, angoloCl + angoloCl/2);

variazionePercentuale = clFun(alfaSpace(end), alfaSpace(end-1))/cl *100
plot(linspace(-50, 50), (clFun(alfaSpace, alfa0)-cl)/cl*100)

grid on
ylabel("Variazione % cl")
xlabel("Variazione % alfa")


%% 2

clc
clear
close all



