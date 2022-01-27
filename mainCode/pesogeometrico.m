function [wip] = pesogeometrico (gamma, t, radioEsbeltez, ... 
    bloqueCresta, posBloque, ag, betaB, betaBr, as, betaSr)

% Description:
% Calculate the toppling weight at the serial numbers of block toppling that They are subjected
% at the toppling failure among which are the sliding failure and the toppling failure.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :bloqueCresta, ag, as.
%
% Input(s):
% gamma         =   Unit weight at the block toppling.
% radioEsbeltez =   Relationship between the height of the block in the slope crest
%                   and the width of the serial block toppling.
% bloqueCresta =    position at block at the slope crest wich means the
%                   change into cut slope and slope crown.
% betaB        =    Angle of inclination of the imaginarious axis X with respect to
%                   the real axis (x).
% betaSr       =    angle of cut slope with respect at the imaginarious horizontal axis (X).
% i            =    serial number at all block toppling is to (1...nblocks).
% as           =    relationship between the angle of cut slope and the angle of principal
%                   fault line with respect at the imaginarious axis
%                   (X).
% ag           =    geometric relationship between the angle of slope crown and the
%                   angle of principal fault line with respect at the imaginarious axis (X).
% t            =    blocks width of the serial of analisys.
%
% Output(s):
% wi          =   weight at the serial numbers of block toppling that They are subjected
% at the toppling failure among which are the sliding failure and the toppling failure.
%
% Example 1
% [ wip ]     =    pesogeometrico( 25, 0.40, 5.2982, 20, 1:1:27, -0.1585, 25, 0, 0.7465 , 50 )
% Answer: 
% wip         =    ( 0.1202, 0.2542, 0.3881, 0.5221, 0.6561, 0.7900, 0.9240, 
%                   1.0580, 1.1919, 1.3259, 1.4599, 1.5939, 1.7278, 1.8618, 
%                   1.9958, 2.1297, 2.2637, 2.3977, 2.5316, 3.4392, 2.7563,
%                   2.0438, 1.2660, 0.2925, -2.0484, 2.4632, 0.1138);
%
% Example 2
% [ wip ]     =    pesogeometrico( 25, 0.40, 3.9250, 12, 1:1:27, -0.1585, 25, 0, 0.2550 , 35 )
% Answer: 
% wip         =    (0.0313, 0.1652, 0.2992, 0.4332, 0.5671, 0.7011, 0.8351, 
%                   0.9691, 1.1030, 1.2370, 1.3710, 1.8317, 1.5934, 1.3508, 
%                   1.1027, 0.8469, 0.5807, 0.2992, -0.0057, -0.3490, -0.7624,
%                   -1.3253, -2.3103, -5.6767, 8.7707, 1.5555, 0.2879];
%


numVals = length(posBloque);

betaSrRad = betaSr * pi/180;
betaBRad = betaB * pi/180;
betaBrRad = betaBr * pi/180;

wip = zeros(1, numVals);
for i = 1:numVals
    wip(i) = pesogeometrico2 (gamma, t, radioEsbeltez, bloqueCresta, ...
        posBloque(i), ag, betaBRad, betaBrRad, as, betaSrRad);
end
end


function [wip] = pesogeometrico2 (gamma, t, radioEsbeltez, ... 
    bloqueCresta, i, ag, betaBRad, betaBrRad, as, betaSrRad)

if i < bloqueCresta
       wip = (0.5*gamma*(t^2)) * ((sin(betaBRad) ...
            *(radioEsbeltez + ((bloqueCresta - i)*ag))) ...
            -cos(betaBRad) - (sin(betaBRad)*tan(betaBrRad)));
    else
       wip = (0.5*gamma*(t^2)) *(((radioEsbeltez - ...
            (i- bloqueCresta)*as))*((sin(betaBRad) ...
            *(radioEsbeltez - ((i- bloqueCresta)*as))- (tan(betaBrRad))) ...
            - cos(betaBRad))) / ...
            (radioEsbeltez - ((i - bloqueCresta)*as) - tan(betaSrRad) + ...
            (tan(betaBrRad)));   
end
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.
