

%teta1 = linspace(-pi/2, pi/2);
%teta2 = linspace(pi/2, 3/2*pi);

%cp90 = cp(pi/2);
%cd = (integral(@(t) (1-(1.814.*t-0.271.*t.^3-0.0471.*t.^5).^2).*cos(t), -pi/2, pi/2) + integral(@(t) (cp90).*cos(t), pi/2, 3*pi/2))/2
%cl = (integral(@(t) (1-(1.814.*t-0.271.*t.^3-0.0471.*t.^5).^2).*sin(t), -pi/2, pi/2) + integral(@(t) (cp90).*sin(t), pi/2, 3*pi/2))/2


r=5;


teta = linspace(-pi/2, 3/2*pi);
cp= @(x) (1-(1.814.*x-0.271.*x.^3-0.0471.*x.^5).^2) .* (x < pi/2) + (1-(1.814*(pi/2)-0.271*(pi/2)^3-0.0471*(pi/2)^5)^2).*(x >= pi/2);
cp(0.3*pi);
cp(3/2*pi)
x = r.*cos(teta);
y = r.*sin(teta);

quiver(x, y, cp(teta).*cos(teta), cp(teta).*sin(teta))
