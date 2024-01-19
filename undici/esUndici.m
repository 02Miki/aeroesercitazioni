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

deltaStar = integral(@(eta) 1-(2.*eta-eta.^2), 0, 1)
teta = integral(@(eta) (2.*eta-eta.^2).*(1-(2.*eta-eta.^2)), 0, 1)



%% es 3
clc
clear
close all

eta = linspace(0, 6, 500)
u_UInf = sin(pi/2.*eta).*(eta <= 1) + 1.*(eta > 1)


deltaStar = trapz(eta, 1-u_UInf);
teta = trapz(eta, u_UInf.*(1-u_UInf));
H = deltaStar/teta

delta = sqrt(pi/teta)

deltaStarVero = deltaStar * delta
tetaVero = delta*teta
cf = sqrt(pi*teta)

% deltaStar = 1 - u/Uinf

plot(u_UInf, eta, LineWidth=1.5)



%% es 4
clc
clear

eta = linspace(0, 6, 500);
u_UInf = erf(eta);

deltaStar = trapz(eta, 1-u_UInf);
teta = trapz(eta, u_UInf.*(1-u_UInf));
H = deltaStar/teta;


hold on
plot(u_UInf, eta, LineWidth=1.5)

% Calcolo delta
step = 0.0001;
spazio = 0:step:0.5;
% calcolo la derivata con matlab
derivataU = diff(erf(spazio))/step;

delta = sqrt(derivataU(1)*2/teta)

%% blasius

viscositaCinematica = 1.5*10^-6; % ni
y = 1000;
f0 = [0,0,1]; 

maxEta = 6;
etaSpan = [0, maxEta];

[eta, f, fPrimo, fSecondo] = bvpSolveBlasius(etaSpan, f0);


plot(fPrimo, eta, LineWidth=1.5)
xlabel("U/U Inf")
ylabel("eta")
legend("Sinuisoidale", "Funzione Errori", "Blasius")

