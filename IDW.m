%% Inverse Distance Weight
clc;clear vars;close all
load('IMO_fvcom.mat')
all_d = 0;
%dw =zeros(16,1);
for i = 1:16
    dw(i) = 1/distance('gc',115.3855 , -31.9893, fvcom.lon(i), fvcom.lat(i));
    %all_dw = all_dw + dw(i)
end
dw = dw/sum(dw);
IDW_IMO.time = fvcom.time;
IDW_IMO.siglay = dw*fvcom.siglay;
IDW_IMO.h = dw*fvcom.h;
IDW_IMO.lon = dw*fvcom.lon;
IDW_IMO.lat = dw*fvcom.lat;
IDW_IMO.zeta = dw*fvcom.zeta;

for i = 1:20
    IDW_IMO.temp(i,:) = dw*squeeze(fvcom.temp(:,i,:));
end

save('IDW_IMO.mat','IDW_IMO')
