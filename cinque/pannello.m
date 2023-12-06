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
        AiN
        ANj
        ANN
        vInf
        angoloAttacco
        bi
        bN
    end
        

    methods
        function obj = pannello(puntoControlloX, puntoControlloY, angolo, lunghezzaPannello, vInf, angoloAttacco)
            %PANNELLO Construct an instance of this class
            %   Detailed explanation goes here
            obj.puntoControlloX = puntoControlloX;
            obj.puntoControlloY = puntoControlloY;
            obj.angolo = angolo;
            obj.lunghezzaPannello = lunghezzaPannello;
            obj.vInf = vInf;
            obj.angoloAttacco = angoloAttacco;
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
        function output = sinStrano(angolo1, angolo2)
            output = sin(angolo1)*cos(angolo2)-cos(angolo1)*sin(angolo2);
        end

        function output = cosStrano(angolo1, angolo2)
            output = sin(angolo1)*sin(angolo2)+cos(angolo1)*cos(angolo2);
        end


        function lista = generaPuntiControllo(x, y, vInf, angoloAttacco)
            for xIndex = 1:size(x) - 1
                xMedio = (x(xIndex) + x(xIndex+1))/2;
                yMedio = (y(xIndex) + y(xIndex+1))/2;

                deltaXCentro = x(xIndex+1) - x(xIndex);
                deltaYCentro = y(xIndex+1) - y(xIndex);

                % angolo = sign(deltaY).*atan2(abs(deltaY), abs(deltaX));
                angolo = atan2(deltaYCentro, deltaXCentro);
                lunghezza =  sqrt(deltaXCentro^2 + deltaYCentro^2);
                pan = pannello(xMedio, yMedio, angolo, lunghezza, vInf, angoloAttacco);
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
                    % altroPannello = lista((xIndex+1) * (xIndex+1<=size(lista,2)) + 1*(xIndex+1>size(lista,2)));
                    % 
                    % aij = log(altroPannello.Rij(xIndex)/pannelloCiclo.Rij(xIndex))*pannello.sinStrano(altroPannello.angolo, pannelloCiclo.angolo) + beta*pannello.cosStrano(altroPannello.angolo,pannelloCiclo.angolo);
                    % altroPannello.Rij(xIndex)
                    % pannelloCiclo.Rij(xIndex)
                    % pause
                    % altroPannello.angolo;
                    % pannelloCiclo.angolo;
                    % 
                    % 
                    % pannelloCiclo.Aij(xIndex) = aij;


                end


            end
            
            somma3 = zeros(1, (size(x,1)-1));
            somma4 = 0;
            for indexPannello = 1:size(lista, 2)
                pannelloCiclo = lista(indexPannello);
                somma2 = 0;
                for indexR = 1:size(x)-1
                    beta = pannelloCiclo.angoliBeta(indexR);
                    if indexR == indexPannello
                        beta = -beta;
                    end
                    altroPannello = lista(indexR);

                    % 1 matrice
                    % il beta ha meno davanti perché altrimenti non veniva,
                    % e poi aij ha un abs perché i risultati sono tutti
                    % positivi
                
                    aij = log(pannelloCiclo.Rij(indexR+1)/pannelloCiclo.Rij(indexR))*pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo) - beta*pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo);
                    pannelloCiclo.Aij(indexR) = abs(aij)/(2*pi);
                    % 2 matrice
                    
                    somma2 = somma2+log(pannelloCiclo.Rij(indexR+1)/pannelloCiclo.Rij(indexR))*pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo) + beta*pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo);
                    if indexPannello == 1 || indexPannello == size(lista, 2)
                        % 3 matrice, metto - davanti a beta per stessa
                        % motivazione

                        somma3(indexR) = somma3(indexR)-beta*pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo)-log(pannelloCiclo.Rij(indexR+1)/pannelloCiclo.Rij(indexR))*pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo);
                        % 4 matrice
                        somma4 = somma4 - beta*pannello.cosStrano(pannelloCiclo.angolo, altroPannello.angolo)+log(pannelloCiclo.Rij(indexR+1)/pannelloCiclo.Rij(indexR))*pannello.sinStrano(pannelloCiclo.angolo, altroPannello.angolo);
                    end

                    %bi
                    pannelloCiclo.bi = pannelloCiclo.vInf*pannello.sinStrano(pannelloCiclo.angolo, pannelloCiclo.angoloAttacco);



                    
                end
                pannelloCiclo.AiN = somma2/(2*pi);
            end
            lista(end).ANj = somma3./(2*pi);
            lista(end).ANN = somma4./(2*pi);
            lista(end).bN = -lista(end).vInf*(pannello.cosStrano(lista(1).angolo, lista(1).angoloAttacco) + pannello.cosStrano(lista(end).angolo, lista(end).angoloAttacco));

        end
    end

end

