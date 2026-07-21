% Main file for RBC version of BCM, 4 shocks 

clear 
clc

% Before running - change folder path below - needed for section 4
new_file_path = fullfile(pwd, "UK_data_hp.mat");

%% 1. Parameters

par.beta    = 0.989;       % Discount factor
par.deltaP  = 0.022;       % Private capital depreciation rate
par.deltaG = 0.017; 
par.epsilon = 11; 
par.s_ig = 0.035;   
par.tauC = 0.1576; 
par.tauK = 0.2307; 
par.tauN = 0.2197; 
par.gamma = 0.7651; 

%estimated
par.eta = 0.3375;          % Double check this - use value from literature?
par.alpha= 0.3397;         % CD param on Kp
par.kappa = 11.24;  
par.thetaG = 0.05;  

par.rhoG = 0.9; 
par.rhoA = 0.9;        
par.sigA = 0.01;        
par.rhoX = 0.9; 
par.rhoZ = 0.9; 
par.rhoIgs = 0.9; 

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


%par from those normalisations
par.phi = ((1-par.tauK)*ss.Rk)/(ss.Q*par.deltaP); 
par.nu = (par.gamma*ss.W*(1-par.tauN))/((1+par.tauC)*ss.C*ss.N^par.eta);

%% 3. Load UK data  
% Load UK data on Y, Gc, I, Igs, C

load(new_file_path); 

%% Update these 
thetaG_prior_mean = 0.05; 
thetaG_prior_sd = 0.035; 
%%
dynare BCM_4shocks_final_est.mod noclearall 

%% 
% Simple table 
% Need to manually update the dist if relevant
% Need to manually update the sheet name! 

% Names of estimated parameters
param_names = fieldnames(oo_.posterior_mean.parameters);
shock_names = fieldnames(oo_.posterior_mean.shocks_std);

param_names =[param_names;shock_names]

% Preallocate arrays
n = numel(param_names);
PriorMean = zeros(n,1);
PriorStd  = zeros(n,1);
PostMean  = zeros(n,1);
PostStd   = zeros(n,1);
Post5     = zeros(n,1);
Post95    = zeros(n,1);
Dist      = strings(n,1);
PostMode  = zeros(n,1);
PostModeStd = zeros(n,1);


for i = 1:8
    pname = param_names{i};
    PriorMean(i) = oo_.prior.mean(i+4);
    PriorStd(i)  = sqrt(oo_.prior.variance(i+4,i+4));
    
    PostMean(i) = oo_.posterior_mean.parameters.(pname);
    PostStd(i)  = oo_.posterior_std.parameters.(pname);
    Post5(i)    = oo_.posterior_hpdinf.parameters.(pname);  % 5th percentile
    Post95(i)   = oo_.posterior_hpdsup.parameters.(pname);  % 95th percentile
    PostMode(i) = oo_.posterior_mode.parameters.(pname);    PostMode(i) = oo_.posterior_mean.parameters.(pname);
    PostModeStd(i) = oo_.posterior_std_at_mode.parameters.(pname);

end

for i=9:n
    pname = param_names{i};
    PriorMean(i) = oo_.prior.mean(i-8);
    PriorStd(i)  = sqrt(oo_.prior.variance(i-8,i-8));

    PostMean(i) = oo_.posterior_mean.shocks_std.(pname);
    PostStd(i)  = oo_.posterior_std.shocks_std.(pname);
    Post5(i)    = oo_.posterior_hpdinf.shocks_std.(pname);  % 5th percentile
    Post95(i)   = oo_.posterior_hpdsup.shocks_std.(pname);  % 95th percentile
    PostMode(i) = oo_.posterior_mode.shocks_std.(pname);   
    PostModeStd(i) = oo_.posterior_std_at_mode.shocks_std.(pname);

end 

%Manually update dist 
% Peristence
for i = 1:4
    Dist(i) = 'Beta';
end 
%params
Dist(5) = 'Normal'; % eta 
Dist(6) = 'Gamma'; % thetaG
Dist(7) = 'Normal'; % kappa 
Dist(8) = 'Beta'; % alpha

% shocks
for i = 9:12
 Dist(i) = 'Inv. Gamma';
end 

% Combine into table
T = table(param_names, Dist, PriorMean, PriorStd, PostMean, PostStd, Post5, Post95, PostMode, PostModeStd, ...
          'VariableNames', {'Parameter','Distribution','PriorMean','PriorStd','PostMean','PostStd','Post5','Post95', ...
          'PostMode', 'PostModeStd'});

% Display
disp(T);

%writetable(T, 'Estimation_results_hp.xlsx', 'Sheet', 'Gamma_0.05_0.04_alphatighter');

