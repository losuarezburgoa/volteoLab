% alltheProblem01SCR
% This is the main script to load and run the VolteoLab Program.

%% Install the toolbox volteoLab
%installVolteoLabSCR;
addpath(genpath('./'));

%% Inputs as structures
% Slope geometry
h = 93.4;
betaGdeg = 3.5;
betaSdeg = 56.6;
thetaDeg = 35.8;

[l2, h2] = calculatel2h2 (h, betaGdeg, betaSdeg, thetaDeg);

slopeMeasuredSTR = struct('l2', l2, 'h2', h2, 'betaSdeg', betaSdeg, ...
    'hh', 150); 
% The slip plane
slipPlaneSTR = struct('phiBdeg', 38.15, 'thetaDeg', thetaDeg);
% The dominant ubiquitous discontinuity set
betaDeg = 30;
discontSTR = struct('dipDeg', (90-betaDeg), 'separation', 10, ...
    'phiDdeg', 38.15, 'unitWeight', 25);

%% Calculation of the support force
[supportForce, ~, ~, secondVariablesSTR] = volteolab ( ...
    slopeMeasuredSTR, slipPlaneSTR, discontSTR);

%% Display the result
% display( sprintf( ['The support force (paralell to the block bases) ', ...
%     'applied on the slope foot necessary to make the slope stable ', ...
%     'is of %5.2f force units.'], supportForce) );
display(supportForce); 
display(secondVariablesSTR);

%% Plotting the geometry and the forces
% figure( 'Color', ones(1,3) )
% hold on
% set( gca, 'YDir', 'reverse' );
% axis equal

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.