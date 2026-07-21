function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
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

assert(length(T) >= 22);

T = BCM_simul_1.static_resid_tt(T, y, x, params);

T(19) = getPowerDeriv(y(14)*y(4),params(1),1);
T(20) = getPowerDeriv(y(14)*y(4),params(1)-1,1);
T(21) = getPowerDeriv(y(5),1-params(1),1);
T(22) = getPowerDeriv(y(11),params(14),1);

end
