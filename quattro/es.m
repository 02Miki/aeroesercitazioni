clc
close
clear all

%% 1

% contour
% streamslice vuole punti griglia e componenti di velocità (fare su x e y,
% fare su teta può dare problemi) (serve derivare funzione)

beta = linspace(1, 3/4*pi);

vInf = 1;
m = 1.1;
alfa = 0;

x = linspace(-2,2);
y = linspace(-2,2);


k = vInf*exp(-1i*alfa);
beta = pi/m;
yRetta = -x/(tan(beta-pi/2)).*(x < 0);
w = @(z) k*z.^m.*(imag(z) > yRetta);

[X, Y] = meshgrid(x,y);
z = X+Y*1i;




figure
hold on
contour(X, Y, real(w(z)), "r")
contour(X, Y, imag(w(z)), "b")



plot(x, yRetta, LineWidth=5)
legend("isophi", "isopsi", "spigolo")




%% esercizio 2
clc
clear
close all


vel = 1;
alfa = deg2rad(10);
raggio = 1;

centro = [0.1, 0.1];






