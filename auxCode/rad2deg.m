function angDeg =rad2deg( angRad )
% Description:
% Transform angle in radians to degrees.
%
% External sub-function(s) :none.
%
% Input(s):
% Angle in radians (angRad).
%
% Output(s):
% Angle in degrees (angDeg).
%
% Example 1
% angDeg =rad2deg( 0.6109 )
% Answer: angDeg =35.
%
% Example 2
% angDeg =rad2deg( 0.7854 )
% Answer: angDeg =45.
%

angDeg =angRad /pi *180;
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.