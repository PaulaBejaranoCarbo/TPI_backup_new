function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = BCM_simul_1.sparse.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 22
    T = [T; NaN(22 - size(T, 1), 1)];
end
T(19) = getPowerDeriv(y(14)*y(4),params(1),1);
T(20) = getPowerDeriv(y(14)*y(4),params(1)-1,1);
T(21) = getPowerDeriv(y(5),1-params(1),1);
T(22) = getPowerDeriv(y(11),params(14),1);
end
