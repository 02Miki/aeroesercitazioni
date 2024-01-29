
clc
clear 
close all


q = -2;
circ = 3;

teta = linspace(0, 2*pi);
raggio = linspace(0, 2);

x = raggio.*cos(teta);
y = raggio.*sin(teta);

[x, y] = meshgrid(x, y);


psi = q.*atan2(y,x)./2*pi + (-circ/2*pi).*log(sqrt(x.^2+y.^2))
phi = - (2150310427208497.*atan(x./y))./4503599627370496 - log(x.^2 + y.^2)./(2*pi);

% u = @(x, y) (pi.*(imag(y) - real(x)))./((imag(x) + real(y)).^2 + (imag(y) - real(x)).^2) - (3*pi.*y)./(2*(x.^2 + y.^2));
u = @(x,y) - (2150310427208497.*y)./(4503599627370496.*(x.^2 + y.^2)) - 1./(x.*pi.*(y.^2./x.^2 + 1))
% u = @(x,y) - (2150310427208497.*y)./(4503599627370496.*(x.^2 + y.^2)) - 1./(x.*pi.*(y.^2./x.^2 + 1));

% v = @(x, y) (3*pi.*x)./(2*(x.^2 + y.^2)) - (pi.*(imag(x) + real(y)))./((imag(x) + real(y)).^2 + (imag(y) - real(x)).^2);
% v = @(x,y) (2150310427208497.*x)./(4503599627370496.*(x.^2 + y.^2)) - y./(x.^2.*pi.*(y.^2./x.^2 + 1))
v =@(x,y) (2150310427208497.*x)./(4503599627370496.*(x.^2 + y.^2)) - y./(x.^2.*pi.*(y.^2./x.^2 + 1));
 

streamslice(x, y, u(x,y), v(x,y), 1.5)
figure 
hold on
contour(x, y, phi, 200)
contour(x, y, psi, 200)

%% 2

clc
clear
close all

teta = linspace(0, 2*pi);

l = 0.001;
circ = 5000;
% PERCHé RAGGIO DEVE ESSERE COSTANTE E NON VARIARE
% O SE VARIA, CONTOUR NECESSITA 2K PUNTI
raggio = linspace(0.01, 1);

x = raggio.*cos(teta);
y = raggio.*sin(teta);

[X,Y] = meshgrid(x,y);

phi = l*circ.*sin(atan2(Y,X))./(2*pi.*sqrt(X.^2+Y.^2));
hold on

contour(X, Y, phi, 200, "-r")

psi = (5.*(Y.^2./X.^2 + 1).^(1/2))./((X.^2 + Y.^2).^(1/2).*(2*pi + (2*pi.*Y.^2)./X.^2));
contour(X, Y, psi, 200)


%% 3
clc
clear
close all

a = 1;
u = 1;
circ = 1/2 * 4*pi*a*u;

r = linspace(0, 5);
teta = linspace(0, 2*pi);

x = r.*cos(teta);
y = r.*sin(teta);

[X,Y] = meshgrid(x,y);

psi = (u.*(a^2./(sqrt(X.^2+Y.^2).^2)-1).*Y - circ./(2*pi).*log(sqrt(X.^2+Y.^2)./a)).*(sqrt(X.^2+Y.^2)>=a);
phi = - X - atan(X./Y) - X./(X.^2 + Y.^2);

l = contour(X,Y, psi, 31, "-b", 'LineWidth',1);


hold on
plot(a.*cos(teta), a.*sin(teta), 'LineWidth',3)

axis equal



% trovo punti di arresto
syms tetaAngolo
vTeta = @(tetaAngolo) (2.*sin(tetaAngolo))/a.^2 - sin(tetaAngolo)*(1./a.^2 - 1) + 1./a;
valori = solve(vTeta, tetaAngolo)

for valore = valori
    plot(cos(valore), sin(valore), "or", 'MarkerFaceColor', 'r', LineWidth=2)
end

% figure
% contour(X,Y, phi, 31, "-b", 'LineWidth',1);
% plot(cos(valori(2)), sin(valori(2)), "or", LineWidth=2)

% capitolo 3, slide 58
cp = 1-(vTeta(teta)./u).^2

figure
hold on
plot(a.*cos(teta), a.*sin(teta), 'LineWidth',1)

quiver(a*cos(teta), a*sin(teta), cp.*cos(teta), cp.*sin(teta), "LineWidth", 1.5)
axis equal

cl = trapz(teta, -cp.*sin(teta))
cd = trapz(teta, -cp.*cos(teta))






%% derivate
clc
clear
syms Y X 

teta = linspace(0, 2*pi);
raggio = linspace(0, 2);
q = -2;
circ = 3;
a = 1;
u = 1;
circ = 1/2 * 4*pi*a*u;
% x = raggio.*cos(teta);

% psi= (-2*atan(y/x))/(2*pi) + (-3/(2*pi))*log(sqrt(x^2+y^2));
% u=diff(psi,y)
% v=-diff(psi,x)

psi = (u.*(a^2./(sqrt(X.^2+Y.^2).^2)-1).*Y - circ./(2*pi).*log(sqrt(X.^2+Y.^2)./a))

ub = diff(psi, Y)
v = diff(-psi, X)

phi = int(ub, X)

% l = 0.001;
% circ = 5000;
% raggio = 5;
% phi = l*circ.*sin(atan(Y./X))./(2*pi.*sqrt(X.^2+Y.^2));
% % u = diff(psi, y)
% v = diff(phi, X)
% % 
% phi = int(v, Y)

%% altre der

syms raggio teta

a = 1;
u = 1;
circ = 1/2 * 4*pi*a*u;
psi = (u.*(a^2./(raggio.^2)-1).*raggio.*sin(teta) - circ./(2*pi).*log(raggio./a))

% u = diff(psi, raggio)
v = diff(-psi, raggio)







