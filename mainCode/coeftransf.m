function [ct] = coeftransf (radioEsbeltez, bloqueCresta, posBloque, phiD, ...
   ag, as, betaSr, betaGr, betaBr)
% Description:
% Calculate the transfer coeficient of the toppling failure at the serial numbers 
% of block toppling that They are subjected at the toppling failure among 
% which are the sliding failure and the toppling failure.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :radioEsbeltez, bloqueCresta, ag, as.
%
% Input(s):
% radioEsbeltez =   Relationship between the height of the block in the slope crest
%                   and the width of the serial block toppling.
% bloqueCresta =    position at block at the slope crest wich means the
%                   change into cut slope and slope crown.
% posBloque    =    serial number at all block toppling is to (1...nblocks).
% phiD         =    Friction angle of the principal contact block discontinuity.
% as           =    relationship between the angle of cut slope and the angle of principal
%                   fault line with respect at the imaginarious axis
%                   (X).
% ag           =    geometric relationship between the angle of slope crown and the
%                   angle of principal fault line with respect at the imaginarious axis (X).
% betaSr       =    angle of cut slope with respect at the imaginarious horizontal axis (X).
% betaGr       =    angle of slope crown with respect at the imaginarious axis (X).
% betaBr       =    Angle of inclination of the block base in the serial
%                   number at (1...n).
%
% Output(s):
% wi          =   weight at the serial numbers of block toppling that They are subjected
% at the toppling failure among which are the sliding failure and the toppling failure.
%
% Example 1
% ct          =    coeftransf( 3.9250, 12, 1:1:27, 43.25, -0.1585, 0.2550, 35, 16, 0 )
% Answer: 
% ct          =    ( 0.7205, 0.7383, 0.7539, 0.7677, 0.7801, 0.7912, 0.8013, 0.8104, 
%                   0.8187, 0.8264, 1.0143, 0.9190, 0.9114, 0.9022, 0.8909, 0.8767, 
%                   0.8581, 0.8330, 0.7970, 0.7413, 0.6436, 0.4271, -0.4594, 3.6661, 
%                   1.6967, 1.4007, 1.2812];
%
% Example 2
% ct          =     coeftransf( 5.2982, 20, 1:1:27, 43.25, -0.1585, 0.7465, 50, 16, 0 )
% Answer: 
% ct          =     (0.7326, 0.7488, 0.7632, 0.7761, 0.7876, 0.7980, 0.8074, 0.8160, 
%                   0.8239, 0.8311, 0.8377, 0.8439, 0.8496, 0.8549, 0.8598, 0.8644, 
%                   0.8687, 0.8728, 1.1310, 1.0747, 1.0961, 1.1345, 1.2241, 1.6713, 
%                   0.3261, 0.7757, 0.8654];
%


numVals = length(posBloque);     
ct = zeros(1, numVals);                                         

phiDRad = phiD * pi/180;          
betaSrRad = betaSr * pi/180;     
betaGrRad = betaGr * pi/180;
betaBrRad = betaBr * pi/180;


for i = 1:numVals
    if posBloque(i) <= (bloqueCresta - 2)
        ct(i) = 1 + (tan(betaGrRad) - tan(phiDRad)) ...
            / (radioEsbeltez + (bloqueCresta -posBloque(i) -1) *ag);
    elseif posBloque(i) == (bloqueCresta - 1)
        ct(i) = (radioEsbeltez + tan(betaGrRad) -tan(phiDRad)) ...
            /( radioEsbeltez - tan(betaSrRad) + (tan(betaBrRad)));
    elseif posBloque(i) >= (bloqueCresta - 0)
        ct(i) = 1 +( tan(betaSrRad) -tan(phiDRad)) ...
            / ( radioEsbeltez -(posBloque(i) +1 -bloqueCresta) ...
            *as - tan(betaSrRad) + (tan(betaBrRad)));
    end
end
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.


