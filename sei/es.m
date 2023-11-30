%% 2, punto 1
clc
clear 
close all

% valori a caso, che vengono rimossi dopo
x = linspace(0,0.5);
b = 5;
circ = 3;

vel = @(r, teta1, teta2) circ./(4*pi.*r).*(cos(teta1) + cos(teta2))

velFinale = 0;

teta = pi/2-atan(b./(2.*x));

% tratto inf

teta1 = pi/2;
teta2 = pi/2 - teta;
velFinale = 2*vel(b, teta1, teta2);

% tratto AB

teta1 = teta;
teta2 = teta;
velFinale = velFinale + 2*vel(x, teta1, teta2);

% plotto e adimensionalizzo

plot((2.*x./b), velFinale / (circ/pi*b))


% 2, punto 2


yVal = linspace(-5,5,200);

% Definisco y come variabile, così da poterla usare dopo nel solve (che
% servirà per trovare i punti sulla quale tracciare gli asintoti).
% Si può fare anche senza, ma viene meno preciso (sempre usando solo
% matlab)
syms y

x1 = @(y) b/2+y;
x2 = @(y) b/2-y; 

fVel = @(y) circ./(4*pi).*(1./x1(y)+1./x2(y));

vel = fVel(yVal);
% Copio vel in velFinali, così da poter modificare le velocità senza
% distruggere il ciclo

velFinali = vel;
% Trovo la posizione delle discontinuità, per poter tracciare gli asintoti
posDiscontinuita = [solve(x1, y), solve(x2, y)];

% Creo un ciclo al contrario, per esempio se ho 8 velocità, da 8 a 2, con
% un passo negativo. Uso 2 e non 1 perché dentro il for uso anche indice-1.
% Uso un ciclo al contrario perché così non si va a creare una differenza
% tra gli indici "veri" e quelli che uso dentro il ciclo. Usassi un ciclo
% normale, aggiungendo un elemento, si sposterebbero tutti gli elementi di
% uno
for indice = size(vel,2):-1:2
    % se il segno della velocità all'indice i è diverso dal segno della
    % velocità all'indice i-1, allora vai dentro l'if
    if sign(vel(1, indice-1)) ~= sign(vel(1, indice))
        % inserisci un NaN in mezzo alle due velocità, così da poter
        % evitare quella retta che matlab produce tra i due estremi della
        % discontinuità
        velFinali = [velFinali(1, 1:indice-1) NaN velFinali(1, indice:end)];
    end
end

figure
hold on

% Plotta gli asintoti, adimensionalizzando la posizione della discontinuità
for posizione = posDiscontinuita
    plot(posizione*2/(b).*ones(1, 100), linspace(-2,4), ".r", LineWidth=2)
end

% Plotta il grafico, sempre adimensionalizzando

plot((2.*(yVal)./b), velFinali(1, 2:end-1) / (circ/pi*b), "k", LineWidth=1.5)

%% 3

clc
clear
close all


k = 1
l = @(y) lZero * sqrt(1-y.^2./b^2)
circ = @(y) pi*l(y)




