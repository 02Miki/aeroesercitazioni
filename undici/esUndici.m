%% 1
clc
clear
close all

lunghezza = 1.1;
profondita = 0.75;
viscositaCinematica = 1.5*10^-5;
densita = 1.25;
velocita = 5;

re = velocita*lunghezza/viscositaCinematica;

if re > 5*10^5
    disp("NON TUTTO LAMINARE")
else
    disp("TUTTO LAMINARE")
end


spessoreStratoLimite = 5*lunghezza/sqrt(re)
reX = @(x) velocita*x./viscositaCinematica;
cf = @(x) 0.664./sqrt(reX(x));
cf023 = cf(0.23)

% drag = 1/2 * densita * u^2 * cf
% moltiplico per 2 perché drag c'è sia sopra che sotto
resistenzaTotale = integral(@(x) 1/2 * densita * velocita^2 * cf(x)*profondita, 0, lunghezza)*2

resistenzaTotaleMetodo2 = 2*0.664*profondita*sqrt(densita^2*viscositaCinematica*lunghezza*velocita^3)
%% 2
clc
clear
close all

lunghezza = 2.45;
profondita = 2.15;
viscositaCinematica = 1.5*10^-5; %ni
densita = 1.25;
uInf = 3.6;


reXCritico = 5*10^5;

% Rex = uInf*x/viscositaCinematica
xCritico = reXCritico * viscositaCinematica/uInf
if xCritico < lunghezza
    disp("NON TUTTO LAMINARE")
else
    disp("TUTTO LAMINARE")
end

tauWall = @(x) 0.332 * viscositaCinematica*densita * uInf * sqrt(uInf./(viscositaCinematica.*x));
tauWallCritico = tauWall(xCritico)

cf = integral(@(x) tauWall(x)./(1/2*densita*uInf^2), 0, xCritico)

D = cf*1/2*densita*uInf^2*2*profondita
DAltroMetodo = 2*0.664*profondita*sqrt(densita^2*viscositaCinematica*xCritico*uInf^3)

reX = @(x) uInf*x./viscositaCinematica;
spessoreStratoLimite = @(x) 5 * x./sqrt(reX(x));
spessoreMassimo = spessoreStratoLimite(xCritico);

eta = @(y) y ./ spessoreMassimo;
velocita = @(y) uInf .* ((2.*eta(y) - eta(y).^2).*(y <= spessoreMassimo));

portata = integral(@(y) densita.*velocita(y), 0, spessoreMassimo)



%% es 3
clc
clear
close all


% deltaStar = 1 - u/Uinf



