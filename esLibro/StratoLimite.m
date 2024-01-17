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



%% 7.2 -- non so da dove l'abbia preso

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


%% 2

clc
clear
close all

lunghezza = 0.45;
larghezza = 0.15;
viscositaCinematica = 0.9*10^-4;
densita = 925;
velocita = 6;


re = velocita*lunghezza/viscositaCinematica

if re > 5*10^5
    disp("NON TUTTO LAMINARE")
else
    disp("TUTTO LAMINARE")
end

spessoreStratoLimite = 5*lunghezza/sqrt(re)
tauWallFun = @(x) 0.332 * viscositaCinematica*densita*velocita*sqrt(velocita./(viscositaCinematica.*x))
tauWall = tauWallFun(lunghezza)

resistenzaTotale = 0.664*sqrt(viscositaCinematica*densita^2*lunghezza*velocita^3)*larghezza*2 % 2 facce
% resistenzaAltroMetodo = trapz(linspace(0.00001, lunghezza), tauWallFun(linspace(0.00001, lunghezza)))*spessore

reX = @(x) velocita*x./viscositaCinematica;
cf = @(x) 0.664./sqrt(reX(x));

resistenzaTotaleDue = integral(@(x) 1/2 * densita * velocita^2 * cf(x)*larghezza, 0, lunghezza)*2


%% 3
clc
clear
close all

densita = 1000;
viscositaDinamica = 1.307*10^-3;
velocita = 0.5;

reCritico = 5*10^5;
% re = rho*velocita*lunghezza/mu;

lunghezzaCritica = reCritico*viscositaDinamica/(velocita*densita)
spessore = 5 * lunghezzaCritica/sqrt(reCritico)




