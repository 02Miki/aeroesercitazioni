
%% 1
clc
clear
close all

[iaf, af] = def_airfoil('0015', 30)


x = flipud(af.x);
y = flipud(af.z);

figure

plot(x,y)
axis equal

% fai media
% trova deltax = (x+1) - x


pannelli = pannello.generaPuntiControllo(x, y);

figure
hold on
plot(x,y, 'o-')
plot([pannelli.puntoControlloX], [pannelli.puntoControlloY], 'x')
axis equal

quiver([pannelli.puntoControlloX], [pannelli.puntoControlloY], -sin([pannelli.angolo]), cos([pannelli.angolo]))
% quiver([pannelli.puntoControlloX], [pannelli.puntoControlloY], cos([pannelli.angolo]), sin([pannelli.angolo]))







