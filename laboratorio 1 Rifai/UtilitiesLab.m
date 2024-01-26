classdef UtilitiesLab
    %UTILITIES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods(Static)
        function deltaP = trasformaPressioni(hRiferimento,h)
            deltaH = hRiferimento - h;
            deltaP = deltaH * 789 * sin(deg2rad(30))*9.8;
        end
        
        function output = cpx_l(indiceAlfaTotali, cp, presePressione)
            for indiceAlfa = indiceAlfaTotali
                deltaCp = cp(:, indiceAlfaTotali(end) - indiceAlfa + 1) - cp(:, indiceAlfa);
                for indicePressione = 1:length(presePressione)
                    output(indiceAlfa, indicePressione) = deltaCp(indicePressione) * presePressione(indicePressione);
                end
            end
            
        end

        function output = funzioneCosto(integrando, cl, vInf, lunghezzaCorda, indiceAlfaTotali, spaziaturaPrese, x) 
            for alfa = indiceAlfaTotali
                vettoreDiff(alfa) = UtilitiesLab.Ma(integrando, alfa, spaziaturaPrese, vInf, lunghezzaCorda)+UtilitiesLab.L(alfa, cl, vInf, lunghezzaCorda).*x;
            end

            output = sum(abs(diff(vettoreDiff)));
        
        end

        function output = Ma(integrando, indiceAlfa, spaziaturaPrese, vInf, lunghezzaCorda) 
            output = UtilitiesLab.cma(integrando, indiceAlfa, spaziaturaPrese) * 1/2*1.204*vInf^2*lunghezzaCorda^2;
        end

        function output = cma(integrando, indiceAlfa, spaziaturaPrese)
            output = -trapz(spaziaturaPrese*0.01, integrando(indiceAlfa, :));
        end

        function output = L (indiceAlfa, cl, vInf, lunghezzaCorda)
            output = cl(indiceAlfa)*1/2*1.204*vInf^2 * lunghezzaCorda;
        end
    end
end

