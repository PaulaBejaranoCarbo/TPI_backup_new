function compare_ident_iskrev(calFile, postFile)
% COMPARE_IDENT_ISKREV Compare Iskrev (2010) identification results saved by Dynare.
%
% Usage:
%   compare_ident_iskrev('identification/BCM4_alt_Current_params_identif/BCM4_alt_Current_params_identif.mat', ...
%                        'identification/BCM4_alt_identif.mat');

%% --- Load files ---
if ~exist(calFile,'file')
    error('Calibration file not found: %s', calFile);
end
if ~exist(postFile,'file')
    error('Posterior file not found: %s', postFile);
end

S_cal  = load(calFile);
S_post = load(postFile);

if ~isfield(S_cal,'ide_moments_point') || ~isfield(S_post,'ide_moments_point')
    error('One or both files do not contain ide_moments_point. Make sure these are Dynare identification .mat files.');
end

cal  = S_cal.ide_moments_point;
post = S_post.ide_moments_point;

%% --- Extract Jacobians (dMOMENTS) ---
if ~isfield(cal,'dMOMENTS') || ~isfield(post,'dMOMENTS')
    error('ide_moments_point.dMOMENTS not found in one of the files.');
end
Jcal  = double(cal.dMOMENTS);
Jpost = double(post.dMOMENTS);

%% --- Obtain parameter names (robust) ---
names = get_names_from_store_options(S_cal, S_post, Jcal);

%% --- Print basic sizes and ranks ---
fprintf('\nJacobian sizes:  cal %dx%d   post %dx%d\n', ...
        size(Jcal,1), size(Jcal,2), size(Jpost,1), size(Jpost,2));
fprintf('rank(Jcal)  = %d\n', rank(Jcal));
fprintf('rank(Jpost) = %d\n', rank(Jpost));

%% --- Column norms (sensitivity) ---
colnorm_cal  = vecnorm(Jcal);
colnorm_post = vecnorm(Jpost);

% For listing zero-like columns use tolerance based on calibration colnorms
tol = 1e-8 * max(colnorm_cal(:));
fprintf('\nParameters with nearly zero derivative at calibration (colnorm < %.3g):\n', tol);
nShow = min(numel(names), numel(colnorm_cal));
for i = 1:nShow
    if colnorm_cal(i) <= tol
        fprintf('  %-15s  (%.3g)\n', names{i}, colnorm_cal(i));
    end
end

%% --- Pairwise cosines (collinearity) ---
cosine_cal  = cosine_matrix(Jcal);
cosine_post = cosine_matrix(Jpost);

fprintf('\nTop 5 most collinear parameter pairs at calibration:\n');
print_top_pairs(cosine_cal, names, 5);

fprintf('\nTop 5 most collinear parameter pairs at posterior mode:\n');
print_top_pairs(cosine_post, names, 5);

%% --- Compare growth in column norms (post / prior) ---
% Align lengths safely (use shortest length)
nCols = min([numel(colnorm_cal), numel(colnorm_post), numel(names)]);
colnorm_cal  = colnorm_cal(1:nCols);
colnorm_post = colnorm_post(1:nCols);
names_trim   = names(1:nCols);

% Compute ratio (avoid division by zero)
ratio = colnorm_post ./ max(colnorm_cal, eps);

[rvals, idx] = sort(ratio, 'descend');
fprintf('\nParameters whose influence on moments grew the most (post/prior norm ratio):\n');
for k = 1:min(10, numel(idx))
    i = idx(k);
    fprintf('  %-15s  cal=%.3g  post=%.3g  ratio=%.3g\n', names_trim{i}, colnorm_cal(i), colnorm_post(i), rvals(k));
end

%% --- Weakly identified flags (Dynare jweak) ---
if isfield(cal,'jweak')
    weak_idx_cal = find(cal.jweak==1);
    % trim indices to available names
    weak_idx_cal = weak_idx_cal(weak_idx_cal <= numel(names));
    if ~isempty(weak_idx_cal)
        fprintf('\nWeakly identified at calibration:\n');
        disp(names(weak_idx_cal));
    end
end
if isfield(post,'jweak')
    weak_idx_post = find(post.jweak==1);
    weak_idx_post = weak_idx_post(weak_idx_post <= numel(names));
    if ~isempty(weak_idx_post)
        fprintf('Weakly identified at posterior mode:\n');
        disp(names(weak_idx_post));
    end
end

fprintf('\n');  % final newline
end

%% ---------------- Helper functions ----------------

function names = get_names_from_store_options(S_cal, S_post, Jcal)
% Robust extraction of parameter names from loaded structures
names = {};

% Preferred: store_options_ident.name_tex inside calibration file
if isfield(S_cal,'store_options_ident') && isfield(S_cal.store_options_ident,'name_tex')
    raw = S_cal.store_options_ident.name_tex;
    if iscell(raw), names = raw(:);
    elseif ischar(raw), names = cellstr(raw); end
end

% fallback to post file
if isempty(names) && isfield(S_post,'store_options_ident') && isfield(S_post.store_options_ident,'name_tex')
    raw = S_post.store_options_ident.name_tex;
    if iscell(raw), names = raw(:);
    elseif ischar(raw), names = cellstr(raw); end
end

% fallback to other common fields inside store_options_ident
if isempty(names)
    for S = {S_cal, S_post}
        Sx = S{1};
        if isfield(Sx,'store_options_ident')
            so = Sx.store_options_ident;
            candidates = {'param_names','parameter_names','param_list','names','parameters','name_tex'};
            for i = 1:numel(candidates)
                f = candidates{i};
                if isfield(so,f)
                    val = so.(f);
                    if iscell(val) && all(cellfun(@ischar,val))
                        names = val(:);
                        break;
                    end
                end
            end
        end
        if ~isempty(names), break; end
    end
end

% fallback to M_.param_names in base workspace (if present)
if isempty(names)
    if evalin('base','exist(''M_'',''var'')')
        Mtmp = evalin('base','M_');
        if isfield(Mtmp,'param_names')
            tmp = Mtmp.param_names(:);
            if iscell(tmp) && all(cellfun(@ischar,tmp))
                names = tmp;
            end
        end
    end
end

% final fallback: create generic labels
nCols = size(Jcal,2);
if isempty(names)
    names = arrayfun(@(i) sprintf('p%d',i), 1:nCols, 'uni', 0)';
end

% Clean LaTeX-ish wrappers and stray characters (e.g. '$', '\_', '{', '}', '\')
if iscell(names)
    names = regexprep(names, '^\s*\$\s*', '');    % leading $
    names = regexprep(names, '\s*\$\s*$', '');    % trailing $
    names = regexprep(names, '\\_', '_');         % \_ -> _
    names = regexprep(names, '\\', '');           % remove backslashes
    names = regexprep(names, '[\{\}]', '');       % remove braces
    names = regexprep(names, '\^', '');           % remove caret
    names = strtrim(names);
end

% Ensure correct length: truncate or pad
if numel(names) < nCols
    for k = numel(names)+1:nCols
        names{k} = sprintf('param_%d', k);
    end
elseif numel(names) > nCols
    names = names(1:nCols);
end
names = names(:);
end

function C = cosine_matrix(J)
% compute cosine similarity matrix between columns of J
p = size(J,2);
C = nan(p,p);
for i = 1:p
    ni = norm(J(:,i));
    for j = i:p
        nj = norm(J(:,j));
        if ni > 0 && nj > 0
            C(i,j) = (J(:,i)'*J(:,j)) / (ni * nj);
            C(j,i) = C(i,j);
        else
            C(i,j) = NaN;
            C(j,i) = NaN;
        end
    end
end
end

function print_top_pairs(C, names, topk)
% Print top-k largest off-diagonal cosine values with names
if isempty(C) || all(isnan(C(:)))
    disp('  (no cosine info available)');
    return;
end
Ctri = triu(C,1);
[vals, inds] = sort(Ctri(:),'descend','MissingPlacement','last');
cnt = 0; i = 1;
while cnt < topk && i <= numel(vals)
    v = vals(i);
    if ~isnan(v) && v > -inf
        [r,c] = ind2sub(size(C), inds(i));
        % safety check names length
        if r <= numel(names) && c <= numel(names)
            fprintf('  %-15s ~ %-15s : cosine = %.4f\n', names{r}, names{c}, v);
            cnt = cnt + 1;
        end
    end
    i = i + 1;
end
if cnt == 0
    disp('  (no non-NaN cosine pairs found)');
end
end
