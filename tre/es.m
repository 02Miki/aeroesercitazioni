clc
clear
close all



q = -2;
circ = 3;

psiPozzo = @(x,y) (q.*atan2(y,x))./(2*pi);
psiVortice = @(x,y) -circ.*log(sqrt(x.^2+y.^2))./(2*pi);

teta=linspace(0.001, 2*pi);
r=linspace(0,3);

x=r.*cos(teta);
y=r.*sin(teta);


[X,Y] = meshgrid(x,y);

figure
hold on
contour(X,Y, psiPozzo(X,Y)+psiVortice(X,Y), 250);

derPsiPozzo = @(x, y) -1./(2.*x.*pi^2.*(y.^2./x.^2 + 1));
derPsiVortice = @(x, y) -(3.*y)./(2.*pi.*(x.^2 + y.^2));
derPhiPozzo = @(x, y) -y./(2.*x.^2.*pi.^2.*(y.^2./x.^2 + 1));
derPhiVortice = @(x, y) (3.*x)./(2.*pi.*(x.^2 + y.^2));
% contour(X,Y, )

funzione = @(x,y) - (70368744177664.*log(x.^2 + y.^2))./2778046668940015 - (3.*atan(x./y))./(2*pi);
contour(X,Y, funzione(X,Y), 250, "r")

hold off
figure
% streamslice(x,y, u, v, 1.5)
streamslice(X, Y, derPsiPozzo(X,Y)+derPsiVortice(X,Y), derPhiPozzo(X,Y)+derPhiVortice(X,Y), 1.5)

%% derivate

clc
clear
close all

syms x
q = -2;
circ = 3;

psiPozzo = @(x,y) -(q.*atan(y./x))./(2*pi)./(2*pi);
psiVortice = @(x,y) circ.*log(sqrt(x.^2+y.^2))./(2*pi);

diff(psiVortice, x)

%% int

clc
clear
close all

syms x

integ = int( @(y) -1./(2.*x.*pi^2.*(y.^2./x.^2 + 1)) - (3.*y)/(2*pi.*(x.^2 + y.^2)), x)


%% es 2

clc
clear 
close all




