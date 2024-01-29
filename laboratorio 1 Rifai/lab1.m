clc
close all
clear

matrice = readmatrix("Dati sperimentali.xlsx");

incidenze = -14:2:14;
pressioneInfinito = 101325;
inclinazioneManometro = deg2rad(30);

pressioneStaticaInfinitoMetri = 0.09;
pressioneTotaleInfinitoMetri = 0.04;
densitaLiquido = 789;

% eliminazione prima colonna di NaN, elimino prima colonna indice prese, e
% prime 3 righe
matrice = matrice(4:end, 3:end);

matricePreseAla = matrice(1:11, :).*0.01;

spaziaturaPrese = [0, 2.5, 5, 10:10:80];

deltaH = pressioneStaticaInfinitoMetri - matricePreseAla;
pressioni = deltaH * densitaLiquido * sin(inclinazioneManometro)*9.8;


vInf = sqrt(2*UtilitiesLab.trasformaPressioni(pressioneStaticaInfinitoMetri, pressioneTotaleInfinitoMetri)/1.204);

cp = pressioni./(1/2*1.204*vInf^2);
hold on
for indiceIncidenza = 1:length(incidenze)
    % if (indiceIncidenza ~= length(incidenze) & indiceIncidenza ~= 1) 
    %     continue
    % end
    plot(spaziaturaPrese, cp(:, indiceIncidenza))

    cl(indiceIncidenza) = trapz(spaziaturaPrese*0.01, cp(:, length(incidenze) - indiceIncidenza + 1) - cp(:, indiceIncidenza));
end

legend("-14", "-12", "-10", "-8", "-6",	"-4", "-2", "0", "2", "4", "6", "8", "10", "12", "14")
xlabel("% Corda")
ylabel("Cp")

figure
subplot(1, 2, 1)
plot(incidenze, cl)
title("Grafico Cl-Alfa Originale")
grid on


xlabel("alfa")
ylabel("Cl")

spazio = linspace(-14, 14);

hold on
sp = spline(incidenze, cl, spazio);
subplot(1, 2, 2)
plot(spazio, sp, LineWidth=2)
hold on
indiceAlfaTotali = 1:length(incidenze);
viscositaDinamica = 1.8*10^-5;
Re = 1.204*vInf/viscositaDinamica;
spazioPlot = linspace(-20, 20);
indiceSpazio = 1:length(spazioPlot)

for i = indiceSpazio
    indice = spazioPlot(i);
    try
        [pol, foil] = xfoil('NACA0015', indice, Re, 0.2, "oper/iter 300");
        clXFoil(i) = pol.CL;
    catch excp
        indiceErrore
        clXFoil(i) = NaN;
    end

end

for i = find(isnan(clXFoil))
    if i == indiceSpazio(end)
        clXFoil(i) = clXFoil(i-1);
        continue
    end
    clXFoil(i) = (clXFoil(i-1) + clXFoil(i+1))/2;
end

plot(spazioPlot, clXFoil, LineWidth=2)

title("Grafico Cl-Alfa Spline")

grid on

xlabel("alfa")
ylabel("Cl")
legend("Dati Sperimentali", "XFoil", "Location","northwest")

lunghezzaCorda = 1;

% L = @(indiceAlfa) cl(indiceAlfa)*1/2*1.204*vInf^2 * lunghezzaCorda

% cpx_l = @(indiceAlfa) 



% righe = indice alfa, colonne = prese pressione
integrando = UtilitiesLab.cpx_l(indiceAlfaTotali, cp, spaziaturaPrese.*0.01);

% funzionec = UtilitiesLab.funzioneCosto(integrando, cl, vInf, lunghezzaCorda, indiceAlfaTotali, spaziaturaPrese, 0.45)


% cma = @(indiceAlfa) -trapz(spaziaturaPrese*0.01, integrando(indiceAlfa, :));

% Ma = @(indiceAlfa) cma(indiceAlfa) * 1/2*1.204*vInf^2*lunghezzaCorda^2;
% 
% 
% funzioneCosto = @(x) diff(Ma(indiceAlfaDiff) + L(indiceAlfaDiff).*x);
% 
posizioneFuoco = lsqnonlin(@(x) UtilitiesLab.funzioneCosto(integrando, cl, vInf, lunghezzaCorda, indiceAlfaTotali, spaziaturaPrese, x), 0.5)

matricePreseDrag = matrice(15:end-3, :)*0.01;
distanza = 0.002;
vettoreDistanze = distanza:distanza:(distanza*length(matricePreseDrag));
vettoreDistanze = [vettoreDistanze(1:4), vettoreDistanze(6:end)];

deltaH = pressioneStaticaInfinitoMetri - matricePreseDrag;
matricePressioniDrag = deltaH * densitaLiquido * sin(inclinazioneManometro)*9.8;

matriceVelocita = sqrt(matricePressioniDrag/((1/2) * 1.204));
matriceVelocita = [matriceVelocita(1:4, :); matriceVelocita(6:end, :)];

drag = @(indiceAlfa) 1.204*vInf^2*trapz(vettoreDistanze, matriceVelocita(:, indiceAlfa)./vInf .* (1-matriceVelocita(:, indiceAlfa)./vInf));

resistenze = drag(indiceAlfaTotali);

cd = resistenze / (1/2*1.204*vInf^2);

figure
plot(cd, cl)
grid on
title("Grafico cl - cd")
xlabel("cd")
ylabel("cl")

figure
plot(incidenze, cd)
grid on
title("Grafico cd - alpha")
xlabel("alpha")
ylabel("cd")
