function [m] = positionblockatcrest(betaGrDeg, thetaRdeg, betaSrDeg, ...
    betaDeg, betaSdeg, H, t, betaBrDeg)
% Description:
% Find the serial number at the block in the slope crest, wich is the point
% of the change between angle cut slope and the angle of slope crown
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :ag, as.
%
% Input(s):
% ag =      geometric relationship between the angle of slope crown and the
%           angle of principal fault line with respect at the imaginarious axis (X).
% betaB =   angle of the imaginarious axis (X) with the real horizontal axis
%           (x).
% betaSr =  angle of cut slope with respect at the imaginarious horizontal axis (X).
% betaBs =  angle of cut slope with respect at the real horizontal axis (x).
% as =      relationship between the angle of cut slope and the angle of principal
%           fault line with respect at the imaginarious axis
%           (X).
% H =       Heigth at the slope calculated by the distance since the slope
%           toe to change of the cut and the slope crown.
% t =       blocks width of the serial of analisys.
%
% Output(s):
% bloqueCresta = position at block at the slope crest wich means the
%                change into cut slope and slope crown.
%
% Example 1
% [ m ] =positionblockatcrest( 16, 24, 50, 25, 75, 4.2662, 0.40, 0 )
% Answer: bloqueCresta =20.
%
% Example 2
% [ m ] =positionblockatcrest( 16, 24, 35, 25, 60, 6.52, 0.40, 0 )
% Answer: bloqueCresta =12.
%

[ag, as] = calculaagas (betaGrDeg, betaSrDeg, thetaRdeg);

m = floor(1/ag/tan( deg2rad(betaDeg)) ...
    - cos(deg2rad(betaSrDeg)) / sin(deg2rad(betaSdeg)) * (as/ag) * (H/t) ...
    - tan(deg2rad(betaBrDeg)) / ag + 1);

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.