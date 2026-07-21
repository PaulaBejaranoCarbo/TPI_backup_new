%prep UK data 

% 1. load data 

startQuarter = '1971 Q1';
endQuarter   = '2017 Q4';

% startQuarter = '1975 Q3';
% endQuarter   = '2007 Q3';

%% Real GDP 
% real gdp- ONS ABMI (cvm, SA)  

real_gdp_url = 'https://www.ons.gov.uk/generator?format=csv&uri=/economy/grossdomesticproductgdp/timeseries/abmi/ukea'; 
real_gdp_file = 'real_gdp.csv';
websave(real_gdp_file, real_gdp_url); 
real_gdp = readtable(real_gdp_file); 
delete(real_gdp_file); 

dateStrings = real_gdp{:,1};
startIdx = find(strcmp(dateStrings, startQuarter));
endIdx   = find(strcmp(dateStrings, endQuarter));
real_gdp = real_gdp(startIdx:endIdx, :);

Y = table2array(real_gdp(:,"GrossDomesticProduct_ChainedVolumeMeasures_SeasonallyAdjusted_m"));


%% Government consumption - ONS NMRY 
% CVM, SA


real_GC_url = 'https://www.ons.gov.uk/generator?format=csv&uri=/economy/grossdomesticproductgdp/timeseries/nmry/pn2'; 
real_GC_file = 'real_gc.csv';
websave(real_GC_file, real_GC_url); 
real_GC = readtable(real_GC_file); 
delete(real_GC_file); 

dateStrings = real_GC{:,1};
startIdx = find(strcmp(dateStrings, startQuarter));
endIdx   = find(strcmp(dateStrings, endQuarter));
real_GC = real_GC(startIdx:endIdx, :);

GC = table2array(real_GC(:,"GeneralGovernment_FinalConsumptionExpenditure_P3_CVMSA_m"));

GCY = GC./Y; 

%% Gov investment 
% ratio over real gdp 

% Net investment - ONS JW2Z

net_inv_url = 'https://www.ons.gov.uk/generator?format=csv&uri=/economy/governmentpublicsectorandtaxes/publicsectorfinance/timeseries/jw2z/pusf'; 
net_inv_file = 'net_inv.csv'; 
websave(net_inv_file, net_inv_url); 
net_inv = readtable(net_inv_file); 
delete(net_inv_file); 


dateStrings = net_inv{:,1};
startIdx = find(strcmp(dateStrings, startQuarter));
endIdx   = find(strcmp(dateStrings, endQuarter));
net_inv = net_inv(startIdx:endIdx, :);

net_inv = table2array(net_inv(:,"PS_NetInvestment_excludingPublicSectorBanks___m_CPNSA"));
net_inv = -net_inv; 

%Public capital depreciation - ONS JW2S 
public_dep_url = 'https://www.ons.gov.uk/generator?format=csv&uri=/economy/governmentpublicsectorandtaxes/publicsectorfinance/timeseries/jw2s/pusf'; 
public_dep_file = 'public_dep.csv'; 
websave(public_dep_file, public_dep_url); 
public_dep = readtable(public_dep_file); 
delete(public_dep_file); 


dateStrings = public_dep{:,1};
startIdx = find(strcmp(dateStrings, startQuarter));
endIdx   = find(strcmp(dateStrings, endQuarter));
public_dep = public_dep(startIdx:endIdx, :);

public_dep = table2array(public_dep(:,"PS_ExcPSBanks_Depreciation_ConsumptionOfFixedCapital__mCPNSA"));

%Gross_Ig

gross_IG = net_inv + public_dep; 

freq=4; 
IGY = gross_IG./Y;
[IGY_adj, seasonal, trend] = classical_seasadj(IGY,freq,'Method','multiplicative');




%% Business investment - NPEL (UKIB) 
% CVM


real_IB_file= 'UKIB.xlsx';
real_IB = readtable(real_IB_file); 

dateStrings = real_IB{:,1};
startQuarter = '1971Q1';
endQuarter   = '2017Q4';
startIdx = find(strcmp(dateStrings, startQuarter));
endIdx   = find(strcmp(dateStrings, endQuarter));
real_IB = real_IB(startIdx:endIdx, :);

IB = table2array(real_IB(:,"UKIB"));




%% Create one data structure 

data=zeros(size(Y,1),4); 
data(:,1) = Y; 
data(:,2) = IB;
data(:,3) = GCY;
data(:,4) = IGY_adj; 


% take logs
logdata = log(data);

% HP filter
[hptrend,hpcycle] = hpfilter(logdata); 

hp_y = hpcycle(:,1); 
hp_i = hpcycle(:,2); 
hp_gcy = hpcycle(:,3);
hp_igy = hpcycle(:,4); 

save('UK_data_hp.mat', 'hp_igy', 'hp_y', 'hp_i', 'hp_gcy');


%hamilton filter 
[htrend,hcycle] = hfilter(logdata); 
h_y = hcycle(:,1); 
h_i = hcycle(:,2); 
h_gcy = hcycle(:,3);
h_igy = hcycle(:,4); 


save('UK_data_h.mat', 'h_igy', 'h_y', 'h_i', 'h_gcy');

