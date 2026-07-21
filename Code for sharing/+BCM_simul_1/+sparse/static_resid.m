function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(18, 1);
end
[T_order, T] = BCM_simul_1.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(29, 1);
    residual(1) = (y(6)*(1-params(11))) - (T(2)*y(1)*(1+params(10))/params(13));
    residual(2) = (1/params(2)) - ((1-params(12))*y(14)*y(7)/y(16)+1-y(15));
    residual(3) = (y(4)) - (y(3)+(1-y(15))*y(4));
    residual(4) = (y(2)) - (y(8)*T(3)*T(4)*T(5));
    residual(5) = (y(6)) - (T(1)*T(5)*T(3)*y(8)*(1-params(1))*T(6));
    residual(6) = (y(7)) - (T(1)*T(5)*T(4)*T(8));
    residual(7) = (y(2)) - (y(3)+y(1)+y(10)+y(9));
    residual(8) = (log(y(8))) - (log(y(8))*params(6)+x(1));
    residual(9) = (y(9)) - (y(1)*(1-params(13))/params(13)*y(12));
    residual(10) = (y(10)) - (y(2)*params(8)*y(19));
    residual(11) = (y(11)) - (y(11)*(1-params(15))+y(10)*(1-params(15))*0.2+T(9)*y(21)+T(10)*y(22)+T(11)*y(23)+T(12)*y(24)+T(13)*y(25)+T(14)*y(26)+T(15)*y(27)+T(16)*y(28)+T(17)*y(29));
    residual(12) = (log(y(12))) - (log(y(12))*params(9)+x(2));
    residual(13) = (y(10)+y(9)+y(13)) - (y(1)*params(10)+y(6)*params(11)*y(5)+y(14)*y(4)*params(12)*y(7));
    residual(14) = ((1-params(12))*y(7)) - (params(16)*params(3)*y(14)^(params(16)-1));
    residual(15) = (y(15)) - (params(3)*y(14)^params(16));
    residual(16) = (T(18)) - (y(17)*y(16)*T(18));
    residual(17) = (log(y(17))) - (log(y(17))*params(18)+x(3));
    residual(18) = (y(18)) - (y(2)-y(6)*y(5)-y(4)*y(14)*y(7));
    residual(19) = (log(y(19))) - (log(y(19))*params(20)+x(4));
    residual(20) = (y(20)) - (params(13)*log(y(1))+(1-params(13))*log(y(9))-params(5)*y(5)^(1+params(4))/(1+params(4)));
    residual(21) = (y(21)) - (y(10));
    residual(22) = (y(22)) - (y(21));
    residual(23) = (y(23)) - (y(22));
    residual(24) = (y(24)) - (y(23));
    residual(25) = (y(25)) - (y(24));
    residual(26) = (y(26)) - (y(25));
    residual(27) = (y(27)) - (y(26));
    residual(28) = (y(28)) - (y(27));
    residual(29) = (y(29)) - (y(28));
end
