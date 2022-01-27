function [ hm ] = heightblockatcrest( betaSr, betaS, as, H )
% Description:
% Calculate the height at the block in the slope crestfor a set of toppling
% blocks.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :as.
%
% Input(s):
% as    =      relationship between the angle of cut slope and the angle of principal
%              fault line with respect at the imaginarious axis
%              (X).
% betaSr =     angle of cut slope with respect at the imaginarious horizontal axis (X).
% betaBs =     angle of cut slope with respect at the real horizontal axis (x).
% H =          Heigth at the slope calculated by the distance since the slope
%              toe to change of the cut and the slope crown.
%
% Output(s):
% hm =   the height at the block in the slope crestfor a set of toppling
%        blocks.
%
% Example 1
%[ hm ] = heightblockatcrest( 50, 75, 0.7465, 4.2662 )
% Answer: 
% radioEsbeltez =  2.1193
%
% Example 2
%[ hm ] = heightblockatcrest( 35, 60, 0.2550, 6.52)
% Answer: 
% radioEsbeltez =  1.57
%

hm = cos(betaSr*pi/180)/(sin(betaS*pi/180))*as*H;

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.