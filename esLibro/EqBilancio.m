%% 1
clc
clear
close all


p_patm = 0.1;

densita = 1.25;
patm = 0.1*10^6;
p2 = patm*p_patm;
d1 = 0.01;
d2 = d1/2;

r1 = d1/2;
r2 = d2/2;

area1 = pi*r1^2;
area2 = pi*r2^2;
syms v
risultato = @(v) p2+1/2*densita*(v*area1/area2)^2 - patm - 1/2*densita*v^2;

% max solo perché essendoci un quadrato, vengono due risultati (modulo
% uguale, ma segno opposto)
v1 = max(eval(solve(risultato, v)))

portata = densita*area1*v1


%% 2
clc
clear
close all

d1 = 0.15;
d2 = 0.075;
r1 = d1/2;
r2 = d2/2;

area1 = pi*r1^2;
area2 = pi*r2^2;

deltaP = 5332.896;
densita = 1000;

syms v
risultato = @(v) -deltaP+1/2*densita*(v*area1/area2)^2 - 1/2*densita*v^2;
v1 = max(eval(solve(risultato, v)))

portata = area1*v1


%% 3

clc
clear
close all

densita = 1000;
pressione = 101325;
beta = deg2rad(45);

portata = 1000;
diametro = 0.5;
raggio = diametro/2;
area = raggio^2*pi;
velocita = portata/(area*densita)

syms fx
f_x = @(fx) -densita*(-velocita^2 + velocita^2*cos(beta)) * area - ((pressione*cos(beta) - pressione)*area + fx);
risX = eval(solve(f_x, fx))

syms fy
f_y = @(fy) -densita*(velocita^2*sin(beta))*area - ((pressione*sin(beta)*area) + fy);
risY = eval(solve(f_y, fy))

ftot = sqrt(risX^2+ risY^2)

rad2deg(atan2(risY, risX))









