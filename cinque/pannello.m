classdef pannello < handle
    %PANNELLO Summary of this class goes here
    %   Detailed explanation goes here

    properties
        puntoControlloX
        puntoControlloY
        angolo
        Rij
        lunghezzaPannello
        angoliBeta
        Aij
    end

    methods
        function obj = pannello(puntoControlloX, puntoControlloY, angolo, lunghezzaPannello)
            %PANNELLO Construct an instance of this class
            %   Detailed explanation goes here
            obj.puntoControlloX = puntoControlloX;
            obj.puntoControlloY = puntoControlloY;
            obj.angolo = angolo;
            obj.lunghezzaPannello = lunghezzaPannello;

        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end

        function output = generaMatrici(obj)
            for indice = size(obj.Rij)

            end
        end
    end

    methods(Static)
        function lista = generaPuntiControllo(x, y)
            for xIndex = 1:size(x) - 1
                xMedio = (x(xIndex) + x(xIndex+1))/2;
                yMedio = (y(xIndex) + y(xIndex+1))/2;

                deltaXCentro = x(xIndex+1) - x(xIndex);
                deltaYCentro = y(xIndex+1) - y(xIndex);

                % angolo = sign(deltaY).*atan2(abs(deltaY), abs(deltaX));
                angolo = atan2(deltaYCentro, deltaXCentro);
                lunghezza =  sqrt(deltaXCentro^2 + deltaYCentro^2);
                pan = pannello(xMedio, yMedio, angolo, lunghezza);
                lista(xIndex) = pan;

                % for indiceX = 1:size(x) - 1
                for indiceX = 1:size(x)
                    deltaX = xMedio - x(indiceX);
                    deltaY = yMedio - y(indiceX);

                    pan.Rij(indiceX) = sqrt(deltaX^2 + deltaY^2);

                end

            end
            %            genero angoli beta, ciclo sui pannelli
            for indexPannello = 1:size(lista, 2)
                pannelloCiclo = lista(indexPannello);

                % ciclo sui pannelli di nuovo, per determinare il beta
                for xIndex = 1:size(x) - 1
                    % indiceSuccessivo = (xIndex+1)*(xIndex+1 <= size(pannelloCiclo.Rij, 2))+1*(xIndex+1 > size(pannelloCiclo.Rij, 2))
                    arg = -(lista(xIndex).lunghezzaPannello^2-pannelloCiclo.Rij(xIndex)^2-pannelloCiclo.Rij(xIndex+1)^2)/(2*pannelloCiclo.Rij(xIndex)*pannelloCiclo.Rij(xIndex+1));
                    beta = real(acos(arg));
                    pannelloCiclo.angoliBeta(xIndex) = beta;
                    altroPannello = lista((xIndex+1) * (xIndex+1<=size(lista,2)) + 1*(xIndex+1>size(lista,2)));

                    aij = log(altroPannello.Rij(xIndex)/pannelloCiclo.Rij(xIndex))*sin(altroPannello.angolo-pannelloCiclo.angolo) + beta*cos(altroPannello.angolo-pannelloCiclo.angolo);
                    altroPannello.angolo
                    pannelloCiclo.angolo
                    
                    
                    pannelloCiclo.Aij(xIndex) = aij;


                end
            end

        end

    end

end

