

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
y = linspace(-0.5,2.5);


k = vInf*exp(-1i*alfa);
beta = pi/m;
yRetta = -x/(tan(beta-pi/2)).*(x < 0);
w = @(z) k*z.^m.*(imag(z) > yRetta);

[X, Y] = meshgrid(x,y);
z = X+Y*1i;



derZ = k*m*z.^(m-1).*(imag(z) > yRetta);


figure
hold on
contour(X, Y, real(w(z)), 31,"r")
contour(X, Y, imag(w(z)), 31,"b")



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

Re = 1000000;
viscositaDinamica = 1.8*10^-5;
% re = u*l*rho/mu;
densitaAria = 1.225;
% vel = 1;
vInf = Re*viscositaDinamica/densitaAria;
alfa = deg2rad(10);
raggio = 1;


alfaImmaginario = 1i*alfa;
x = linspace(-8, 8);
y = linspace(-8, 8);


[X,Y] = meshgrid(x,y);

centro = [0.1, 0.1];

b = sqrt(raggio^2-centro(2)^2) - centro(1);
zc = complex(centro(1), centro(2));

% beta = acos((sqrt(raggio^2-centro(2)^2))/raggio);
beta = asin(centro(2)/raggio);
% centroy = raggio*sin(beta)

% Calcolo la circuitazione imponendo V in B = 0
circ = -2*vInf*sin(beta+pi+deg2rad(10))*2*pi*raggio;

W = @(z) (-vInf*((z-zc)*exp(alfaImmaginario)+raggio^2./(z-zc).*exp(-alfaImmaginario))-1i*circ/(2*pi)*log((z-zc)./raggio)).*(abs(z-zc) > raggio);

tetaPrimo = linspace(0, 2*pi, 160);

z_cerchio = complex(centro(1), centro(2)) + raggio*exp(1i*tetaPrimo);
subplot(2,2, 1)

hold on
Z = complex(X,Y);
contour(X, Y, imag(W(Z)), 31)
plot(real(z_cerchio), imag(z_cerchio), "LineWidth", 3)
axis equal

subplot(2,2, 2)

hold on
zita = z_cerchio+b^2./z_cerchio;

zetaNew = Z+b^2./Z;


contour(real(zetaNew), imag(zetaNew), imag(W(Z)), 31)
plot(real(zita), imag(zita),"LineWidth", 2)

axis equal

v = @(tetaPrimo) 2*vInf.*sin(tetaPrimo+alfa) + circ/(2*pi*raggio);

vStar = v(tetaPrimo)./abs(1-b^2./(z_cerchio.^2));
% da bernoulli
cp = @(velocita) 1-(velocita./vInf).^2;


subplot(2,2, 3)

plot(real(zita), cp(vStar), "b-o", LineWidth=1)
title("Cp-Zita")
grid on

subplot(2,2, 4)

plot(real(zita) ,((vStar)./vInf).^2, "b-o")
axis equal
title("(V/VInf)^2-Zita")
grid on

xi = real(zita);

[pol, foil] = xfoil('NACA0015', 10);

figure

% plot(foil.x, foil.y)

xAla = foil.x(1:length(foil.cp));
yAla = foil.y(1:length(foil.cp));
hold on

beta_Dopo = 0;
corda_Dopo = 1;
b_Dopo = corda_Dopo/4;
tMax = 0.15;
% tmaxL = 0.144;

xc = tMax/5.2;
yc = 0;
raggio_Dopo = (b_Dopo+xc)/cos(beta_Dopo);

yc = sin(beta_Dopo)*raggio_Dopo;

[cp, zita] = kj(pol.Re, raggio_Dopo, [xc, yc], 10);


subplot(2,1,1)
hold on
plot(-real(zita) + real(zita(1)), imag(zita))
plot([xAla; 1], [yAla; yAla(1)])
legend("KJ", "XFoil")
title("Confronto profilo alare KJ e XFoil")
grid on

axis equal
subplot(2,1,2)

hold on
plot(xAla, foil.cp)
plot(-real(zita) + real(zita(1)), cp)
ylabel("Cp")
xlabel("Corda Alare")
title("Confronto CP KJ e XFoil")
xlim([-0.1, 1.1])

grid on

legend("KJ", "XFoil")

% Flippa il grafico
set(gca, 'ydir', 'reverse')


% grafico velocità
figure
hold on
% plot(-real(zita) + real(zita(1)), imag(zita)*100)

tetaSpace = linspace(0, 2*pi, 160);

plot(-real(zita) + real(zita(1)), abs(vStar))
plot([xAla; xAla(1)], abs(vInf*foil.UeVinf(1:length(foil.cp)+1)))

title("Confronto Velocità KJ e XFoil")
legend("KJ", "XFoil")
ylabel("Velocità")
xlabel("Corda Alare")
grid on
xlim([-0.2, 1.2])

angoloAttacco = 10;
[cp, zita, corda, vStar] = kj(pol.Re, 1.6, [0.1, 0.16], angoloAttacco);

% Originariamente, le coordinate del profilo partono dal bordo d'attacco, e
% passano sopra, sul dorso, per poi passare dal bordo d'uscita e dal
% ventre, a xfoil non piace, lo cambio

cordinateX = (-real(zita) + max(real(zita)))/corda;
cordinateY = imag(zita)/corda;
massimoCorda = find(max(cordinateX) == cordinateX);

% Usato per capire come 
% plot(cordinateX(1:massimoCorda), cordinateY(1:massimoCorda))
figure
hold on
plot(cordinateX, cordinateY)
title("Profilo Generico di Kutta-Jukowski")

% Trasposta perché flipud inverte le righe, ma noi abbiamo 1 riga e
% tot colonne, e xfoil vuole le cose in colonna
cordinateXOrdinate = [flipud(cordinateX(1:massimoCorda)'); flipud(cordinateX(massimoCorda+1:end)')];
cordinateYOrdinate = [flipud(cordinateY(1:massimoCorda)'); flipud(cordinateY(massimoCorda+1:end)')];
[pol, foil] = xfoil([cordinateXOrdinate cordinateYOrdinate], angoloAttacco, Re, 0.2, "oper/iter 300");
xAla = foil.x(1:length(foil.cp));
yAla = foil.y(1:length(foil.cp));

plot(xAla, yAla)
legend("KJ", "XFoil")
axis equal
grid on

figure
hold on
plot(cordinateX, cp)
plot(xAla, foil.cp)
legend("KJ", "XFoil")
title("Confronto CP KJ e XFoil")
ylabel("Cp")
xlabel("Corda Alare")

grid on
xlim([-0.2, 1.2])
set(gca, 'ydir', 'reverse')





%% esercizio 2 libro whatsapp

clc
clear
close all

clc
clear
close all

raggio_Dopo = 0.5;
vInf = 40;
vTarget = 95;

(vTarget - 2*vInf*sin(pi/2))*(2*pi*raggio_Dopo)/pi







%%

syms circ


vInf = 1;
alfaImmaginario = 1i*deg2rad(10);
raggio_Dopo = 1;
centro = [0.1, 0.1];


Wgiovanji = 2*vInf*sin(beta_Dopo+pi+deg2rad(10))+circ/(2*pi*raggio_Dopo);








