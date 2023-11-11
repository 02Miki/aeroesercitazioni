function [output] = cpk(t)
%CP Summary of this function goes here
%   Detailed explanation goes here test
if t >= pi/2 & t <= 3/2*pi
    t = pi/2;
end

output = 1-(1.814.*t-0.271.*t.^3-0.0471.*t.^5).^2;
end

