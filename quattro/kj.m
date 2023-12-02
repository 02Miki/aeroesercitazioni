function [cp, zita] = kj(Reynolds, raggio, centroCerchio, alfaGradi)

    viscositaDinamica = 1.8*10^-5;
    % re = u*l*rho/mu;
    densitaAria = 1.225;
    % vel = 1;
    vInf = Reynolds*viscositaDinamica/densitaAria;
    alfa = deg2rad(alfaGradi);
    
    
    alfaImmaginario = 1i*alfa;
    x = linspace(-8, 8);
    y = linspace(-8, 8);
    
    
    [X,Y] = meshgrid(x,y);
    
    % centroCerchio = [0.1, 0.1];
    
    b = sqrt(raggio^2-centroCerchio(2)^2) - centroCerchio(1);
    zc = complex(centroCerchio(1), centroCerchio(2));
    
    % beta = acos((sqrt(raggio^2-centro(2)^2))/raggio);
    beta = asin(centroCerchio(2)/raggio);
    % centroy = raggio*sin(beta)
    
    % Calcolo la circuitazione imponendo V in B = 0
    circ = -2*vInf*sin(beta+pi+alfa)*2*pi*raggio;
    
    W = @(z) (-vInf*((z-zc)*exp(alfaImmaginario)+raggio^2./(z-zc).*exp(-alfaImmaginario))-1i*circ/(2*pi)*log((z-zc)./raggio)).*(abs(z-zc) > raggio);
    
    tetaPrimo = linspace(0, 2*pi, 160);
    
    z_cerchio = complex(centroCerchio(1), centroCerchio(2)) + raggio*exp(1i*tetaPrimo);
    % subplot(2,2, 1)
    
    % hold on
    Z = complex(X,Y);
    % contour(X, Y, imag(W(Z)), 100)
    % plot(real(z_cerchio), imag(z_cerchio), "LineWidth", 3)
    % axis equal
    
    % subplot(2,2, 2)
    % 
    % hold on
    zita = z_cerchio+b^2./z_cerchio;
    
    % zetaNew = Z+b^2./Z;
    
    
    % contour(real(zetaNew), imag(zetaNew), imag(W(Z)), 100)
    % plot(real(zita), imag(zita),"LineWidth", 3)
    % 
    % axis equal
    
    v = @(tetaPrimo) 2*vInf.*sin(tetaPrimo+alfa) + circ/(2*pi*raggio);
    
    vStar = v(tetaPrimo)./abs(1-b^2./(z_cerchio.^2));
    % da bernoulli
    cpFunct = @(velocita) 1-(velocita./vInf).^2;
    cp = cpFunct(vStar);
    
    % subplot(2,2, 3)
    % 
    % plot(real(zita), cp(vStar), "b-o", LineWidth=1)
    % 
    % subplot(2,2, 4)
    % 
    % plot(real(zita) ,((vStar)./vInf).^2, "b-o")
    % axis equal
end

