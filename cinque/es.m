
%% 1

clear
close all

vInf = 1;
angoloAttacco = 0;
[iaf, af] = def_airfoil('6315', 3);


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
for pannelloCiclo = pannelli
    matrice(end+1, :) = [pannelloCiclo.Aij, pannelloCiclo.AiN];
    bi(end+1, 1) = pannelloCiclo.bi;
end
matrice(end+1, :) = [pannelli(end).ANj, 1.8538];
bi(end+1, 1) = pannelli(end).bN;



X = linsolve(matrice, bi);
q(1:length(pannelli), 1) = X(1:length(pannelli), 1);
gamma = X(length(pannelli)+1, 1);

for pannelloCiclo = pannelli
    primaSomma = 0;
    secondaSomma = 0;
    for j = 1:length(x)-1
        clc
        altroPannello = pannelli(j);
        cu = q(j)
        beta = pannelloCiclo.angoliBeta(j) 
        sin = pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo)
        cos = pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo)
        logar = log(pannelloCiclo.Rij(j+1)/pannelloCiclo.Rij(j))
        uno = pannelloCiclo.Rij(j+1)
        due = pannelloCiclo.Rij(j)
        primaSomma = q(j)* (pannelloCiclo.angoliBeta(j) * pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo) - log(pannelloCiclo.Rij(j+1)/pannelloCiclo.Rij(j)) * pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo));
        
        secondaSomma = gamma * (pannelloCiclo.angoliBeta(j) * pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo) + log(pannelloCiclo.Rij(j+1)/pannelloCiclo.Rij(j)) * pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo));
        som = (primaSomma+secondaSomma)/(2*pi)
        % pause
        
    end
    pannelloCiclo.vTangenziale = vInf * pannello.cosStrano(pannelloCiclo.angolo, pannelloCiclo.angoloAttacco) + 1/(2*pi) * (primaSomma+secondaSomma);
    pannelloCiclo.cp = 1-pannelloCiclo.vTangenziale^2/vInf^2;

end

figure
plot([pannelli.puntoControlloX], [pannelli.cp])










