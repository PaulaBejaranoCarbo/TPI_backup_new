function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = BCM_simul_1.static_g1_tt(T, y, x, params);
end
g1 = zeros(29, 29);
g1(1,1)=(-(T(2)*(1+params(10))/params(13)));
g1(1,5)=(-((1+params(10))*y(1)*params(5)*getPowerDeriv(y(5),params(4),1)/params(13)));
g1(1,6)=1-params(11);
g1(2,7)=(-((1-params(12))*y(14)/y(16)));
g1(2,14)=(-((1-params(12))*y(7)/y(16)));
g1(2,15)=1;
g1(2,16)=(-((-((1-params(12))*y(14)*y(7)))/(y(16)*y(16))));
g1(3,3)=(-1);
g1(3,4)=1-(1-y(15));
g1(3,15)=y(4);
g1(4,2)=1;
g1(4,4)=(-(T(5)*T(4)*y(8)*y(14)*T(19)));
g1(4,5)=(-(T(5)*y(8)*T(3)*T(21)));
g1(4,8)=(-(T(5)*T(3)*T(4)));
g1(4,11)=(-(y(8)*T(3)*T(4)*T(22)));
g1(4,14)=(-(T(5)*T(4)*y(8)*y(4)*T(19)));
g1(5,4)=(-(T(1)*T(5)*T(6)*y(8)*(1-params(1))*y(14)*T(19)));
g1(5,5)=(-(T(1)*T(5)*T(3)*y(8)*(1-params(1))*getPowerDeriv(y(5),(-params(1)),1)));
g1(5,6)=1;
g1(5,8)=(-(T(1)*T(5)*T(6)*T(3)*(1-params(1))));
g1(5,11)=(-(T(1)*T(3)*y(8)*(1-params(1))*T(6)*T(22)));
g1(5,14)=(-(T(1)*T(5)*T(6)*y(8)*(1-params(1))*y(4)*T(19)));
g1(6,4)=(-(T(1)*T(5)*T(4)*y(8)*params(1)*y(14)*T(20)));
g1(6,5)=(-(T(1)*T(5)*T(8)*T(21)));
g1(6,7)=1;
g1(6,8)=(-(T(1)*T(5)*T(4)*params(1)*T(7)));
g1(6,11)=(-(T(1)*T(4)*T(8)*T(22)));
g1(6,14)=(-(T(1)*T(5)*T(4)*y(8)*params(1)*y(4)*T(20)));
g1(7,1)=(-1);
g1(7,2)=1;
g1(7,3)=(-1);
g1(7,9)=(-1);
g1(7,10)=(-1);
g1(8,8)=1/y(8)-params(6)*1/y(8);
g1(9,1)=(-((1-params(13))/params(13)*y(12)));
g1(9,9)=1;
g1(9,12)=(-(y(1)*(1-params(13))/params(13)));
g1(10,2)=(-(params(8)*y(19)));
g1(10,10)=1;
g1(10,19)=(-(y(2)*params(8)));
g1(11,10)=(-((1-params(15))*0.2));
g1(11,11)=1-(1-params(15));
g1(11,21)=(-T(9));
g1(11,22)=(-T(10));
g1(11,23)=(-T(11));
g1(11,24)=(-T(12));
g1(11,25)=(-T(13));
g1(11,26)=(-T(14));
g1(11,27)=(-T(15));
g1(11,28)=(-T(16));
g1(11,29)=(-T(17));
g1(12,12)=1/y(12)-params(9)*1/y(12);
g1(13,1)=(-params(10));
g1(13,4)=(-(y(14)*params(12)*y(7)));
g1(13,5)=(-(y(6)*params(11)));
g1(13,6)=(-(params(11)*y(5)));
g1(13,7)=(-(y(14)*params(12)*y(4)));
g1(13,9)=1;
g1(13,10)=1;
g1(13,13)=1;
g1(13,14)=(-(y(4)*params(12)*y(7)));
g1(14,7)=1-params(12);
g1(14,14)=(-(params(16)*params(3)*getPowerDeriv(y(14),params(16)-1,1)));
g1(15,14)=(-(params(3)*getPowerDeriv(y(14),params(16),1)));
g1(15,15)=1;
g1(16,1)=(-1)/(y(1)*y(1))-y(17)*y(16)*(-1)/(y(1)*y(1));
g1(16,16)=(-(y(17)*T(18)));
g1(16,17)=(-(y(16)*T(18)));
g1(17,17)=1/y(17)-params(18)*1/y(17);
g1(18,2)=(-1);
g1(18,4)=y(14)*y(7);
g1(18,5)=y(6);
g1(18,6)=y(5);
g1(18,7)=y(14)*y(4);
g1(18,14)=y(7)*y(4);
g1(18,18)=1;
g1(19,19)=1/y(19)-params(20)*1/y(19);
g1(20,1)=(-(params(13)*T(18)));
g1(20,5)=params(5)*getPowerDeriv(y(5),1+params(4),1)/(1+params(4));
g1(20,9)=(-((1-params(13))*1/y(9)));
g1(20,20)=1;
g1(21,10)=(-1);
g1(21,21)=1;
g1(22,21)=(-1);
g1(22,22)=1;
g1(23,22)=(-1);
g1(23,23)=1;
g1(24,23)=(-1);
g1(24,24)=1;
g1(25,24)=(-1);
g1(25,25)=1;
g1(26,25)=(-1);
g1(26,26)=1;
g1(27,26)=(-1);
g1(27,27)=1;
g1(28,27)=(-1);
g1(28,28)=1;
g1(29,28)=(-1);
g1(29,29)=1;

end
