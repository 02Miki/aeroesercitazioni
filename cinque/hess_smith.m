clear all
close all

% Definizione dell'airfoil
[iaf, af] = def_airfoil('6315', 50);

alpha = 5;
alpha = deg2rad(alpha);

V_0 = 1;
% Definizione punti geometria
x = flipud(af.x);
y = flipud(af.z);

%plot(x, y)
axis equal

N = length(x) - 1;

control_point.x = zeros(1, N);
control_point.y = zeros(1, N);
control_point.length = zeros(1, N);
control_point.theta = zeros(1, N);

N = length(x)-1;
% Calcolo dei punti di controllo
for j = 1:N
    control_point.x(j) = (x(j) + x(j + 1)) / 2;
    control_point.y(j) = (y(j) + y(j + 1)) / 2;

    deltax = x(j + 1) - x(j);
    deltay = y(j + 1) - y(j);

    control_point.length(j) = sqrt(deltax^2 + deltay^2);
    costheta(j) = deltax/control_point.length(j);
    sintheta(j) = deltay/control_point.length(j);
    
end

%% Calcolo distanze dei punti di controllo

r = zeros(N, N + 1);
beta = zeros(N);

for i = 1:N
    for j = 1:N
        dx1 = control_point.x(i) - x(j);
        dy1 = control_point.y(i) - y(j);
        r(i, j) = sqrt(dx1^2 + dy1^2);
        dx2 = control_point.x(i) - x(j + 1);
        dy2 = control_point.y(i) - y(j + 1);
        
        beta(i, j) = atan2(dy2*dx1 - dx2*dy1, dx1*dx2 + dy1*dy2);
    end
    beta(i, i) = abs(beta(i, i));
    r(i, j + 1) = sqrt(dx2^2 + dy2^2);
end
%%
% Definizione matrici dei coefficienti
% A(i,j)
A = zeros(N+1);
for i=1:N
    for j=1:N
        A(i,j) = 1/(2*pi)*(log(r(i,j+1)/r(i,j))* ...
                 (sintheta(i)*costheta(j)-costheta(i)*sintheta(j)) ...
           +beta(i,j)*(costheta(i)*costheta(j)+sintheta(i)*sintheta(j)));
    end
end
% A(i,N+1)
for i=1:N
    somma = 0;
    for j=1:N
        somma = somma+log(r(i,j+1)/r(i,j))*  ...
               (costheta(i)*costheta(j)+sintheta(i)*sintheta(j)) ...
            -beta(i,j)*(sintheta(i)*costheta(j)-costheta(i)*sintheta(j));
    end
    A(i,N+1) = somma/(2*pi);
end
% A(N+1,j)
for j=1:N
    A(N+1,j) = 1/(2*pi)*((beta(1,j)* ... 
              (sintheta(1)*costheta(j)-costheta(1)*sintheta(j)))  ...
-log(r(1,j+1)/r(1,j))*(costheta(1)*costheta(j)+sintheta(1)*sintheta(j)) ...
+beta(N,j)*(sintheta(N)*costheta(j)-costheta(N)*sintheta(j))  ...
-log(r(N,j+1)/r(N,j))*(costheta(N)*costheta(j)+sintheta(N)*sintheta(j)));
end 
% A(N+1,N+1)
somma=0;
for j=1:N
    somma = somma+log(r(1,j+1)/(r(1,j)))* ...
               (sintheta(1)*costheta(j)-costheta(1)*sintheta(j))  ...
+beta(1,j)*(costheta(1)*costheta(j)+sintheta(1)*sintheta(j))  ...
+log(r(N,j+1)/r(N,j))*(sintheta(N)*costheta(j)-costheta(N)*sintheta(j)) ...
+beta(N,j)*(costheta(N)*costheta(j)+sintheta(N)*sintheta(j));
end
A(N+1,N+1) = somma/(2*pi);
% Matrice dei termini noti
B = zeros(N+1,1);
for i=1:N
    B(i) = sintheta(i)*cos(alpha)-costheta(i)*sin(alpha);
end
B(N+1) = -(costheta(1)*cos(alpha)+sintheta(1)*sin(alpha) ...
         + costheta(N)*cos(alpha)+sintheta(N)*sin(alpha));
% Risoluzione sistema
X = linsolve(A,B);
%X = A\B;
q(1:N) = X(1:N);
gamma = X(N+1);

% Calcolo velocità tangenziale e cp nei punti di controllo j 
Vt = zeros(N,1);
cp = zeros(N,1);
for i=1:N
    V_q = 0;
    V_g =  0;
    for j=1:N
        V_q = V_q+q(j)*(beta(i,j)* ...
            (sintheta(i)*costheta(j)-costheta(i)*sintheta(j))...
  -log(r(i,j+1)/r(i,j))*(costheta(i)*costheta(j)+sintheta(i)*sintheta(j)))
        V_g = V_g+log(r(i,j+1)/r(i,j))* ... 
            (sintheta(i)*costheta(j)-costheta(i)*sintheta(j)) ...
  +beta(i,j)*(costheta(i)*costheta(j)+sintheta(i)*sintheta(j))
        
    end
    Vt(i) = (costheta(i)*cos(alpha)+sintheta(i)*sin(alpha)) ...
              +(V_q+gamma*V_g)/(2*pi);
    cp(i) = 1-Vt(i)^2;
end
%cp(N)=cp(1);
%
%figure
plot(control_point.x(1, N/2:N), cp(N/2:N), 'ro-', 'LineWidth', 2, 'Marker', 'square', 'MarkerIndices', 1:2:length(cp)/2)
hold on
plot(control_point.x(1, 1:N/2), cp(1:N/2), 'ro-', 'LineWidth', 2, 'Marker', 'square', 'MarkerIndices', 1:2:length(cp)/2)
%legend('$c_{p}$ metodo dei pannelli', 'Interpreter', 'latex', 'FontSize', 30)

xlim([-0.01 1.01])

grid on
colormap gray
xlabel ('$x/c$','Interpreter','latex','FontName', ...
        'Times','FontSize',25)
ylabel ('$c_p$','Interpreter','latex', ...
        'FontName','Times','Rotation',0,'FontSize',25)
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [.25 .25 18 15.5]);
set(gca,'Ydir','reverse');
saveas (gcf,'HS_panel_cp.png');
figure
plot(control_point.x(1,N/2:N),Vt(N/2:N),'-ko','LineWidth',2, ...
    'MarkerIndices',1:2:length(Vt)/2)
hold on
plot(control_point.x(1,1:N/2),Vt(1:N/2),'-kx','LineWidth',2, ...
    'MarkerIndices',1:2:length(Vt)/2)
legend('(v_t/v_{\infty})^+','(v_t/v_{\infty})^-')
xlim([-0.01 1.01])
grid on
colormap gray
xlabel ('$x/c$','Interpreter','latex','FontName', ...
        'Times','FontSize',18)
ylabel ('$v_t/v_{\infty}$','Interpreter','latex', ...
        'FontName','Times','Rotation',0,'FontSize',18)
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [.25 .25 18 15.5]);
%set(gca,'Ydir','reverse');
saveas (gcf,'HS_panel_vt.png');
%
%                  Delta_cp = cp_ - cp+, cl e cm_0
Delta_cp = zeros(N/2,1);
for i=1:N/2
    Delta_cp(i) = cp(i)-cp(N-i+1);
end
cl = 0;
cm = 0;
for i=2:N/2
    cl = cl+0.5*(Delta_cp(i)+Delta_cp(i-1))*(control_point.x(i-1)-control_point.x(i))
    cm = cm-0.5*(Delta_cp(i)*(control_point.x(i)-0.25)+ ...
          Delta_cp(i-1)*(control_point.x(i-1)-0.25))*(control_point.x(i-1)-control_point.x(i));
end
fprintf('Coefficiente di portanza c_l %d\n',cl)
fprintf('Coefficiente di momento c_{m0} %d\n',cm)
%
% figure
% plot(control_point.x(1:N/2),Delta_cp(1:N/2),'-ko','LineWidth',1, ...
%      'MarkerIndices',1:2:length(Delta_cp))
% xlim([-0.01 1.01])
% grid on
% colormap gray
% xlabel ('$x/c$','Interpreter','latex','FontName', ...
%         'Times','FontSize',18)
% ylabel ('$Delta_{cp}$','Interpreter','latex', ...
%         'FontName','Times','Rotation',0,'FontSize',18)
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperPosition', [.25 .25 18 15.5]);
% %set(gca,'Ydir','reverse');
% saveas (gcf,'HS_panel_Delta_cp.png');