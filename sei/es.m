%% 2, punto 1
clc
clear 
close all

% valori a caso, che vengono rimossi dopo
x = linspace(0,0.5);
b = 5;
circ = 3;

vel = @(r, teta1, teta2) circ./(4*pi.*r).*(cos(teta1) + cos(teta2))

velFinale = 0;

teta = pi/2-atan(b./(2.*x));

% tratto inf

teta1 = pi/2;
teta2 = pi/2 - teta;
velFinale = 2*vel(b, teta1, teta2);

% tratto AB

teta1 = teta;
teta2 = teta;
velFinale = velFinale + 2*vel(x, teta1, teta2);

% plotto e adimensionalizzo

plot((2.*x./b), velFinale / (circ/pi*b))


% 2, punto 2

yVal = linspace(-5,5,200);

syms y

x1 = @(y) b/2+y;
x2 = @(y) b/2-y; 

fVel = @(y) circ./(4*pi).*(1./x1(y)+1./x2(y));
vel = fVel(yVal);
velFinali = vel;
posDiscontinuita = [solve(x1, y), solve(x2, y)];

for indice = size(vel,2):-1:2
    if sign(vel(1, indice-1)) ~= sign(vel(1, indice))
        velFinali = [velFinali(1, 1:indice-1) NaN velFinali(1, indice:end)];
    end
end

figure
hold on

for posizione = posDiscontinuita
    plot(posizione*2/(b).*ones(1, 100), linspace(-2,4), ".r", LineWidth=2)
end

plot((2.*(yVal)./b), velFinali(1, 2:end-1) / (circ/pi*b), "k", LineWidth=1.5)

%% 3
clc
clear
close all







