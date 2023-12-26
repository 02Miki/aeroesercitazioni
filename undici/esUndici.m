%% 1
clc
clear
close all



%% 2
clc
clear
close all

lunghezza = 2.45;
spessore = 2.15;
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

xSpace = linspace(0, xCritico);
tauWall = @(x) 0.332 * viscositaCinematica*densita * uInf * sqrt(uInf./(viscositaCinematica.*x));
tauWallCritico = 0.332 * viscositaCinematica*densita * uInf * sqrt(uInf/(viscositaCinematica*xCritico))

cf = integral(@(x) tauWall(x)./(1/2*densita*uInf^2)*2, 0, xCritico)

D = cf*1/2*densita*uInf^2*2

% portata al dt = rho*u*dA  = rho * u * 1 * dy


% reX = @(x) uInf*x/viscositaCinematica;


% spessoreStratoLimite = 5 * xCritico/sqrt(rexIntegro)



