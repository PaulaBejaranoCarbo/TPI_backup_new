function run_iskrev_grid(modname, param_name, grid_vals)
% run_iskrev_grid  Run identification on a grid of param_name values.
%   modname: base dynare mod (string, e.g. 'BCM4_alt'); must be run once first
%   param_name: parameter to vary, e.g. 'thetaG'
%   grid_vals: vector of numeric values to try
%
% Example:
%   run_iskrev_grid('BCM4_alt','thetaG',[0.01,0.05,0.1,0.2,0.4]);

ident_folder = fullfile(pwd,'identification');
if ~exist('tmp_ident.mod','file')
    error('tmp_ident.mod not found. Create the tmp_ident.mod file (see instructions).');
end

% ensure the main model has been run so M_, model files, and set_param_value exist
if ~evalin('base','exist(''M_'',''var'')')
    fprintf('Running dynare %s once (noclearall) to load model into workspace...\n', modname);
    dynare(modname,'noclearall');
end

% loop grid
for i = 1:numel(grid_vals)
    v = grid_vals(i);
    fprintf('\n==== grid %d/%d : setting %s = %g ====\n', i, numel(grid_vals), param_name, v);

    % set parameter in Dynare workspace
    try
        set_param_value(param_name, v);
    catch ME
        error('set_param_value failed: %s\nMake sure Dynare is in path and parameter name is correct.', ME.message);
    end

    % run identification via tmp_ident.mod (writes tmp_ident.mat)
    dynare('tmp_ident','noclearall');

    % move tmp_ident.mat to identification folder with descriptive name
    src = fullfile(pwd,'tmp_ident.mat');
    if ~exist(src,'file')
        error('tmp_ident.mat not found after running tmp_ident.mod');
    end

    % create safe filename (replace dot with 'p' for readability)
    vstr = strrep(num2str(v),'.','p');
    dstname = sprintf('identification/ident_%s_%s.mat', param_name, vstr);
    movefile(src, dstname);
    fprintf('Saved identification result to %s\n', dstname);
end

fprintf('\nAll grid runs done. Identification files are in the identification/ folder.\n');
end
