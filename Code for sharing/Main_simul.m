% Main file for BCM Working Paper simulations, 4 shocks 

clear 
clc

%% 1. Parameters - as in BCM WP and using estimation results 

par.beta    = 0.989;       
par.deltaP  = 0.022;       
par.epsilon = 11; 
par.s_ig = 0.035;   
par.tauC = 0.1576; 
par.tauK = 0.2307; 
par.tauN = 0.2197; 
par.gamma = 0.7651; 
par.deltaG = 0.017; 


% posterior means 
par.eta = 0.3202;          
par.alpha= 0.2649;         
par.kappa = 6.886;  
par.thetaG = 0.1118;  

par.rhoG = 0.9998; 
par.rhoA = 0.9501;               
par.rhoX = 0.9994; 
par.rhoIgs = 0.9993; 

par.markup = ((par.epsilon-1)/par.epsilon);

%% 2. Analytical steady states 
ss.A = 1; 
ss.G = 1;
ss.Igshock = 1;
ss.X = 1; 
ss.zeta = 1; 

%normalisations
ss.Uk = 1; 
ss.N = 1; 

%remaining steady states
ss.deltaEff = par.deltaP; 
ss.Q = 1; 
ss.Rk = (ss.Q*(1 - par.beta*(1-par.deltaP)))/(par.beta*(1-par.tauK));
ss.Kp = (ss.Rk/par.alpha*par.markup)^((1-par.thetaG)/(par.alpha-1+par.thetaG))*...
    (par.s_ig/par.deltaG)^(-par.thetaG/(par.alpha-1+par.thetaG));
ss.Y = (ss.Kp^par.alpha*(par.s_ig/par.deltaG)^par.thetaG)^(1/(1-par.thetaG));
ss.Kg = (par.s_ig/par.deltaG)*ss.Y; 
ss.Ip = par.deltaP*ss.Kp;
ss.Ig = par.s_ig*ss.Y; 
ss.C = par.gamma*(ss.Y - ss.Ig - ss.Ip);
ss.Gc = (1-par.gamma)/par.gamma*ss.C;

ss.W = (1-par.alpha)*ss.Y*par.markup; 
ss.TR = par.tauC*ss.C + par.tauN*ss.W + par.tauK*ss.Rk*ss.Kp - ss.Ig - ss.Gc;
ss.Profits = ss.Y - ss.W*ss.N - ss.Rk*ss.Kp; 


%par from ss normalisations
par.phi = ((1-par.tauK)*ss.Rk)/(ss.Q*par.deltaP); 
par.nu = (par.gamma*ss.W*(1-par.tauN))/((1+par.tauC)*ss.C*ss.N^par.eta);

%% Ex: shock to productivity 
par.sigA = 0.01; 

%% Save inputs for dynare file
save steadystates ss
save par par 

%% dynare simulation file  
dynare BCM_simul_1.mod noclearall 

