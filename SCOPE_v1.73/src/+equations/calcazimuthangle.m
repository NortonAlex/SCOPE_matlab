function [sazi, relazi] = calcazimuthangle(Doy,t,Long,Lat,vazi,sza)
%
% author: Alexander Norton (alexander.j.norton@jpl.nasa.gov)
% date:     May 2020
% update:   
%
% calculates solar azimuth angle according to a NOAA Solar Calculations
% excel spreadsheet formula: 
% https://www.esrl.noaa.gov/gmd/grad/solcalc/calcdetails.html
% NOAA_Solar_Calculations_day.xls
%
% input:
% Doy       day of the year
% t         time of the day (hours, GMT)
% Long      Longitude (decimal)
% Lat       Latitude (decimal)
% vazi      observation (viewing) azimuth angle (degrees, scalar)
% sza       solar zenith angle (radians, array), from function calczenithangle.m

% output:
% sazi      solar azimuth angle (degrees)
% relazi    azimuthal difference between solar and observation (viewing) angles (degrees)

%parameters (if not already supplied)
if nargin<4
    Long        =   13.75;                      % longitude
    Lat         =   45.5;                       % latitude
end

%convert angles into radials
G               =   (Doy-1)/365*2*pi;           % converts day of year to radials
Lat             =   Lat/180*pi;                 % converts latitude to radials

%computes the declination of the sun
d               =   0.006918-0.399912*cos(G  )+ 0.070247*sin(G  )- ...
                     0.006758*cos(2*G)+ 0.000907*sin(2*G)- ...
                     0.002697*cos(3*G)+ 0.00148*sin(3*G);
                                
%Equation of time
Et              =   0.017 + .4281 * cos(G) - 7.351 * sin(G) - 3.349 * cos(2*G) - 9.731 * sin(2*G);

%computes the time of the day when the sun reaches its highest angle                                
tm              =   12+(4*(-Long)-Et)/60;      % de Pury and Farquhar (1997), Iqbal (1983)

%computes the hour angle of the sun
Omega_s         =   (t-tm)/12*pi;

%zenith angle (equation 3.28 in De Bruin)
Fi_s            = deg2rad(sza); 

% initiate solar azimuth angle with zeros
sazi = zeros(size(Fi_s));

% compute solar azimuth angle based on NOAA Solar Calculations 
% this is the solar azimuth IF rad2deg(Omega_s) > 0
sazi_0 = mod(rad2deg(acos(((sin(Lat)*cos(Fi_s))-sin(d))./(cos(Lat)*sin(Fi_s))))+180, 360);
% this is the solar azimuth IF rad2deg(Omega_s) <= 0
sazi_1 = mod(540-rad2deg(acos(((sin(Lat)*cos(Fi_s))-sin(d))./(cos(Lat)*sin(Fi_s)))), 360);

% assign the solar azimuth depending on the sign of Omega_s 
sazi(rad2deg(Omega_s) > 0) = sazi_0(rad2deg(Omega_s) > 0);
sazi(rad2deg(Omega_s) <= 0) = sazi_1(rad2deg(Omega_s) <= 0);

%compute the relative azimuth between sun azimuth and viewing azimuth
% - take the smaller of the two angles (the absolute value)
%relazi          = abs(mod((sazi- vazi) + 180, 360)-180);
%compute the relative azimuth between sun azimuth and viewing azimuth
% - take the positive clockwise difference of the two angles
relazi          = mod((vazi-sazi)+360, 360);




