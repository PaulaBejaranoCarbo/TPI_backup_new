% BK model with endogenous fiscal block as in BCM, variable capital
% utilisation, investment adjustment cost, investment shock (X) 
% and time-to-build lags on public investment 

% Utility is log-CRRA

var
C  // Consumption
Y  // Output
Ip // Private investment
Kp // Private capital
N  // Labour supply
W  // Real wage 
Rk // Rental rate of private capital 
A  // Productivity

Gc // Goverment consumption spending 
Ig // Government investment 
Kg // public capital 
G // gov purchases shock 
TR // transfer 

Uk // variable capital utilisation 
deltaEff // effective depreciation rate 

Q // tobin's Q (
X // Marginal efficiency of investment

Profits
Igshock

hp_y
hp_i
%hp_gc
%hp_ig 
hp_gcy
hp_igy
; 

varexo
epsA  // Productivity shock 
epsG // gov pruchases shock 
epsX // shock to marginal efficiency of investment 
epsIgs // Ig shock
;

parameters 
alpha bbeta deltaP eta nu rhoA sigA 
s_ig rhoG tauC tauN tauK gamma 
thetaK thetaG thetaN deltaG
phi 
kappa rhoX 
epsilon
rhoZ rhoIgs

Css Yss Ipss Kpss Nss Wss Rkss Ass
Gcss Igss Kgss TRss Gss
deltaEffss Ukss
Xss Qss 
;

load params 
load steadystates
set_param_value('alpha'     ,par.alpha);   // returns to scale parameter
set_param_value('bbeta'      ,par.beta);    // discount factor
set_param_value('deltaP'     ,par.deltap);   // depreciation rate
set_param_value('rhoA'      ,par.rhoA);    // autocorrelation of productivity shock
set_param_value('sigA'      ,par.sigA);    // standard deviation of productivity shock
set_param_value('eta'      ,par.eta);     // Inv Frisch elasticity 
set_param_value('nu'        ,par.nu);      // labor disutility

set_param_value('thetaK'     ,par.thetaK);   // Cobb-Douglas param on priv capital 
set_param_value('thetaG'     ,par.thetaG);   // "" public capital
set_param_value('thetaN'     ,par.thetaN);   // "" labour
set_param_value('deltaG'     ,par.deltaG);   // dep rate on public capital 

set_param_value('s_ig'        ,par.s_ig);      // output share of Ig 
set_param_value('rhoG'      ,par.rhoG);    // autocorrelation of G shock
set_param_value('tauC'      ,par.tauC);    // C tax 
set_param_value('tauN'      ,par.tauN);    // N tax 
set_param_value('tauK'      ,par.tauK);    // K tax 
set_param_value('gamma'      ,par.gamma);    // priv consumption share 

set_param_value('phi'      ,par.phi);    //  Delta_eff parameter 

set_param_value('kappa'      ,par.kappa);    //  Inv adj cost  
set_param_value('rhoX'      ,par.rhoX);    // autocorrelation of X shock

set_param_value('epsilon'      ,par.epsilon);    // autocorrelation of X shock
set_param_value('rhoIgs'      ,par.rhoIgs);    // autocorrelation of X shock


set_param_value('Css', ss.C); 
set_param_value('Yss', ss.Y);
set_param_value('Ipss', ss.Ip); 
set_param_value('Kpss', ss.Kp); 
set_param_value('Nss', ss.N);
set_param_value('Wss', ss.W);
set_param_value('Rkss', ss.Rk); 
set_param_value('Ass', ss.A); 

set_param_value('Gcss', ss.Gc); 
set_param_value('Igss', ss.Ig); 
set_param_value('Kgss', ss.Kg); 
set_param_value('TRss', ss.TR); 
set_param_value('Gss', ss.G); 

set_param_value('deltaEffss', ss.deltaEff); 
set_param_value('Ukss', ss.Uk); 

set_param_value('Xss', ss.X);
set_param_value('Qss', ss.Q);


 
model;
#omega = 1-(kappa/2)*(Ip/Ip(-1) -1)^2;
#markup = ((epsilon-1)/epsilon); 

% 1. Labour-leisure 
W*(1-tauN) = (nu*N^(eta)*C*(1+tauC))/gamma;

% 2. Euler equation for capital 
(1/bbeta)*(C(+1)/C) = (Q(+1)/Q)*( ((1-tauK)*Uk(+1)*Rk(+1))/Q(+1) + (1-deltaEff(+1))); 

% 3. LOM capital
Kp = (1-deltaEff)*Kp(-1) + Ip; 

% 4. Production function 
Y = A*(Uk*Kp(-1))^(alpha)*N^(1-alpha)*Kg(-1)^thetaG; 

% 5. Firm FOC 1
W = (1-alpha)*A*(Uk*Kp(-1))^(alpha)*N^(-alpha)*Kg(-1)^thetaG*(markup);

% 6. Firm FOC 2 
Rk = alpha*A*(Uk*Kp(-1))^(alpha-1)*N^(1-alpha)*Kg(-1)^thetaG*(markup);

% 7. Resource constraint
Y = C + Ip + Ig + Gc; 

% 8. Process for A 
log(A) = rhoA*log(A(-1)) + epsA; 

% 9. Process for Gc
Gc = ((1-gamma)/gamma)*C*G;  

% 10. Process for Ig 
Ig = s_ig*Y*Igshock; 

% 11. LOM Kg 
%Kg = (1-deltaG)*Kg(-1) + Ig; 

Kg = (1-deltaG)*Kg(-1) + (1-deltaG)*0.2*Ig(-1)+ (1-deltaG)^2*0.2*Ig(-2) +(1-deltaG)^3*0.15*Ig(-3) +(1-deltaG)^4*0.1*Ig(-4) + (1-deltaG)^5*0.075*Ig(-5) + (1-deltaG)^6*0.075*Ig(-6)  + (1-deltaG)^7*0.05*Ig(-7) + (1-deltaG)^8*0.05*Ig(-8) + (1-deltaG)^9*0.05*Ig(-9) + (1-deltaG)^10*0.05*Ig(-10);

% 12. Process for G ; 
log(G) = rhoG*log(G(-1)) + epsG; 

% 13. Gov BC  
Ig + Gc + TR = tauC*C + tauN*N*W + tauK*Rk*Kp*Uk;  

% 14. Uk FOC
(1-tauK)*Rk = phi*deltaP*Uk^(phi-1); 

% 15. deltaEff definition
deltaEff = deltaP*Uk^phi; 

% 16. Ip FOC
1/C = (1/C)*Q*X*(omega - kappa*(Ip/Ip(-1))*((Ip/Ip(-1)) -1)) + bbeta*(1/C(+1))*Q(+1)*X(+1)*kappa*(Ip(+1)/Ip)^2*(Ip(+1)/Ip -1);

% 17. Process for X 
log(X) = rhoX*log(X(-1)) + epsX; 

%18.  Profits 
Profits = Y - W*N - Rk*Uk*Kp;

%19. Process for Igshock 
log(Igshock) = rhoIgs*log(Igshock(-1)) + epsIgs; 

hp_y = log(Y);
hp_i = log(Ip);
%hp_gc = log(Gc);
%hp_ig = log(Ig); 
hp_gcy = log(Gc);
hp_igy = log(Ig);
end
; 

initval; 
C = Css; 
Y = Yss; 
Ip = Ipss; 
Kp = Kpss;
N = Nss;
W = Wss;
Rk = Rkss;
A = Ass; 

Gc = Gcss;  
Ig = Igss;  
Kg = Kgss;  
G = Gss; 
TR = TRss; 

Uk = Ukss; 
deltaEff=deltaEffss;

Q = Qss; 
X = Xss;

Profits = Yss - Wss*Nss - Rkss*Kpss; 
Igshock =1;

end;

shocks;
var epsA; stderr sigA;
end;


steady; 
check; 
stoch_simul(order=1, nomoments, irf=100, periods = 5000); 

%______________________%
% Parameter Estimation %
%‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾%
estimated_params;

% Persistence priors % 
rhoA, beta_pdf, 0.5, 0.2;
rhoX, beta_pdf, 0.5, 0.2;
rhoG, beta_pdf, 0.5, 0.2;
rhoIgs, beta_pdf, 0.5, 0.2;

%%% Shock Priors %%%
%%%%%%%%%%%%%%%%%%%%
stderr epsA, inv_gamma_pdf, 0.01, 0.2;
stderr epsX, inv_gamma_pdf, 0.01, 0.2;
stderr epsG, inv_gamma_pdf, 0.01, 0.2;
stderr epsIgs, inv_gamma_pdf, 0.01, 0.2;

%%% Parameter Priors %%%
%%%%%%%%%%%%%%%%%%%%%%%%
%eta, normal_pdf, 0.3367, 0.030;
%thetaG,  inv_gamma_pdf, 0.05, 0.01;
%kappa, normal_pdf, 4, 1.5;
%alpha,  inv_gamma_pdf, 0.339, 0.016;

eta, normal_pdf, 2, 0.75; // SW
thetaG,  beta_pdf, 0.05, 0.01;
kappa, normal_pdf, 4, 1.5; // SW
alpha,  beta_pdf, 0.3, 0.05; // SW 

end; 

%_______________________%
% Observation Variables %
%‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾%
varobs hp_y, hp_i, hp_gcy, hp_igy;
estimation(datafile=UK_data_real, mode_compute=6, mh_replic=25000, mh_nblocks=2, mh_jscale=10, mh_drop=0.2, mode_check) Y Ip Gc Ig;
