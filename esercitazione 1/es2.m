clc
clear

peso = 160000;
rho = 1.2256;
superficie = 50;
velocita = 80;
alpha = rad2deg(peso/(1/2*rho*velocita^2*superficie*4.7))

cl = deg2rad(alpha)*4.7
cd = 0.016+0.045*cl^2;

spintaFun = @(cd) 1/2*rho*velocita^2*superficie*cd
spinta = spintaFun(cd)

% assignment --  METODO TROPPO LUNGO, LASCIATO STARE
% Re = 1000000;
% 
% profili = 1:9999;
% 
% for k = 1000:9999
%     k
%     [iaf, af] = def_airfoil(int2str(k), 5);
%     if af.xLEcenter < 0.00001
%         continue
%     end
%     try
%         xfoil(strcat('NACA', int2str(k)), 10, Re, 0.2, "oper/iter 150")
%     catch excp
%     end
% end
% 
% 
% 
% 
% [iaf1, af1] = def_airfoil('0012', 5)
% [iaf, af] = def_airfoil('1001', 5)
% 
% 
% 
% 
% x = flipud(af.x);
% y = flipud(af.z);
% 
% figure
% hold on
% plot(x,y, "o-")






