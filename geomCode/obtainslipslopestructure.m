function [ slipplaneSlopeSTR ] =obtainslipslopestructure ...
    ( slopeMeasuredSTR, slipPlaneSTR, want2plot )
% Description:
% This function gives the total border structure at the basis triangle in
% the geometrical problem at the toppling failure and with this obtain the
% parameters as well as the height at the slope face (distance from toe to
% begin at the slope crown), h2, where is the distance at the begin of the
% slope crown to the end at this, and the Slope Base parameters as well as 
% the phiBdeg, thetaDeg wich the friction angle of the slope fault base and
% the thetaDeg what are the inclination of the slope fault base.
%
% Input(s):
% slopeMeasuredSTR = Geometrical parameters as well as l2, h2, hh as follows
% h2 = Vertical distance from the start of slope crown to an end.
% l2 = Horizontal distance from the start of slope crown to an end.
% hh = Vertical distance from the real distance at the begining of the problem
% to the end at slope crown.
%
% (slipPlaneSTR) Slope Base parameters as well as the phiBdeg, thetaDeg
% wich the friction angle of the slope fault base and the thetaDeg what are
% the inclination of the slope fault base.
%
% Output(s):
% slipplaneSlopeSTR
% Structural border at the base triangle at the geometrical problem that it
% allows define the distance and the angle parameters to obtain division at
% the serial of blocks wich are in a toppling analisys.
%
% Example:
% slopeMeasuredSTR =struct( 'l2', 6.90, 'h2', 0.6, 'betaSdeg', 58, 'hh', 13.3 );
% slipPlaneSTR =struct( 'phiBdeg', 33, 'thetaDeg', 37 );
% The answer should be
% slipplaneSlopeSTR =struct( 'h', 8.7, 'h2', 0.6, 'betaSdeg', 58, 'thetaDeg', 37 );
%


%% Inputs management
if nargin  <3
  want2plot = false;
end

l2 = slopeMeasuredSTR.l2;
h2 = slopeMeasuredSTR.h2;
hh = slopeMeasuredSTR.hh;

betaSdeg = slopeMeasuredSTR.betaSdeg;
thetaDeg = slipPlaneSTR.thetaDeg;

%% Obtaining the cut slope height (h)
betaSrad = betaSdeg * pi/180;
thetaRad = thetaDeg * pi/180;

crownSlopeIntPtVec = [l2; h2];
baseSlopeUvec = [cos(betaSrad); sin(betaSrad)];
originVec = zeros(2,1);
slipPlaneUvec = [cos(thetaRad); sin(thetaRad)];

l2 = crownSlopeIntPtVec(1);
h2 = crownSlopeIntPtVec(2);

baseSlopeParamEqSTR = struct('xoVec', crownSlopeIntPtVec, 'uVec', ...
    baseSlopeUvec );
slipPlaneParamEqSTR = struct('xoVec', originVec, 'uVec', slipPlaneUvec );

if thetaRad <= atan(h2/l2)
    h = NaN;
elseif thetaRad >= betaSrad
    h = NaN;
else
    slipTopplingFeetPtVec = intersecctiontwo2Dlines (baseSlopeParamEqSTR, ...
        slipPlaneParamEqSTR, false);
    h = slipTopplingFeetPtVec(2) - h2;
    if (h+h2) > hh, h = NaN; end
end

%% Calculating the slipslope structure
slipplaneSlopeSTR = struct( 'h', h, 'h2', h2, 'betaSdeg', betaSdeg, ...
    'thetaDeg', thetaDeg);

%% Points for plotting
basePtVec = crownSlopeIntPtVec + ...
    [baseSlopeUvec(1)/baseSlopeUvec(2); 1] *(hh - h2);
allGroundArray = [originVec, crownSlopeIntPtVec, slipTopplingFeetPtVec, ...
    basePtVec];
sliplineArray = [originVec, slipTopplingFeetPtVec];

%% Plotting
if want2plot
  hold on
  plot(allGroundArray(1,:), allGroundArray(2,:), 'k-');
  plot(allGroundArray(1,:), allGroundArray(2,:), 'kx');
  plot(sliplineArray(1,:), sliplineArray(2,:), 'k-');
end

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.