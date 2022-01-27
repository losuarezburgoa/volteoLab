function [Si] = fuerzacortantebase (wi, betaB, betaBr, phiD, N, i)
% Description:
% Calculate the shear strenght at the base blocks for the set of block toppling
% failure.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :wi, N.
%
% Input(s):
% wi          =   matrix that contain the set of weight in the block
%                 toppling failure.
% N           =   matrix of the normal contact force between toppling blocks at the serial numbers 
%                 that contain the set of toppling and sliding failure. 
% i           =   matrix of the serial number at all block toppling is to (1...nblocks).
% phiD        =   Friction angle of the principal contact block discontinuity.
% betaBr      =   Angle of inclination of the block base in the serial
%                 number at (1...n).
% betaB       =   Angle of inclination of the imaginarious axis X with respect to
%                 the real axis (x).
%
% Output(s):
% Si          =   matrix of the shear strenght at the base blocks for the set of block toppling
%                 failure.
%
% Example 1
% wi    =    (8.7267, 9.3607, 9.9946, 10.6285, 11.2625, 11.8964, 12.5303, 
%            13.1643, 13.7982, 14.4321, 15.0661, 15.7000, 14.6801, 13.6602, 
%            12.6403, 11.6203, 10.6004, 9.5805, 8.5606, 7.5407,  6.5208, 
%            5.5008, 4.4809, 3.4610, 2.4411, 1.4212, 0.4013];
%
% N     =    (0.0313, 0.1878, 0.4378, 0.7633, 1.1531, 1.6006, 2.1015, 2.6530,
%            3.2530, 3.9002, 4.5942, 6.4916, 7.5591, 8.2402, 8.5370, 8.4525,
%            7.9910, 7.1563, 5.9555, 4.3975, 2.4975, 0.2821, -2.1898, -4.6707, 
%            -8.3525, -12.6163, -17.3837);
%
% i     =    (1:1:27);
% 
% betaB       =    25;
% betaBr      =    0; 
% phiD        =    43.25;
% phiB        =    43.25;
% 
% Answer:
% 
%Si= (3.6568, 3.7995, 3.9739, 4.1663, 4.3699, 4.5801, 4.7946, 5.0120, 5.2314,
%     5.4521, 5.6732, 4.7377, 5.1366, 5.0919, 5.0452, 4.9955, 4.9414, 4.8836,
%     4.8187, 4.7448, 4.6558, 4.5401, 4.3656, 3.9436, 4.7135, 4.8644, 4.9370);

betaBRad = betaB * pi/180;        
betaBrRad = betaBr * pi/180;      
phiDRad = phiD * pi/180;  


numVals = length(i);            
Si0 = zeros(1, numVals);         
Si1 = zeros(1, numVals);         
Si = zeros(1, numVals);        

for i = 1:1
    Si0(1) = ((wi(i))*(sin(betaBRad))) + ...
    (((0)-(N(i))) * (cos(betaBrRad) - (tan(phiDRad)*sin(betaBrRad))));
end

for i=2 :numVals
    
   Si1(i) = ((wi(i))*(sin(betaBRad))) + ...
   (((N(i-1))-(N(i))) * (cos(betaBrRad) - (tan(phiDRad)*sin(betaBrRad))));
       
end

for i = 1:numVals
    Si(i) = Si0(i) + Si1(i);
end
%display (Si)
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.