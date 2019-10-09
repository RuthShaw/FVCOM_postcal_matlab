clc;close all;clear all
% file_name = 'F:\Australia\data\UHSLC\h175.dat';
% t_beg = '20160101'; t_end = '20171231';
% step = 'hour';
% OUTPUT = read_UHSLC( file_name, t_beg, t_end, step );
% save('output.mat','OUTPUT')
%load('output.mat')
addpath('../');
nc_file = dir('../cockburn_0*');
fvcom.time = [];
heat_flux = [];
temp = [];
zeta = [];
flon = ncread(nc_file(1).name,'lon');
flat = ncread(nc_file(1).name,'lat');

% 需要优化经纬度
%sloc = [115.44 , -32.03];
sloc = [115.3855 , -31.9893];
IDX=knnsearch([flon,flat],sloc,'k',16)
i = 1;
siglay = ncread(nc_file(i).name,'siglay');
fvcom.siglay = siglay(IDX,:);
h = ncread(nc_file(i).name,'h');
fvcom.h = h(IDX,:);
lon = ncread(nc_file(i).name,'lon');
fvcom.lon = lon(IDX,:);
lat = ncread(nc_file(i).name,'lat');
fvcom.lat = lat(IDX,:);
%siglay = t9mp(IDX,:);
for i = 1:size(nc_file,1)
    i
    fvcom.time = cat(2,fvcom.time,ncread(nc_file(i).name,'Times')); 
    tmp = ncread(nc_file(i).name,'zeta');
    zeta = cat(2,zeta,tmp(IDX,:));
    tmp3 = ncread(nc_file(i).name,'net_heat_flux');
    tmp2 = ncread(nc_file(i).name,'temp');
    heat_flux = cat(2,heat_flux,tmp3(IDX,:));
    temp = cat(3,temp,tmp2(IDX,:,:));
    
   % zeta = cat(2,zeta,tmp(IDX,:));
end

fvcom.zeta = zeta;
fvcom.temp = temp;
fvcom.hf = heat_flux;

save('IMO_fvcom.mat','fvcom')
