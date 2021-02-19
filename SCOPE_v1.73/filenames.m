%The following three are always required,

X = {
'Simulation_Name'	, 'CA-OBS-2019';
'soil_file'		, 'soilnew.txt';
'leaf_file'		, 'Optipar2017_ProspectD.mat'; 
'atmos_file' 		, 'FLEX-S3_V80.atm';
'Esun_spectra_file'     , 'Kaniva_hyperspectral_direct.csv';
'Esky_spectra_file'     , 'Kaniva_hyperspectral_diffuse.csv';

%The following are only for the time series option!
'Dataset_dir'		, 'CA-OBS-2019'; 
't_file'		, 'doy_.dat';
'year_file'		, 'year_.dat';
'Rin_file'		, 'sw_.dat';
'Rli_file'		, 'lw_.dat';
'p_file' 		, 'ps_.dat';
'Ta_file'		, 'ta_.dat';
'ea_file'		, 'ea_.dat';
'u_file'		, 'u_.dat';

%optional (leave empty for constant values From inputdata.TXT)
'CO2_file'		, '';
'SMC_file'		, '';

% optional (leave empty for calculations based on t_file year timezn)
'tts_file' 		, '';

%optional two column tables (first column DOY second column value)
'z_file' 		, '';
'LAI_file'		, 'lai_constant_.dat';
'hc_file'		, '';
'Vcmax_file'	, '';
'Cab_file'		, '';

%optional leaf inclination distribution file with 3 headerlines (see
%example). It MUST be located in ../data/leafangles/
'LIDF_file'     , ''};