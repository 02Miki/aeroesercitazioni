function [eta, f, df_deta] = bvpSolve(etaSpan,f0)
% g(1) = f
% g(2) = f'
% ode è quello che sta a dx dell'uguale (appunti)

ode = @(eta,g) [g(2); -2 * eta*g(2)];
% boundary conditions, condizioni al contorno, uso f0(1) e f0(2) per
% mantenerla generica, nel caso dell'esercizio f0 è 1 e 0 rispettivamente
% ga(2) è la derivata di ga(1)
bc = @(ga, gb) [ga(1) - f0(1); gb(1) - f0(2)];

% 3 arg è un guess iniziale

sol = bvp4c(ode, bc, bvpinit(etaSpan, f0));

eta = sol.x;
f = sol.y(1,:);
% df/deta
df_deta = sol.y(2,:);
end

