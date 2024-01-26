classdef pressione < handle
    %INCIDENZA Summary of this class goes here
    %   Detailed explanation goes here

    properties
        incidenza % incidenza del profilo alare
        valori % valori della pressione, ordinati in modo crescente rispetto alla corda
        pressioneAmbiente;
        alphaManometro; % angolo inclinazione del manometro
        temperatura; % CELSIUS
        densitaLiquido; % kg/m^3
        pressioneStaticaInfinito;
        differenzaCp;
        pressioniDrag;
        cd;
        Ma;
    end

    properties(Constant)
        densitaAria = 1.204;
    end

    methods
        function obj = pressione(inputArg1,inputArg2, pressioneAmbiente, alphaManometro, temperaturaCelsius, densitaLiquido, pressioneStaticaInfinito)
            %PRESSIONE Constructor
            obj.incidenza = inputArg1;
            obj.valori = inputArg2;
            obj.pressioneAmbiente = pressioneAmbiente;
            obj.alphaManometro = alphaManometro;
            obj.temperatura = temperaturaCelsius;
            obj.densitaLiquido = densitaLiquido;
            obj.pressioneStaticaInfinito = pressioneStaticaInfinito;
        end

        function output = cp(obj, velocita)
            % Calcola il Cp, data una certa velocità
            output = 2*obj.valori./(pressione.densitaAria*velocita^2);
        end

        function calcolaDifferenzaCp(obj, pressioni, velocita)
            valoriCp = obj.cp(velocita);

            for pressione = pressioni
                if pressione.incidenza == -obj.incidenza
                    pressioneNegativa = pressione;
                    break
                end
            end
            cpNeg = pressioneNegativa.cp(velocita);
            obj.differenzaCp = -1*(valoriCp - cpNeg);
        end

        function output = calcolaMa(obj, presePressione, pressioni)
            obj.Ma = trapz(presePressione, obj.calcolaDifferenzaPressioni(pressioni).*presePressione);
            output = obj.Ma;
        end

        function output = calcolaDifferenzaPressioni(obj, pressioni)
            for pressione = pressioni
                if pressione.incidenza == -obj.incidenza
                    pressioneNegativa = pressione;
                    break
                end
            end

            output = obj.valori-pressioneNegativa.valori;
        end

        function output = cpPosizione(obj, posizione, velocita)
            % posizione
            % obj.valori
            output = 2*obj.valori(posizione)./(pressione.densitaAria*velocita^2);
        end

        function output = calcolaCd(obj, altezzaRiferimento, velocita, presePressione, distanzaPreseDrag, lunghezzaCorda, dragMetri)
            obj.pressioniDrag = Utilities.mPressione(altezzaRiferimento, dragMetri, obj.densitaLiquido, obj.alphaManometro);
            velocitaDrag = sqrt((obj.pressioniDrag)/(obj.densitaAria*0.5));

            drag = obj.densitaAria.*velocita^2*trapz(presePressione.*distanzaPreseDrag, (velocitaDrag./velocita).*(1-velocitaDrag./velocita));
            obj.cd = drag/(0.5*obj.densitaAria*velocita^2*lunghezzaCorda);
            output = obj.cd;
            
        end

    end



    methods(Static)
        function matricePressioni = generaMatrice(incidenze, valori, pressioneAmbiente, alphaManometro, temperaturaCelsius, densitaLiquido, pressioneStaticaInfinito)
            %Genera una matrice di oggetti pressione, data una tabella di valori importati dal file excel

            % Prendo il numero di colonne
            dimensioneTabella = size(valori, 2);
            for k = 1:dimensioneTabella
                pressioni = [];

                % Prendo la k-esima colonna dei valori, e la traspongo, per farla diventare un vettore riga (necessario per for loop)
                val = valori{:, k}';

                % Trasformo i cm in pascal
                for valore = val
                    pressioni(end+1) = Utilities.mPressione(pressioneStaticaInfinito, valore*10^-2, densitaLiquido, alphaManometro);
                end
                % Creo l'oggetto
                pressure = pressione(incidenze{:, k}, pressioni, pressioneAmbiente, alphaManometro, temperaturaCelsius, densitaLiquido,pressioneStaticaInfinito);
                matricePressioni(k) = pressure;
            end

        end
    end
end

