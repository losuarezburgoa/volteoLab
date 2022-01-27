function [blcsAreStableTrueArray] = obtainstableblocs (blcsUnrotSTRCell, ...
    betaBdeg)
% Description
% This function allows calculate the serial number at the blocks stable for
% the toppling failure, given that toppling will occur when in the case of
% gravity vector exist loss of stability with respect to the block base, which entails
% that the relation from (thickness to the height of the block of analysis) is
% less than or equal to the slope of the block base (liu et al, 2009).
%
% Input(s):
%
% Cell of the elements as well as blocks in a system with out rotation,
% with the structures of the discontinuities inmersed at the calculate.
% betaB=   Angle of inclination of the imaginarious axis X with respect to
%          the real axis (x), and it is the inclination of the base of the serial 
%          blocks with respecto to the real axis (x).
% Outputs(s):
%
% The serial of blocks analisys that const at the number (zero) in the zone
% that is stable for toppling failure and, the number (one) in the zone that
% isn't stable for toppling failure.
%

numBlcs = length(blcsUnrotSTRCell);

blcsAreStableTrueArray = ones(1, numBlcs);
for i = 1:numBlcs
    blcSTR = blcsUnrotSTRCell{i};
    h = blcSTR.height;
    b = blcSTR.width;
    slenderRatio = h/b;
    if (1/slenderRatio) <= tan(betaBdeg * pi/180) 
        blcsAreStableTrueArray(i) = 0;
    end
end

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.