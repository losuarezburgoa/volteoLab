function [Ri] = fuerzanormalbase (wi, betaB, phiD, betaBr, N, i)
% Description:
% Calculate the normal force at the base blocks for the set of block toppling
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
% Ri          =   matrix of the normal force at the base blocks for the set of block toppling
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
% Ri  = (7.8796, 8.3365, 8.8230, 9.3265, 9.8406, 10.3608, 10.8851, 11.4121, 11.9410,
%       12.4711, 13.0017, 12.4441, 12.3005, 11.7396, 11.1768, 10.6111, 10.0414, 9.4681,
%       8.8881, 8.2998, 7.6972, 7.0695, 6.3864, 5.4705, 5.6759, 5.2990, 4.8484);


betaBRad = betaB * pi/180;        
phiDRad = phiD * pi/180;         
betaBrRad = betaBr * pi/180;  

numVals = length(i);             
Ri0 = zeros(1, numVals);        
Ri1 = zeros(1, numVals);        
Ri = zeros(1, numVals);         
               
for i = 1:1
    Ri0(1) = ((wi(i))*(cos(betaBRad))) + ...
    (((0)-(N(i))) * (tan(phiDRad)*cos(betaBrRad)-(sin(betaBrRad))));
end
for i = 2:numVals
   Ri1(i) = ((wi(i))*(cos(betaBRad))) + ...
   (((N(i-1))-(N(i))) * (tan(phiDRad)*cos(betaBrRad)-(sin(betaBrRad))));
end

for i = 1:numVals
    Ri(i) = Ri0(i) + Ri1(i);
end
%display (Ri)
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.