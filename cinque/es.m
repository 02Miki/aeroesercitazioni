
%% 1

clear
close all

vInf = 1;
angoloAttacco = 0;
[iaf, af] = def_airfoil('0015', 2);


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


pannelli = pannello.generaPuntiControllo(x, y, vInf, angoloAttacco);

figure
hold on
plot(x,y, 'o-')
plot([pannelli.puntoControlloX], [pannelli.puntoControlloY], 'x')

axis equal

quiver([pannelli.puntoControlloX], [pannelli.puntoControlloY], -sin([pannelli.angolo]), cos([pannelli.angolo]))
quiver([pannelli.puntoControlloX], [pannelli.puntoControlloY], cos([pannelli.angolo]), sin([pannelli.angolo]))

legend("Profilo Alare", "Punti di Controllo", "Vettori Tangenti", "Vettori Normali")

matrice = [];
bi = [];
for pannello = pannelli
    matrice(end+1, :) = [pannello.Aij, pannello.AiN];
    bi(end+1, 1) = pannello.bi;
end
matrice(end+1, :) = [pannelli(end).ANj, pannelli(end).ANN]
bi(end+1, 1) = pannelli(end).bN
% matrice(end, end+1) = []










