
%% 1
clc
clear
close all

[iaf, af] = def_airfoil('0015', 4);


x = flipud(af.x);
y = flipud(af.z);

figure
hold on
plot(x,y, "o-")
plot(af.xC, af.zC)
legend("Profilo Alare", "Linea Media")
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
quiver([pannelli.puntoControlloX], [pannelli.puntoControlloY], cos([pannelli.angolo]), sin([pannelli.angolo]))

legend("Profilo Alare", "Punti di Controllo", "Vettori Tangenti", "Vettori Normali")










