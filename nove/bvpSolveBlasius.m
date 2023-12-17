function [eta, f, df_deta, df_deta_secondo] = bvpSolveBlasius(etaSpan,f0)
% g(1) = f
% g(2) = f'


ode = @(eta,g) [g(2); g(3); -g(1)*g(3)];
% boundary conditions, condizioni al contorno, uso f0(1) e f0(2) per
% mantenerla generica, nel caso dell'esercizio f0 è 1 e 0 rispettivamente
% ga(2) è la derivata di ga(1)
bc = @(ga, gb) [ga(1) - 0; ga(2) - 0; gb(2)-1];

% 3 arg è un guess iniziale

sol = bvp4c(ode, bc, bvpinit(etaSpan, [0 1 0]));

eta = sol.x;
f = sol.y(1,:);
% df/deta
df_deta = sol.y(2,:);
df_deta_secondo = sol.y(3, :);
end

