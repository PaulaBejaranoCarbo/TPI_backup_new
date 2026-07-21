function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
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
%   g1
%

if T_flag
    T = BCM_simul_1.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(29, 57);
g1(1,18)=(-(T(4)*(1+params(10))/params(13)));
g1(1,22)=(-((1+params(10))*y(18)*params(5)*getPowerDeriv(y(22),params(4),1)/params(13)));
g1(1,23)=1-params(11);
g1(2,18)=1/params(2)*(-y(47))/(y(18)*y(18));
g1(2,47)=1/params(2)*T(22);
g1(2,49)=(-(T(5)*(1-params(12))*y(50)/y(52)));
g1(2,50)=(-(T(5)*(1-params(12))*y(49)/y(52)));
g1(2,51)=T(5);
g1(2,33)=(-(T(6)*(-y(52))/(y(33)*y(33))));
g1(2,52)=(-(T(6)*1/y(33)+T(5)*(-((1-params(12))*y(50)*y(49)))/(y(52)*y(52))));
g1(3,1)=(-(y(20)*T(28)*T(29)));
g1(3,20)=(-(T(26)+y(20)*T(29)*T(30)));
g1(3,2)=(-(1-y(32)));
g1(3,21)=1;
g1(3,32)=y(2);
g1(3,34)=(-(y(20)*T(26)*log(T(2))));
g1(4,19)=1;
g1(4,2)=(-(T(9)*T(8)*y(25)*y(31)*T(31)));
g1(4,22)=(-(T(9)*y(25)*T(7)*T(33)));
g1(4,25)=(-(T(9)*T(7)*T(8)));
g1(4,5)=(-(y(25)*T(7)*T(8)*T(34)));
g1(4,31)=(-(T(9)*T(8)*y(25)*y(2)*T(31)));
g1(5,2)=(-(T(3)*T(9)*T(10)*y(25)*(1-params(1))*y(31)*T(31)));
g1(5,22)=(-(T(3)*T(9)*T(7)*y(25)*(1-params(1))*getPowerDeriv(y(22),(-params(1)),1)));
g1(5,23)=1;
g1(5,25)=(-(T(3)*T(9)*T(10)*T(7)*(1-params(1))));
g1(5,5)=(-(T(3)*T(7)*y(25)*(1-params(1))*T(10)*T(34)));
g1(5,31)=(-(T(3)*T(9)*T(10)*y(25)*(1-params(1))*y(2)*T(31)));
g1(6,2)=(-(T(3)*T(9)*T(8)*y(25)*params(1)*y(31)*T(32)));
g1(6,22)=(-(T(3)*T(9)*T(12)*T(33)));
g1(6,24)=1;
g1(6,25)=(-(T(3)*T(9)*T(8)*params(1)*T(11)));
g1(6,5)=(-(T(3)*T(8)*T(12)*T(34)));
g1(6,31)=(-(T(3)*T(9)*T(8)*y(25)*params(1)*y(2)*T(32)));
g1(7,18)=(-1);
g1(7,19)=1;
g1(7,20)=(-1);
g1(7,26)=(-1);
g1(7,27)=(-1);
g1(8,3)=(-(params(6)*1/y(3)));
g1(8,25)=1/y(25);
g1(8,54)=(-1);
g1(9,18)=(-((1-params(13))/params(13)*y(29)));
g1(9,26)=1;
g1(9,29)=(-(y(18)*(1-params(13))/params(13)));
g1(10,19)=(-(params(8)*y(36)));
g1(10,27)=1;
g1(10,36)=(-(y(19)*params(8)));
g1(11,4)=(-((1-params(15))*0.2));
g1(11,5)=(-(1-params(15)));
g1(11,28)=1;
g1(11,9)=(-T(13));
g1(11,10)=(-T(14));
g1(11,11)=(-T(15));
g1(11,12)=(-T(16));
g1(11,13)=(-T(17));
g1(11,14)=(-T(18));
g1(11,15)=(-T(19));
g1(11,16)=(-T(20));
g1(11,17)=(-T(21));
g1(12,6)=(-(params(9)*1/y(6)));
g1(12,29)=1/y(29);
g1(12,55)=(-1);
g1(13,18)=(-params(10));
g1(13,21)=(-(y(31)*params(12)*y(24)));
g1(13,22)=(-(y(23)*params(11)));
g1(13,23)=(-(params(11)*y(22)));
g1(13,24)=(-(y(31)*params(12)*y(21)));
g1(13,26)=1;
g1(13,27)=1;
g1(13,30)=1;
g1(13,31)=(-(y(21)*params(12)*y(24)));
g1(14,24)=1-params(12);
g1(14,31)=(-(params(16)*params(3)*getPowerDeriv(y(31),params(16)-1,1)));
g1(15,31)=(-(params(3)*getPowerDeriv(y(31),params(16),1)));
g1(15,32)=1;
g1(16,18)=(-1)/(y(18)*y(18))-T(27)*y(34)*y(33)*(-1)/(y(18)*y(18));
g1(16,47)=(-(T(25)*T(24)*params(17)*y(53)*y(52)*params(2)*(-1)/(y(47)*y(47))));
g1(16,1)=(-(y(34)*y(33)*T(22)*(T(28)-(params(17)*y(20)/y(1)*(-y(20))/(y(1)*y(1))+T(1)*params(17)*(-y(20))/(y(1)*y(1))))));
g1(16,20)=(-(T(25)*T(23)*(-y(48))/(y(20)*y(20))*2*y(48)/y(20)+T(23)*T(24)*(-y(48))/(y(20)*y(20))+y(34)*y(33)*T(22)*(T(30)-(params(17)*y(20)/y(1)*1/y(1)+T(1)*params(17)*1/y(1)))));
g1(16,48)=(-(T(25)*T(23)*2*y(48)/y(20)*1/y(20)+T(23)*T(24)*1/y(20)));
g1(16,33)=(-(T(27)*y(34)*T(22)));
g1(16,52)=(-(T(25)*T(24)*params(17)*params(2)*1/y(47)*y(53)));
g1(16,34)=(-(y(33)*T(22)*T(27)));
g1(16,53)=(-(T(25)*T(24)*params(17)*y(52)*params(2)*1/y(47)));
g1(17,7)=(-(params(18)*1/y(7)));
g1(17,34)=1/y(34);
g1(17,56)=(-1);
g1(18,19)=(-1);
g1(18,21)=y(31)*y(24);
g1(18,22)=y(23);
g1(18,23)=y(22);
g1(18,24)=y(21)*y(31);
g1(18,31)=y(21)*y(24);
g1(18,35)=1;
g1(19,8)=(-(params(20)*1/y(8)));
g1(19,36)=1/y(36);
g1(19,57)=(-1);
g1(20,18)=(-(params(13)*T(22)));
g1(20,22)=params(5)*getPowerDeriv(y(22),1+params(4),1)/(1+params(4));
g1(20,26)=(-((1-params(13))*1/y(26)));
g1(20,37)=1;
g1(21,4)=(-1);
g1(21,38)=1;
g1(22,9)=(-1);
g1(22,39)=1;
g1(23,10)=(-1);
g1(23,40)=1;
g1(24,11)=(-1);
g1(24,41)=1;
g1(25,12)=(-1);
g1(25,42)=1;
g1(26,13)=(-1);
g1(26,43)=1;
g1(27,14)=(-1);
g1(27,44)=1;
g1(28,15)=(-1);
g1(28,45)=1;
g1(29,16)=(-1);
g1(29,46)=1;

end
