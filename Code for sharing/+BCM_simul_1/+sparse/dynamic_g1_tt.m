function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = BCM_simul_1.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 34
    T = [T; NaN(34 - size(T, 1), 1)];
end
T(28) = (-(params(17)/2*(-y(32))/(y(3)*y(3))*2*T(1)));
T(29) = getPowerDeriv(T(2),y(46),1);
T(30) = (-(params(17)/2*2*T(1)*1/y(3)));
T(31) = getPowerDeriv(y(4)*y(43),params(1),1);
T(32) = getPowerDeriv(y(4)*y(43),params(1)-1,1);
T(33) = getPowerDeriv(y(34),1-params(1),1);
T(34) = getPowerDeriv(y(11),params(14),1);
end
