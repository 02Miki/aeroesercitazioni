%% 2

clc
clear
close all

raggio = 1;
centro = [0.1, 0.1];

vInf = 1;
alfa = deg2rad(10);

x = linspace(-5, 5);
y = linspace(-5, 5);

z = x + y*1i;

zc = centro(1) + centro(2)*1i;

tetaPrimo = asin(centro(2)/raggio)
% V = 2*vInf*sin(tetaPrimo + alfa) + circuitazione/(2*pi*raggio)
circuitazione = 4*pi*raggio*vInf*sin(alfa+tetaPrimo)

W = @(z) (-vInf * ((z-zc).*exp(1i*alfa) + raggio^2./(z-zc)*exp(-1i*alfa)) - 1i*circuitazione./(2*pi).*log((z-zc)./raggio)).*(abs(z-zc) > raggio);

[X, Y] = meshgrid(x, y);
Z = complex(X,Y);
hold on
[inutile, isoPsi] = contour(X, Y, imag(W(Z)), 31)

% punti arresto
syms angolo
soluzioni = solve(2*vInf*sin(alfa + angolo) + circuitazione/(2*pi*raggio))

teta = linspace(0,2*pi);
xCerchio = raggio.*cos(teta) + centro(1);
yCerchio = raggio.*sin(teta) + centro(2);

cerchio = plot(xCerchio, yCerchio, LineWidth=1.5)
axis equal
for solIndex = 1:length(soluzioni)
    grafici(solIndex) = plot(raggio.*cos(soluzioni(solIndex)) + centro(1), raggio.*sin(soluzioni(solIndex)) + centro(2), "or", LineWidth=2)
end

legend([isoPsi, grafici(1)], "Linee di Corrente", "Punti di Arresto")

b = sqrt(raggio^2-centro(2)^2) - centro(1);
zita = @(z) z + b^2./z;

figure
hold on
[inutile, isoPsi] = contour(real(zita(Z)), imag(zita(Z)), imag(W(Z)), 31)

zCerchio = complex(xCerchio, yCerchio);
plot(real(zita(zCerchio)), imag(zita(zCerchio)), LineWidth=1.5)
% punti arresto nuovi
for solIndex = 1:length(soluzioni)
    xArresto = raggio.*cos(soluzioni(solIndex)) + centro(1);
    yArresto = raggio.*sin(soluzioni(solIndex)) + centro(2);

    zArresto = xArresto +1i*yArresto;

    grafici(solIndex) = plot(real(zita(zArresto)), imag(zita(zArresto)), "or", LineWidth=2)
end

legend([isoPsi, grafici(1)], "Linee di Corrente", "Punti di Arresto")


xlim([-5, 5])
ylim([-5, 5])


