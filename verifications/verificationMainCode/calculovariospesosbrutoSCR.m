% calculovariospesosbrutoSCR.m
% Calculate the gross weight at the serial blocks (this verification was
% make for a thirteen blocks in the study of the toppling failure).
% Called the destination folder at the function.
% addpath(genpath('C:\Users\Alejo\Desktop\volteoLab\auxCode'));
% addpath( './funciones/' );

%% Input variables
% Geometry of the slope
betaGr =-26.5; % in degrees
betaSr =26.63; % in degrees
thetaR =5.8; % in degrees
radioEsbeltez =4; % Relation between (major length and width of the block at crest).

bloqueCresta =4; % Location in the serial number of blocks of the block at crest.

% Geometry and the cuantities of the blocks.
t =10; % width at the block at crest.
numBlqs =13;  % Set of all blocks of analysis.
% Physical properties of the rock material.
gamma =25; % Unit weight at the rock material.

%% Preprocessing
[ ag, as ] =calculaagas( betaGr, betaSr, thetaR );

%% Calculates the unit gross weight of the blocks analysis.

i =1:1:numBlqs;
wiArray =zeros(1,numBlqs);
 for i=1 :numBlqs
        wi =pesobrutoagas( gamma, radioEsbeltez, bloqueCresta, i, t, ag, as );
        wiArray(i) =wi;
 end
 display (wiArray);
 
% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.