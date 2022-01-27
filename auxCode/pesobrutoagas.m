function [wi] = pesobrutoagas (gamma, radioEsbeltez, bloqueCresta, i, t, ...
   ag, as)
% Description:
% Calculate the weight at the serial numbers of block toppling that They are subjected
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
% i            =    serial number at all block toppling is to
%                   (1...nblocks).
% as           =    relationship between the angle of cut slope and the angle of principal
%                   fault line with respect at the imaginarious axis
%                   (X).
% ag           =    geometric relationship between the angle of slope crown and the
%                   angle of principal fault line with respect at the imaginarious axis (X).
% t =       blocks width of the serial of analisys.
%
% Output(s):
% wi          =   weight at the serial numbers of block toppling that They are subjected
% at the toppling failure among which are the sliding failure and the toppling failure.
%
% Example 1
%[ wi ] =pesobrutoagas( 25, 5.2982, 20, 1:1:27, 0.40, -0.1585, 0.7465 )
% Answer: 
% wi    =    (9.1481, 9.7820, 10.4159, 11.0499, 11.6838, 12.3177, 12.9517, 
%            13.5856, 14.2195, 14.8535, 15.4874, 16.1213, 16.7553, 17.3892,
%            18.0231, 18.6571, 19.2910, 19.9249, 20.5589, 21.1928, 18.2067, 
%            15.2206, 12.2345, 9.2484, 6.2623, 3.2762, 0.2901);
%
% Example 2
%[ wi ] =pesobrutoagas( 25, 3.9250, 12, 1:1:27, 0.40, -0.1585, 0.2550 )
% Answer: 
% wi    =    (8.7267, 9.3607, 9.9946, 10.6285, 11.2625, 11.8964, 12.5303, 
%             13.1643, 13.7982, 14.4321, 15.0661, 15.7000, 14.6801, 13.6602,
%             12.6403, 11.6203, 10.6004, 9.5805, 8.5606, 7.5407,  6.5208, 
%             5.5008, 4.4809, 3.4610, 2.4411, 1.4212, 0.4013];)
%

if i <= bloqueCresta
    wi = gamma * (radioEsbeltez + (bloqueCresta - i)*ag)*t^2;
else
    wi = gamma * (radioEsbeltez - (i - bloqueCresta)*as)*t^2;
end
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.