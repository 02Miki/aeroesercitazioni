function [ iaf,af ] = def_airfoil( a,b )
%a has to be the number of the airfoil es: '0024'
%b is the number of point for each side 
iaf.designation=a;
% designation='0012';
iaf.n=b;
iaf.HalfCosineSpacing=1;
iaf.wantFile=1;
iaf.datFilePath='./'; % Current folder
iaf.is_finiteTE=0;

af = naca4gen(iaf);

% plot(af.x,af.z,'bo-')
% 
% xlabel('x/c','FontSize',30);
% ylabel('y/c','FontSize',30);
% 
% set(gca, 'FontSize',20);
% axis equal
%plot(af.xU,af.zU,'bo-')
%hold on
%plot(af.xL,af.zL,'ro-');
%hold off;




end

