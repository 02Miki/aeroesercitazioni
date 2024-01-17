%% 1

clc
clear
close all


allungamento = 9.2;
cl = 0.52;
clPrimo = 5.95;
a0 = -1.5;

a = cl*(1+clPrimo/(pi*allungamento))/clPrimo + deg2rad(a0)

deltaCl_Cl = clPrimo/(cl*(1+clPrimo/(pi*allungamento)))*0.1*a

%% 2

clc
clear
close all

allungamento = 15;
clPrimo = 6;
cl = 0.5;

% cl = clPrimo/(1+clPrimo/(pi*allungamento)*deltaAlfa

deltaAlfa = cl*(1+clPrimo/(pi*allungamento))/clPrimo
cl = clPrimo/(1+clPrimo/(pi*10))*deltaAlfa

%% 3
clc
clear
close all

corda = 1.2;
apertura = 11;
clPrimo = 6.05;
incidenzaIndotta = deg2rad(1.2);
incidenzaGeometrica = deg2rad(6.5);

areaEllisse = pi*corda/2*apertura/2
allungamento = apertura^2/areaEllisse
cl = pi*allungamento*incidenzaIndotta;
deltaAlfa = cl*(1+clPrimo/(pi*allungamento))/clPrimo

alfaZero = rad2deg(incidenzaGeometrica-deltaAlfa)

cDi = cl^2/(pi*allungamento)

%% 4

clc
clear
close all

allungamento = 9.8;
clPrimo = 5.95;
alfaZero = deg2rad(-1.2);
cl = 0.48;

deltaAlfa = cl*(1+clPrimo/(pi*allungamento))/clPrimo
alfa = deltaAlfa + alfaZero

cl = clPrimo/(1+clPrimo/(pi*10))*(alfa-deg2rad(1)-alfaZero)

%% 5
clc
clear
close all

allungamento = 9.5;
aperturaAlare = 12;

velocita = 40;
circuitazione = 16.5;

circuitazioneZero = circuitazione/sqrt(1-(aperturaAlare/4)^2/(aperturaAlare/2)^2)

cl = pi/2 * allungamento/(aperturaAlare)*circuitazioneZero/velocita
cdi = cl^2/(pi*allungamento)





