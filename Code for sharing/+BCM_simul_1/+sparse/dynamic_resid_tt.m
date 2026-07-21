function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 27
    T = [T; NaN(27 - size(T, 1), 1)];
end
T(1) = y(32)/y(3)-1;
T(2) = 1-params(17)/2*T(1)^2;
T(3) = (params(19)-1)/params(19);
T(4) = params(5)*y(34)^params(4);
T(5) = y(74)/y(45);
T(6) = (1-params(12))*y(72)*y(65)/y(74)+1-y(73);
T(7) = (y(4)*y(43))^params(1);
T(8) = y(34)^(1-params(1));
T(9) = y(11)^params(14);
T(10) = y(34)^(-params(1));
T(11) = (y(4)*y(43))^(params(1)-1);
T(12) = y(37)*params(1)*T(11);
T(13) = 0.2*(1-params(15))^2;
T(14) = (1-params(15))^3*0.15;
T(15) = (1-params(15))^4*0.1;
T(16) = (1-params(15))^5*0.075;
T(17) = 0.075*(1-params(15))^6;
T(18) = (1-params(15))^7*0.05;
T(19) = 0.05*(1-params(15))^8;
T(20) = 0.05*(1-params(15))^9;
T(21) = 0.05*(1-params(15))^10;
T(22) = 1/y(30);
T(23) = params(17)*y(74)*params(2)*1/y(59)*y(75);
T(24) = (y(61)/y(32))^2;
T(25) = y(61)/y(32)-1;
T(26) = T(2)^y(46);
T(27) = T(2)-T(1)*params(17)*y(32)/y(3);
end
