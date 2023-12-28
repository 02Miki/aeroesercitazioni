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