%% 1

clc
clear
close all

densita = 1.23;
viscositaCinematica = 1.46*10^-5;
uInf = 20;
pInf = 101325;
y = 2*10^-3;
deltaP = 1.3*10^2;

% 1/2*densita*velocita^2 + p = cost

u = sqrt(deltaP/(1/2*densita))
eta = u/uInf;
delta = y/eta;
% delta = 3.5*sqrt(viscositaCinematica * x/uInf)
x = (delta/3.5)^2*uInf/viscositaCinematica



%% 7.2

clc
clear
close all

lunghezza = 4;
profondita = 2;
viscositaCinematica = 1.6*10^-5; %ni
densita = 1.164;
uInf = 2;


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

D = cf*1/2*densita*uInf^2*profondita
DAltroMetodo = 0.664*profondita*sqrt(densita^2*viscositaCinematica*xCritico*uInf^3)

reX = @(x) uInf*x./viscositaCinematica;
spessoreStratoLimite = @(x) 5 * x./sqrt(reX(x));
spessoreMassimo = spessoreStratoLimite(xCritico);

eta = @(y) y ./ spessoreMassimo;
velocita = @(y) uInf .* ((2.*eta(y) - eta(y).^2).*(y <= spessoreMassimo));

portata = integral(@(y) densita.*velocita(y), 0, spessoreMassimo)*profondita




