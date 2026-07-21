function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 18
    T = [T; NaN(18 - size(T, 1), 1)];
end
T(1) = (params(19)-1)/params(19);
T(2) = params(5)*y(5)^params(4);
T(3) = (y(14)*y(4))^params(1);
T(4) = y(5)^(1-params(1));
T(5) = y(11)^params(14);
T(6) = y(5)^(-params(1));
T(7) = (y(14)*y(4))^(params(1)-1);
T(8) = y(8)*params(1)*T(7);
T(9) = 0.2*(1-params(15))^2;
T(10) = (1-params(15))^3*0.15;
T(11) = (1-params(15))^4*0.1;
T(12) = (1-params(15))^5*0.075;
T(13) = 0.075*(1-params(15))^6;
T(14) = (1-params(15))^7*0.05;
T(15) = 0.05*(1-params(15))^8;
T(16) = 0.05*(1-params(15))^9;
T(17) = 0.05*(1-params(15))^10;
T(18) = 1/y(1);
end
