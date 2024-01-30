clc
clear
close all

dati = readmatrix("risultati_hot_wire_20240110.xlsx");

% cambio mm in metri
dati(:, 1) = dati(:, 1) * 10^-3;

% devo calcolare delta, deltaStar, teta e H

uInf = max(dati(:, 2))

vStratoLimiteMatematica = 0.99*uInf;

indiciDentroStratoLimite = find(dati(:, 2) <= vStratoLimiteMatematica);
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
grid on


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
yPlusGrafico = [yPlusDati; yPlusDati(end)*5];
uPlusCalcolata = uPlusFun(uTau, yPlusGrafico);

teorici = semilogx(yPlusGrafico, uPlusCalcolata, "--k");
semilogx(yPlus, yPlus, "--k")
grid on

legenda = legend([sperimentali, teorici], "Dati Sperimentali", "Dati Teorici");
legenda.Location = "northwest";
xlabel("y+")
ylabel("u+")
xlim([0, yPlusDati(end)*2])
figure

semilogx(yPlusDati, dati(:, 3), "o")

xlabel("y+")
ylabel("U rms")
title("Fluttuazioni di velocità")

tauWall = uTau^2 * densita;

cf = tauWall/(1/2*densita*uInf^2)
grid on

% SBAGLIATI
%drag = trapz(linspace(0, 1), ones(1, 100) * tauWall)
%cd = drag/(1/2*densita*uInf^2)
% GIUSTI
dragAltroMetodo = densita*uInf^2*tetaTrapz
cdAltroMetodo = dragAltroMetodo/(1/2*densita*uInf^2)


nsperg = length(dati(:, 3));


fourier1 = fft(dati(:, 3), nsperg);
fACQ = 25600; %hz
ampiezza1 = abs(fourier1);
energia1 = ampiezza1.^2;

f1 = linspace(0, fACQ, nsperg);
% loglog(f1, ampiezza)
figure

% quando il grafico si appiattisce è a causa di rumore di fondo
loglog(f1, energia1)
xlabel("Frequenze")
ylabel("Energie")
grid on

