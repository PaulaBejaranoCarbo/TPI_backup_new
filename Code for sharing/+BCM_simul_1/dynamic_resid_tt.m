function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 27);

T(1) = y(20)/y(1)-1;
T(2) = 1-params(17)/2*T(1)^2;
T(3) = (params(19)-1)/params(19);
T(4) = params(5)*y(22)^params(4);
T(5) = y(52)/y(33);
T(6) = (1-params(12))*y(50)*y(49)/y(52)+1-y(51);
T(7) = (y(2)*y(31))^params(1);
T(8) = y(22)^(1-params(1));
T(9) = y(5)^params(14);
T(10) = y(22)^(-params(1));
T(11) = (y(2)*y(31))^(params(1)-1);
T(12) = y(25)*params(1)*T(11);
T(13) = 0.2*(1-params(15))^2;
T(14) = (1-params(15))^3*0.15;
T(15) = (1-params(15))^4*0.1;
T(16) = (1-params(15))^5*0.075;
T(17) = 0.075*(1-params(15))^6;
T(18) = (1-params(15))^7*0.05;
T(19) = 0.05*(1-params(15))^8;
T(20) = 0.05*(1-params(15))^9;
T(21) = 0.05*(1-params(15))^10;
T(22) = 1/y(18);
T(23) = params(17)*y(52)*params(2)*1/y(47)*y(53);
T(24) = (y(48)/y(20))^2;
T(25) = y(48)/y(20)-1;
T(26) = T(2)^y(34);
T(27) = T(2)-T(1)*params(17)*y(20)/y(1);

end
