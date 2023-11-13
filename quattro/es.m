

%% 1

clc
clear
close all
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



derZ = k*m*z.^(m-1).*(imag(z) > yRetta);


figure
hold on
contour(X, Y, real(w(z)), "r")
contour(X, Y, imag(w(z)), "b")



plot(x, yRetta, LineWidth=5)
legend("isophi", "isopsi", "spigolo")

figure
hold on
streammo = streamslice(X,Y, real(derZ), -imag(derZ), 1.5);
set(streammo, "LineWidth", 2)
plot(x, yRetta, LineWidth=5)





%% esercizio 2
clc
clear
close all


vel = 1;
alfaImmaginario = 1i*deg2rad(10);
raggio = 1;

x = linspace(-8, 8);
y = linspace(-8, 8);

[X,Y] = meshgrid(x,y);

centro = [0.1, 0.1];

b = sqrt(raggio^2-centro(2)^2) - centro(1);
zc = complex(centro(1), centro(2));

beta = acos((sqrt(raggio^2-centro(2)^2))/raggio);

circ = -2*vel*sin(beta+pi+deg2rad(10))*2*pi*raggio;

W = @(z) (-vel*((z-zc)*exp(alfaImmaginario)+raggio^2./(z-zc).*exp(-alfaImmaginario))-1i*circ/(2*pi)*log((z-zc)./raggio)).*(abs(z) > raggio);

tetaPrimo = linspace(0, 2*pi);

z_cerchio = complex(centro(1), centro(2)) + raggio*exp(1i*tetaPrimo)
hold on

contour(X, Y, imag(W(complex(X,Y))), 31)
plot(real(z_cerchio), imag(z_cerchio), "LineWidth",5)


figure
hold on
zita = z_cerchio+b^2./z_cerchio;
z = complex(X,Y);
plot(real(zita), imag(zita),"LineWidth", 3)
zetaNew = z+b^2./z;
contour(real(zetaNew), imag(zetaNew), imag(W(complex(X,Y))), 31)
axis equal









%%

syms circ


vel = 1;
alfaImmaginario = 1i*deg2rad(10);
raggio = 1;
centro = [0.1, 0.1];


Wgiovanji = 2*vel*sin(beta+pi+deg2rad(10))+circ/(2*pi*raggio);








