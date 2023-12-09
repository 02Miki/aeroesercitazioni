
%% 1

% clear
close all

Re = 1000000;
viscositaDinamica = 1.8*10^-5;
% re = u*l*rho/mu;
densitaAria = 1.225;
% vel = 1;
vInf = Re*viscositaDinamica/densitaAria;

angoloAttacco = deg2rad(5);
NACA = '6315';
[iaf, af] = def_airfoil(NACA, 50);


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
angoliBeta = [];
for pannelloCiclo = pannelli
    matrice(end+1, :) = [pannelloCiclo.Aij, pannelloCiclo.AiN];
    bi(end+1, 1) = pannelloCiclo.bi;
    angoliBeta(end+1, :) = pannelloCiclo.angoliBeta;
end
matrice(end+1, :) = [pannelli(end).ANj, pannelli(end).ANN];
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
        % cu = q(j)
        % beta = pannelloCiclo.angoliBeta(j) 
        % sin = pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo)
        % cos = pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo)
        % logar = log(pannelloCiclo.Rij(j+1)/pannelloCiclo.Rij(j))
        % uno = pannelloCiclo.Rij(j+1)
        % due = pannelloCiclo.Rij(j)
        primaSomma = primaSomma + q(j)* (pannelloCiclo.angoliBeta(j) * pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo) - log(pannelloCiclo.Rij(j+1)/pannelloCiclo.Rij(j)) * pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo));
        
        secondaSomma = secondaSomma + (pannelloCiclo.angoliBeta(j) * pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo) + log(pannelloCiclo.Rij(j+1)/pannelloCiclo.Rij(j)) * pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo));
        
        som = (primaSomma+secondaSomma)/(2*pi);
        
        
    end
    pannelloCiclo.vTangenziale = vInf * pannello.cosStrano(pannelloCiclo.angolo, pannelloCiclo.angoloAttacco) + 1/(2*pi) * (primaSomma+secondaSomma*gamma);
    pannelloCiclo.cp = 1-pannelloCiclo.vTangenziale^2/vInf^2;

end

figure
plot([pannelli.puntoControlloX], [pannelli.cp])
% Flippa il grafico
set(gca, 'ydir', 'reverse')
title("Cp-C")
xlabel("Corda")
ylabel("Cp")
xlim([-0.01 1.01])

% xfoil
hold on
[pol, foil] = xfoil(strcat('NACA',NACA), rad2deg(angoloAttacco));


% plot(foil.x, foil.y)

xAla = foil.x(1:length(foil.cp));
plot(xAla, foil.cp)

legend("Metodo a Pannelli", "xFoil")









