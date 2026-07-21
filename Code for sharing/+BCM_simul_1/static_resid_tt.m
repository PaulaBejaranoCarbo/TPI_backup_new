function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 18);

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
