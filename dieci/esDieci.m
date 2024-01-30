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
uTauGuess = 3.33;
k = 0.41;
c = 5.2;
viscositaCinematica = 1.5*10^-6; % ni
% !! Yplus al momento non cambia al variare di uTauGuess !! (da correggere)
yPlusFun = @(altezze) altezze*uTauGuess/viscositaCinematica;
yPlus = yPlusFun(altezzeAbs);
% devo dividere strato limite?
% 1) no, perché tutto influenza utau
% 2) si, a metà, ma perché tutto non influenza? NON A META
yPlusMeta = yPlusFun(0.02);
yPlusMax = yPlusFun(0.04);

uPlusFun = @(uTau, yPlus) (1/k*log(yPlus) + c).*(yPlus > 10 & yPlus < uTau*0.04/viscositaCinematica) + yPlus.*(yPlus < 10);
uCalcolata = @(uTauGuess, uPlus) uPlus * uTauGuess;
funzioneCosto = @(uTau, uPlus, valori) sum(abs(uCalcolata(uTau, uPlus) - valori));

% impongo y/delta <= 1
indiciInferiori = find(altezzeAbs <= deltaUno);
indiciSuperiori = find(altezzeAbs >= 0.04-deltaDue);

uPlusSotto = @(uTau) uPlusFun(uTau, yPlus(indiciInferiori));
uPlusSopra = @(uTau) uPlusFun(uTau, abs(yPlus(indiciSuperiori) - yPlusMax));
uTauSopra = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusSopra(uTau), valori(indiciSuperiori)), uTauGuess)
uTauSotto = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusSotto(uTau), valori(indiciInferiori)), uTauGuess)


uPlusSperimentale = @(velocita, uTau) velocita/uTau;

figure

sperimentali = semilogx(yPlus(indiciInferiori), uPlusSperimentale(valori(indiciInferiori), uTauSotto), "o");
hold on
spazio = [linspace(yPlusFun(0), 9.9, 1000), linspace(10.1, yPlus(indiciInferiori(1)), 1000)];
teorici = semilogx(spazio, uPlusFun(uTauSotto, spazio), "--k");
title("Strato limite inferiore")
xlabel("y+")
ylabel("u+")
legenda = legend([sperimentali, teorici], "Dati Sperimentali", "Dati Teorici");
legenda.Location = "northwest";
grid on

figure


sperimentali = semilogx(abs(yPlus(indiciSuperiori) - yPlusMax), uPlusSperimentale(valori(indiciSuperiori), uTauSopra), "o");
hold on
spazio = [linspace(yPlusFun(0), 9.9, 1000), linspace(10.1, abs(yPlus(indiciSuperiori(end)) - yPlusMax) , 1000)];
teorici = semilogx(spazio, uPlusFun(uTauSopra, spazio), "--r");
xlabel("y+")
ylabel("u+")
legenda = legend([sperimentali, teorici], "Dati Sperimentali", "Dati Teorici");
legenda.Location = "northwest";
% plot(abs(yPlus(indiciSuperiori) - yPlusMax), uPlusFun(uTauSopra, abs(yPlus(indiciSuperiori) - yPlusMax)), "--")

title("Strato limite superiore")
grid on


% uTauTot = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusFun(uTau, yPlus), valori), uTauGuess)

variazioniVelocita = readmatrix("fluctuation.txt");
posizioni = readmatrix("fluctuation_point.txt");

figure
% Grafico molto approssimativo di u rms
semilogx(abs(yPlusFun(posizioni(:, 2))), variazioniVelocita(1, 1:end-1), "ok")

% Tentativo spline, non utile
% spazio = linspace(abs(yPlusFun(posizioni(1, 2))), abs(yPlusFun(posizioni(end, 2))), 1000);
% sp = spline(abs(yPlusFun(posizioni(:, 2))), variazioniVelocita(1, 1:end-1), spazio)
% hold on
% semilogx(spazio, sp)

xlabel("y+")
ylabel("U rms")
title("Fluttuazioni di velocità")
grid on



%% parte due

% fluttuazioni velocita
matriceAltezze1 = readmatrix("altezza_canale_1.txt");
nsperg = length(matriceAltezze1);
close all
% ci manca il tempo (la frequenza di acquisizione) 
% ottengo fase e altezza di ogni curva, descritta come seno e coseno
% la fase è di quanto è sfasata rispetto a quella originale
% fft fa somma di sin, e associa ampiezza a ogni seno. Ci serve ampiezza
% trova coefficienti e sfasamento del segnale. Valore abs è ampiezza, arctg
% è la fase, e per avere energia faccio ^2
fourier1 = fft(matriceAltezze1, nsperg);
fACQ = 25600; %hz
ampiezza1 = abs(fourier1);
energia1 = ampiezza1.^2;

f1 = linspace(0, fACQ, nsperg);
% loglog(f1, ampiezza)
figure
loglog(f1, energia1)


% Più alto del primo
matriceAltezze2 = readmatrix("altezza_canale_2.txt");
nsperg = length(matriceAltezze2);

fourier2 = fft(matriceAltezze2, nsperg);
ampiezza2 = abs(fourier2);
energia2 = ampiezza2.^2;

f2 = linspace(0, fACQ, nsperg);
hold on
loglog(f2, energia2)

legend("Primo", "Secondo")
% PARTE PIATTA ALLA FINE è RUMORE, LA NOSTRA FUNZIONE VORREBBE CONTINUARE A SCENDERE
xlabel("Frequenze")
ylabel("Energie")


% DECADONO ALLO STESSO MODO, [] è universale, grazie a questo possiamo
% creare dei modelli



