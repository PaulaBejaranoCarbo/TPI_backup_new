function [y_adj, seasonal, trend] = classical_seasadj(y, freq, varargin)
% CLASSICAL_SEASADJ  Classical seasonal adjustment (additive)
% Usage:
%   [y_adj, seasonal, trend] = classical_seasadj(y, freq)
% Inputs:
%   y    - T-by-1 vector (numeric), NaNs allowed at ends (but not many gaps)
%   freq - seasonal frequency: 12 for monthly, 4 for quarterly, etc.
% Optional name-value:
%   'Method' - 'additive' (default) or 'multiplicative'
%   'TrendWindow' - integer (default = freq or 2*freq if freq even)
%
% Outputs:
%   y_adj   - deseasonalised series (same size as y)
%   seasonal- seasonal index for each seasonal position (freq x 1)
%   trend   - trend estimate (same size as y, NaN at edges where undefined)

% Parse inputs
p = inputParser;
addRequired(p,'y',@(x)isnumeric(x) && isvector(x));
addRequired(p,'freq',@(x)isscalar(x) && x>=2);
addParameter(p,'Method','additive',@(s)ischar(s) || isstring(s));
addParameter(p,'TrendWindow',[],@(x)isempty(x)|| (isscalar(x)&&x>=2));
parse(p,y,freq,varargin{:});
y = p.Results.y(:);
freq = p.Results.freq;
method = char(p.Results.Method);
trendWindow = p.Results.TrendWindow;

T = length(y);
if isempty(trendWindow)
    % if freq even, use 2*freq moving average for centered MA; else freq
    if mod(freq,2)==0
        trendWindow = 2*freq;
    else
        trendWindow = freq;
    end
end

% Compute centered moving average (trend). Use NaN where not defined.
trend = movmean(y, trendWindow, 'Endpoints','fill'); 
% movmean with 'Endpoints','fill' will give shorter-window means at edges;
% we prefer NaN at edges to match classical approach:
half = floor(trendWindow/2);
trend(1:half) = NaN;
trend(end-half+1:end) = NaN;

% Detrend
switch lower(method)
    case 'additive'
        detrended = y - trend;
    case 'multiplicative'
        detrended = y ./ trend;
    otherwise
        error('Unknown Method. Use ''additive'' or ''multiplicative''.');
end

% Compute seasonal indices by averaging detrended values for each seasonal position
seasonal = NaN(freq,1);
counts = zeros(freq,1);
for i=1:T
    s = mod(i-1,freq)+1; % seasonal position
    if ~isnan(detrended(i))
        if isnan(seasonal(s))
            seasonal(s) = detrended(i);
        else
            seasonal(s) = seasonal(s) + detrended(i);
        end
        counts(s) = counts(s) + 1;
    end
end
seasonal = seasonal ./ counts;

% For additive, demean the seasonal indices so they sum to zero (so trend+season = original mean)
if strcmpi(method,'additive')
    seasonal = seasonal - mean(seasonal,'omitnan');
else
    % multiplicative: scale so mean is 1
    seasonal = seasonal / mean(seasonal,'omitnan');
end

% Build seasonal vector of same length as y
seasonal_full = NaN(T,1);
for i=1:T
    seasonal_full(i) = seasonal(mod(i-1,freq)+1);
end

% Deseasonalise
switch lower(method)
    case 'additive'
        y_adj = y - seasonal_full;
    case 'multiplicative'
        y_adj = y ./ seasonal_full;
end

end
