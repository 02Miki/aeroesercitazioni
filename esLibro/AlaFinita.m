%% 1

clc
clear
close all


allungamento = 9.2;
cl = 0.52;
clPrimo = 5.95;
a0 = -1.5;

a = cl*(1+clPrimo/(pi*allungamento))/clPrimo + deg2rad(a0)



deltaCl_Cl = clPrimo/(cl*(1+clPrimo/(pi*allungamento)))*0.1*a











