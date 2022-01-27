function angRad =deg2rad( angDeg )
% Description:
% Transform angle in degrees to radians.
%
% External sub-function(s) :none.
%
% Input(s):
% Angle in degrees (angDeg).
%
% Output(s):
% Angle in radians (angRad).
%
% Example 1
% angRad =deg2rad( 35 )
% Answer: angRad =0.6109.
%
% Example 2
% angRad =deg2rad( 45 )
% Answer: angRad =0.7854.

  angRad =angDeg *pi /180;
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.