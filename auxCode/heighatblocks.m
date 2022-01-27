function [ hi ] = heighatblocks( radioEsbeltez, bloqueCresta, posBloque, ag, as, t )
% Description:
% Calculate the heights at the serial numbers of block toppling that They are subjected
% at the toppling failure among which are the sliding failure and the toppling failure.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :bloqueCresta, radioEsbeltez, ag, as.
%
% Input(s):
% radioEsbeltez =   Relationship between the height of the block in the slope crest
%                   and the width of the serial block toppling.
% bloqueCresta =    position at block at the slope crest wich means the
%                   change into cut slope and slope crown.
% posBloque    =    serial number at all block toppling is to
%                   (1...nblocks).
% as           =    relationship between the angle of cut slope and the angle of principal
%                   fault line with respect at the imaginarious axis
%                   (X).
% ag           =    geometric relationship between the angle of slope crown and the
%                   angle of principal fault line with respect at the imaginarious axis (X).
% t =       blocks width of the serial of analisys.
%
% Output(s):
% heighatblocks =   heights at the serial numbers of block toppling that They are subjected
%                   at the toppling failure among which are the sliding failure 
%                   and the toppling failure.
%
% Example 1
% [ hi ] = heighatblocks( 5.2982, 20, 1:1:27, -0.1585, 0.7465, 0.40 )
% Answer: 
% hi =     (0.9147, 0.9781, 1.0415, 1.1049, 1.1683, 1.2317, 1.2951, 1.3585, 
%           1.4219, 1.4853, 1.5487, 1.6121, 1.6755, 1.7389, 1.8023, 1.8657, 
%           1.9291, 1.9925, 2.0559, 2.1193, 1.8207, 1.5221, 1.2235, 0.9249, 
%           0.6263, 0.3277, 0.0291)
%
% Example 2
% [ hi ] = heighatblocks( 3.9259, 12, 1:1:27, -0.1585, 0.2550, 0.40 )
% Answer: 
% hi =    (0.8730, 0.9364, 0.9998, 1.0632, 1.1266, 1.1900, 1.2534, 1.3168, 
%           1.3802, 1.4436, 1.5070, 1.5704, 1.4684, 1.3664, 1.2644, 1.1624,
%           1.0604, 0.9584, 0.8564, 0.7544, 0.6524, 0.5504, 0.4484, 0.3464, 
%           0.2444, 0.1424, 0.0404)
%

numVals =length(posBloque);
hi =zeros(1,numVals);
for i=1 :numVals
    hi(i) =heighatblocks2( radioEsbeltez, bloqueCresta, posBloque(i), ag, as, t );
end
end

function [ hi ] = heighatblocks2( radioEsbeltez, bloqueCresta, i, ag, as, t )
if i<=bloqueCresta
    hi = (radioEsbeltez + (bloqueCresta-i)*ag)*t;
else 
    hi = (radioEsbeltez - (i-bloqueCresta)*as)*t;
end
end


% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.