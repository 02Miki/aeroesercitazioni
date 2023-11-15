classdef pannello
    %PANNELLO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        puntoControlloX
        puntoControlloY
        angolo
    end
    
    methods
        function obj = pannello(puntoControlloX, puntoControlloY, angolo)
            %PANNELLO Construct an instance of this class
            %   Detailed explanation goes here
            obj.puntoControlloX = puntoControlloX;
            obj.puntoControlloY = puntoControlloY;
            obj.angolo = angolo;

        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end

    methods(Static)
        function lista = generaPuntiControllo(x, y)
            for xIndex = 1:size(x) - 1
                xMedio = (x(xIndex) + x(xIndex+1))/2;
                yMedio = (y(xIndex) + y(xIndex+1))/2;

                deltaX = x(xIndex+1) - x(xIndex);
                deltaY = y(xIndex+1) - y(xIndex);

                % angolo = sign(deltaY).*atan2(abs(deltaY), abs(deltaX));
                angolo = atan2(deltaY, deltaX);



                lista(xIndex) = pannello(xMedio, yMedio, angolo);
            end
        end

    end

end

