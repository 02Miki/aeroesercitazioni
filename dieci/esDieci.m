%% 1

clc
clear
close all


matrice = readmatrix("vupplane1.csv");
altezze = matrice(:, 1);
valori = matrice(:, 2);
subplot(2, 1, 1)
plot(valori, altezze)
title("Strato limite condotto")

indiciMaggiori = find(altezze>-0.02);
xlabel("Velocità")
ylabel("Altezza")

subplot(2, 1, 2)
hold on
title("Confronto strato limite parte alta e bassa")
plot(valori(indiciMaggiori:end), altezze(indiciMaggiori:end))
plot(valori(1:indiciMaggiori), abs(altezze(1:indiciMaggiori))-0.04)
xlabel("Velocità")
ylabel("Altezza")
legend("Sopra", "Sotto")


% trovo spessore strato limite
altezzeAbs = abs(altezze);
uInf = max(valori);
vStratoLimite = 0.99 * uInf;
indiciVMax = find(valori>=vStratoLimite);
indiceStratoLimite = indiciVMax(end);

deltaUno = altezzeAbs(indiceStratoLimite)
deltaDue = altezzeAbs(indiciVMax(1))

% non metto meno perché le altezze sono negative
deltaStarUno = trapz(altezze(indiciMaggiori:end), 1-valori(indiciMaggiori:end)./uInf)
deltaStarDue = trapz(altezze(1:indiciMaggiori), 1-valori(1:indiciMaggiori)./uInf)

tetaUno = trapz(altezze(indiciMaggiori:end), valori(indiciMaggiori:end)./uInf.*(1-valori(indiciMaggiori:end)./uInf))
tetaDue = trapz(altezze(1:indiciMaggiori), valori(1:indiciMaggiori)./uInf.*(1-valori(1:indiciMaggiori)./uInf))


% non posso calcolare tau wall perché non ho altezza = 0
% random guess, metto valore a caso e poi avvicino a mano per trovare valore preciso
uTauGuess = 3.2422;
k = 0.4;
c = 5.2;
viscositaCinematica = 1.5*10^-6; % ni
% !! Yplus al momento non cambia al variare di uTauGuess !! (da correggere)
yPlusFun = @(altezze) altezze*uTauGuess/viscositaCinematica;
yPlus = yPlusFun(altezzeAbs);
% devo dividere strato limite?
% 1) no, perché tutto influenza utau
% 2) si, a metà, ma perché tutto non influenza?
yPlusMeta = yPlusFun(0.02);
yPlusMax = yPlusFun(0.04);

uPlusFun = @(uTau, yPlus) (1/k*log(yPlus) + c).*(yPlus > 10 & yPlus < uTau*0.04/viscositaCinematica) + yPlus.*(yPlus < 5);
uCalcolata = @(uTauGuess, uPlus) uPlus * uTauGuess;
funzioneCosto = @(uTau, uPlus, valori) sum(abs(uCalcolata(uTau, uPlus) - valori));

indiciInferiori = find(yPlus <= yPlusMeta);
indiciSuperiori = find(yPlus >= yPlusMeta);
uPlusSotto = @(uTau) uPlusFun(uTau, yPlus(indiciInferiori));
uPlusSopra = @(uTau) uPlusFun(uTau, abs(yPlus(indiciSuperiori) - yPlusMax));
uTauSopra = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusSopra(uTau), valori(indiciSuperiori)), uTauGuess)
uTauSotto = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusSotto(uTau), valori(indiciInferiori)), uTauGuess)


uTauTot = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusFun(uTau, yPlus), valori), uTauGuess)

