classdef Utilities
    %UTILITIES Summary of this class goes here
    %   Detailed explanation goes here
    
    methods(Static)

        function output = velocita(pressioneTotale, pressioneStatica, densita)
            % Calcola la velocità, partendo da pressione totale, statica e densità
            output = sqrt(2*(pressioneTotale - pressioneStatica)/densita);
        end

        function output = mPressione(cmRef, cm, densitaLiquido, alphaManometro)
            % Trasforma i metri in pressione
            output = (cmRef-cm)*densitaLiquido*sin(alphaManometro)*9.8;
        end
    end
end

