function ds = dynamic_set_auxiliary_series(ds, params)
%
% Computes auxiliary variables of the dynamic model
%
ds.AUX_ENDO_LAG_9_1=ds.Ig(-1);
ds.AUX_ENDO_LAG_9_2=ds.AUX_ENDO_LAG_9_1(-1);
ds.AUX_ENDO_LAG_9_3=ds.AUX_ENDO_LAG_9_2(-1);
ds.AUX_ENDO_LAG_9_4=ds.AUX_ENDO_LAG_9_3(-1);
ds.AUX_ENDO_LAG_9_5=ds.AUX_ENDO_LAG_9_4(-1);
ds.AUX_ENDO_LAG_9_6=ds.AUX_ENDO_LAG_9_5(-1);
ds.AUX_ENDO_LAG_9_7=ds.AUX_ENDO_LAG_9_6(-1);
ds.AUX_ENDO_LAG_9_8=ds.AUX_ENDO_LAG_9_7(-1);
ds.AUX_ENDO_LAG_9_9=ds.AUX_ENDO_LAG_9_8(-1);
end
