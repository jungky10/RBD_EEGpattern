%% for validation of independent test subject

group_name='PD';
band_name='delta';

% load data from part 1 python code
load([group_name,'_GMP_ref.mat']); 

% load data from part 2 python code
load(['result_',group_name,'_',band_name]);
GIS_Az = GIS_Az';

%% validation for independent test subject 
% ex) Other disease group, iRBD-NC group)

% load bandpower
load('iRBD_fu_bandpower_re.mat'); % iRBD-NC fu subject
test_iRBD = squeeze(iRBD_bandpower_re(:,band, :)); % iRBD-NC

% log transform
test_iRBD = log10(test_iRBD);

% subtract subject mean
test_iRBD = test_iRBD-mean(test_iRBD,2); % subtract subject mean

% subtract reference group mean and make SRP
ref_group_mean = eval(['GMP_ref_',band_name]);
SRP_test_iRBD = test_iRBD-ref_group_mean;

%% test subject z score
iRBDd = SRP_test_iRBD*GIS_Az;

% Normalization to Healthy control
% 'HC_mean_std' is in 'result_PD_delta' which was obtained from part 2 python code
m = HC_mean_std(1);
s = HC_mean_std(2);

% z transformed subject z score
iRBDdz = (iRBDd-m)./s;