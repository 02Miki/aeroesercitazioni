clc
clear
close all

dati = readmatrix("risultati_hot_wire_20240110.xlsx");

% cambio mm in metri
dati(:, 1) = dati(:, 1) * 10^-3

% devo calcolare delta, deltaStar, teta e H

uInf = max(dati(:, 2))

vStratoLimiteMatematica = 0.99*uInf

indiciDentroStratoLimite = find(dati(:, 2) <= vStratoLimiteMatematica)
indiceFinale = indiciDentroStratoLimite(end);
delta = dati(indiceFinale, 1)

valoriDeltaStar = 1-dati(:, 2)/uInf;
deltaStarTrapz = trapz(dati(:, 1), valoriDeltaStar)

% non funziona perché integral fa linspace tra valori, quindi capiterebbe
% indice = 1.1, etc
% deltaStar = integral(@(indice) 1-dati(indice, 2)/uInf, 1, indiceFinale)

valoriTeta = dati(:, 2)/uInf .* valoriDeltaStar;


tetaTrapz = trapz(dati(:, 1), valoriTeta)

H = deltaStarTrapz/tetaTrapz

densita = 1.1545;
viscositaCinematica = 1.6*10^-5;
lunghezza = 1;

Re = uInf*lunghezza/viscositaCinematica

ReCritico = 5*10^5;

if Re > ReCritico
    disp("NON TUTTO LAMINARE")
else
    disp("TUTTO LAMINARE")
end

plot(dati(:, 2), dati(:, 1))
title("Strato Limite")
xlabel("Velocità")
ylabel("Altezza")


uTauGuess = 0.5411;
k = 0.41;
c = 5.2;


yPlusFun = @(altezze) altezze*uTauGuess/viscositaCinematica;
uPlusFun = @(uTau, yPlus) (1/k*log(yPlus) + c).*(yPlus > 10 ) + yPlus.*(yPlus < 5);
uCalcolata = @(uTauGuess, uPlus) uPlus * uTauGuess;

funzioneCosto = @(uTau, uPlus, valori) sum(abs(uCalcolata(uTau, uPlus) - valori));

yPlusDati = yPlusFun(dati(:, 1));
uTau = lsqnonlin(@(uTau) funzioneCosto(uTau, uPlusFun(uTau, yPlusDati), dati(:, 2)), uTauGuess)

figure
sperimentali = semilogx(yPlusDati, dati(:, 2)/uTau, "o");
hold on
yPlus = linspace(0, yPlusDati(1));
teorici = semilogx(yPlusDati, uPlusFun(uTau, yPlusDati), "--k");
semilogx(yPlus, yPlus, "--k")

legend([sperimentali, teorici], "Dati Sperimentali", "Dati Teorici")
xlabel("y+")
ylabel("u+")

figure
semilogx(yPlusDati, dati(:, 3), "o")

xlabel("y+")
ylabel("U rms")






