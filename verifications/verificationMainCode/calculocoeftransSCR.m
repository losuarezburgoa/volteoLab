% calculocoeftransSCR.m
% Calculate the transfer coefficient at the serial blocks (this verification was
% make for a thirteen blocks in the study of the toppling failure).
% Called the destination folder at the function.
% addpath(genpath('C:\Users\Alejo\Desktop\volteoLab\mainCode'));
% addpath( './funciones/' );

%% Input variables
% Geometry of the slope
betaGr =-26.5; % in degrees
betaSr =26.63; % in degrees
thetaR =5.8; % in degrees
betaBr =0;% in degrees

% Geometry and spatial properties of the blocks
phiD =38.15; % Friction angle between block discontinuities.
radioEsbeltez =4; % Relation between (major length and width of the block at crest).
bloqueCresta =4; % Location in the serial number of blocks of the block at crest.
posBloque =1:1:13; % Set of all blocks of analysis.
%posBloque =4; % Study block.

%% Preprocessing
[ ag, as ] =calculaagas( betaGr, betaSr, thetaR );

%% Calculates the transfer coefficient blocks study.

ct  =coeftransf( radioEsbeltez, bloqueCresta, posBloque, phiD, ...
   ag, as, betaSr, betaGr, betaBr );

% display( ['El value of the transfer coefficient is: ', num2str(ct,'%6.4f'), ] );
display(ct);

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.