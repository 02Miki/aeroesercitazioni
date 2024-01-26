clc
close all
clear

% dati{:, 1}
% dimensione = size(dati, 2)
% incidenze{:, 1}
% dimensione(:, 2)

load("matlab3.mat")

presePressione = [0, 2.5, 5, 10, 20, 30, 40, 50, 60, 70, 80];
pressioneAmbiente = 101325;
alphaManometro = deg2rad(30);
temperatura = 20.9+273.15;
densitaLiquido = 789; % kg/m^3
densitaAria = 1.204;
pressioneStaticaInfinitoCM = 0.09; % metri
pressioneTotaleInfinitoCM = 0.04; %metri
corda = 0.1; % metri


pressioni = pressione.generaMatrice(incidenze, dati, pressioneAmbiente, alphaManometro, temperaturaCelsius, densitaLiquido, pressioneStaticaInfinitoCM);

pressioneTotaleInfinito = Utilities.mPressione(pressioneStaticaInfinitoCM, pressioneTotaleInfinitoCM, densitaLiquido, alphaManometro) + pressioneAmbiente

vel = Utilities.velocita(pressioneTotaleInfinito, pressioneAmbiente, densitaAria)

figure
title("Grafico Pressioni - x/c")
xlabel("x/c")
ylabel("Pa")
hold on
for pressione = pressioni
    plot(presePressione, pressione.valori)
end
hold off

legend("-14", "-12", "-10", "-8", "-6",	"-4", "-2", "0", "2", "4", "6", "8", "10", "12", "14")

figure
title("Grafico Cp - x/c")
xlabel("x/c")
ylabel("Cp")
hold on
for pressione = pressioni
    % if pressione.incidenza < 13
    %     continue
    % end
    plot(presePressione, pressione.cp(vel))
    % pause
end

hold off
legend("-14", "-12", "-10", "-8", "-6",	"-4", "-2", "0", "2", "4", "6", "8", "10", "12", "14")

figure
title("Grafico Cl - alpha")
xlabel("alpha")
ylabel("cl")
hold on

for pressione = pressioni
    % if pressione.incidenza < 13
    %     continue
    % end
    pressione.calcolaDifferenzaCp(pressioni, vel);
end

angoli = -14:2:14;
valoriIntegraleCL = [];



for pressione = pressioni
    valoriIntegraleCL(end+1) = trapz(presePressione.*(corda/100), pressione.differenzaCp)/corda;
end

plot(angoli,valoriIntegraleCL)


s1 = spline(angoli, valoriIntegraleCL, linspace(-14, 14));


hold off

figure
hold on
grid on
title("Grafico cl - alpha spline")
xlabel("alpha")
axis([-14, 14, -1, 1])
ylabel("cl")
plot(linspace(-14, 14), s1, LineWidth = 2)
plot(linspace(-14, 14), zeros(1, 100), "black", zeros(1, 100), linspace(-1, 1), "black")

hold off


dragPuliti = [];
preseDrag = [];
distanzaPreseDrag = 0.002;
for riga = 1:size(datiDrag,1)
    if not(isnan(datiDrag{riga, 1}))
        dragPuliti(end+1, :) = datiDrag{riga, :};
        preseDrag(end+1) = riga;
    end
end


for k = 1:size(pressioni, 2)
    cdTot(k) = pressioni(k).calcolaCd(pressioneStaticaInfinitoCM, vel, preseDrag, distanzaPreseDrag, corda, dragPuliti(:, k).*0.01);
end

figure
subplot(2, 2, 1)
hold on
grid on
title("Grafico cd - alpha")
xlabel("alpha")
ylabel("cd")
plot(angoli, cdTot)
hold off

subplot(2, 2, 2)

hold on
grid on
title("Grafico cl - cd")
xlabel("cd")
ylabel("cl")
plot(cdTot, valoriIntegraleCL)
hold off

% Calcolo Ma -- SBAGLIATO, VEDI LABORATORIO 1 RIFAI

for pressione = pressioni
   pressione.calcolaMa(presePressione.*0.01.*corda, pressioni)
end

figure
plot(angoli, [pressioni.Ma])











% legend("-14", "-12", "-10", "-8", "-6", "-4", "-2", "0", "2", "4", "6", "8", "10", "12", "14")




