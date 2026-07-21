function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = BCM_simul_1.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(29, 1);
    residual(1) = (y(23)*(1-params(11))) - (T(4)*y(18)*(1+params(10))/params(13));
    residual(2) = (1/params(2)*y(47)/y(18)) - (T(5)*T(6));
    residual(3) = (y(21)) - ((1-y(32))*y(2)+y(20)*T(26));
    residual(4) = (y(19)) - (y(25)*T(7)*T(8)*T(9));
    residual(5) = (y(23)) - (T(3)*T(9)*T(7)*y(25)*(1-params(1))*T(10));
    residual(6) = (y(24)) - (T(3)*T(9)*T(8)*T(12));
    residual(7) = (y(19)) - (y(20)+y(18)+y(27)+y(26));
    residual(8) = (log(y(25))) - (params(6)*log(y(3))+x(it_, 1));
    residual(9) = (y(26)) - (y(18)*(1-params(13))/params(13)*y(29));
    residual(10) = (y(27)) - (y(19)*params(8)*y(36));
    residual(11) = (y(28)) - (y(5)*(1-params(15))+(1-params(15))*0.2*y(4)+T(13)*y(9)+T(14)*y(10)+T(15)*y(11)+T(16)*y(12)+T(17)*y(13)+T(18)*y(14)+T(19)*y(15)+T(20)*y(16)+T(21)*y(17));
    residual(12) = (log(y(29))) - (params(9)*log(y(6))+x(it_, 2));
    residual(13) = (y(27)+y(26)+y(30)) - (y(18)*params(10)+y(23)*params(11)*y(22)+y(31)*y(21)*params(12)*y(24));
    residual(14) = ((1-params(12))*y(24)) - (params(16)*params(3)*y(31)^(params(16)-1));
    residual(15) = (y(32)) - (params(3)*y(31)^params(16));
    residual(16) = (T(22)) - (T(23)*T(24)*T(25)+y(34)*y(33)*T(22)*T(27));
    residual(17) = (log(y(34))) - (params(18)*log(y(7))+x(it_, 3));
    residual(18) = (y(35)) - (y(19)-y(23)*y(22)-y(21)*y(31)*y(24));
    residual(19) = (log(y(36))) - (params(20)*log(y(8))+x(it_, 4));
    residual(20) = (y(37)) - (params(13)*log(y(18))+(1-params(13))*log(y(26))-params(5)*y(22)^(1+params(4))/(1+params(4)));
    residual(21) = (y(38)) - (y(4));
    residual(22) = (y(39)) - (y(9));
    residual(23) = (y(40)) - (y(10));
    residual(24) = (y(41)) - (y(11));
    residual(25) = (y(42)) - (y(12));
    residual(26) = (y(43)) - (y(13));
    residual(27) = (y(44)) - (y(14));
    residual(28) = (y(45)) - (y(15));
    residual(29) = (y(46)) - (y(16));

end
