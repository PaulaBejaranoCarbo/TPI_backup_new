function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(27, 1);
end
[T_order, T] = BCM_simul_1.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(29, 1);
    residual(1) = (y(35)*(1-params(11))) - (T(4)*y(30)*(1+params(10))/params(13));
    residual(2) = (1/params(2)*y(59)/y(30)) - (T(5)*T(6));
    residual(3) = (y(33)) - ((1-y(44))*y(4)+y(32)*T(26));
    residual(4) = (y(31)) - (y(37)*T(7)*T(8)*T(9));
    residual(5) = (y(35)) - (T(3)*T(9)*T(7)*y(37)*(1-params(1))*T(10));
    residual(6) = (y(36)) - (T(3)*T(9)*T(8)*T(12));
    residual(7) = (y(31)) - (y(32)+y(30)+y(39)+y(38));
    residual(8) = (log(y(37))) - (params(6)*log(y(8))+x(1));
    residual(9) = (y(38)) - (y(30)*(1-params(13))/params(13)*y(41));
    residual(10) = (y(39)) - (y(31)*params(8)*y(48));
    residual(11) = (y(40)) - (y(11)*(1-params(15))+(1-params(15))*0.2*y(10)+T(13)*y(21)+T(14)*y(22)+T(15)*y(23)+T(16)*y(24)+T(17)*y(25)+T(18)*y(26)+T(19)*y(27)+T(20)*y(28)+T(21)*y(29));
    residual(12) = (log(y(41))) - (params(9)*log(y(12))+x(2));
    residual(13) = (y(39)+y(38)+y(42)) - (y(30)*params(10)+y(35)*params(11)*y(34)+y(43)*y(33)*params(12)*y(36));
    residual(14) = ((1-params(12))*y(36)) - (params(16)*params(3)*y(43)^(params(16)-1));
    residual(15) = (y(44)) - (params(3)*y(43)^params(16));
    residual(16) = (T(22)) - (T(23)*T(24)*T(25)+y(46)*y(45)*T(22)*T(27));
    residual(17) = (log(y(46))) - (params(18)*log(y(17))+x(3));
    residual(18) = (y(47)) - (y(31)-y(35)*y(34)-y(33)*y(43)*y(36));
    residual(19) = (log(y(48))) - (params(20)*log(y(19))+x(4));
    residual(20) = (y(49)) - (params(13)*log(y(30))+(1-params(13))*log(y(38))-params(5)*y(34)^(1+params(4))/(1+params(4)));
    residual(21) = (y(50)) - (y(10));
    residual(22) = (y(51)) - (y(21));
    residual(23) = (y(52)) - (y(22));
    residual(24) = (y(53)) - (y(23));
    residual(25) = (y(54)) - (y(24));
    residual(26) = (y(55)) - (y(25));
    residual(27) = (y(56)) - (y(26));
    residual(28) = (y(57)) - (y(27));
    residual(29) = (y(58)) - (y(28));
end
