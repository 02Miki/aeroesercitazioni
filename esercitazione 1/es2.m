clc
clear

peso = 160000;
rho = 1.2256;
superficie = 50;
velocita = 80;
alpha = rad2deg(peso/(1/2*rho*velocita^2*superficie*4.7))

cl = deg2rad(alpha)*4.7
cd = 0.016+0.045*cl^2;

spinta = 1/2*rho*velocita^2*superficie*cd

