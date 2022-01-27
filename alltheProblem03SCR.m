% alltheProblem03SCR
% This is the main script to load and run the VolteoLab Program.

%% Install the toolbox volteoLab
%installVolteoLabSCR;

%% Define the path where the codes are stored.
addpath(genpath('./'));

%% INPUTS.
% Slope geometry.
hh = 13.78; % total height in m.
h = 4.646; % frontal cutslope height in m.

betaSdeg = 70; % frontal cutslope angle in degrees.
betaGdeg = 41; % ground slope angle in degrees.


% Slip plane.
phiBdeg = 56; % slip plane discontinuity basic friction angle in degrees.
thetaDeg = 49; % slip plane angle in degrees.

% Blocks.
sep = 0.4; % block width, discontinuity spacing in m.
betaDeg = 25; % discontinuity basic friction angle in degrees.
phiDdeg = 56; % lateral discontinuity friction angle in degrees.
unitWeight = 26.19; % rock material unit weigth in kN m-3.

%% Calling the functions by sequence.
[l2, h2] = calculatel2h2 (h, betaGdeg, betaSdeg, thetaDeg);

% The geometry.
slopeMeasuredSTR = struct('l2', l2, 'h2', h2, 'betaSdeg', betaSdeg, ...
    'hh', hh); 

% The slip plane.
slipPlaneSTR = struct('phiBdeg', phiBdeg, 'thetaDeg', thetaDeg);

% The dominant ubiquitous discontinuity set (that plane that produces toppling).
discontSTR = struct('dipDeg', (90-betaDeg), 'separation', sep, ...
    'phiDdeg', phiDdeg, 'unitWeight', unitWeight);

% Calculation of the support force
[supportForce, ~, ~, secondVariablesSTR] = volteolab ( ...
    slopeMeasuredSTR, slipPlaneSTR, discontSTR);

%% Display the result
% display( sprintf( ['The support force (paralell to the block bases) ', ...
%     'applied on the slope foot necessary to make the slope stable ', ...
%     'is of %5.2f force units.'], supportForce) );
display(supportForce); 
display(secondVariablesSTR);

%% OUTPUTS
%% Variables that are non-repeating input-values are with *
% h = 4.6460
% betaGrDeg = 16*
% betaDeg = 25
% betaSrDeg = 45*
% thetaRdeg = 24*
% unitWeight = 26.190
% t = 0.4000
% betaBdeg = 25*
% betaSdeg = 70
% betaBrDeg = 0*
% phiDdeg = 56
% phiBdeg = 56
% thetaDeg = 49*
% betaGdeg = 41
% mBlcSlendRatio = 4.8590*
% numCalcBlcs = 33*
% mIndx = 18*
% as = 0.5548*
% ag = -0.1585*

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.