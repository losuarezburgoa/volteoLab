function [l2, h2] = calculatel2h2(h, betaGdeg, betaSdeg, thetaDeg)
% Description:
% Find the lenghts of the parameters as well as 
%     h2 = Vertical distance from the start of slope crown to the end.
%     l2 = Horizontal distance from the start of slope crown to the end.
%
% External sub-function(s) :none.
%
% Input(s):
% ag       =  geometric relationship between the angle of slope crown and the
%             angle of principal fault line with respect at the imaginarious 
%             axis (X). 
% betaGdeg =  Inclination angle of the slope crown with respect at the
%             real horizontal axis.
% betaSdeg =  Inclination cut angle of the face slope with respect at the
%             real horizontal axix.
% thetaDeg =  Inclination of the basal discontinuity with respect at the
%             real horizontal axis.
%
% Output(s):
% l2 = Horizontal distance from the start of slope crown to the end.
% h2 = Vertical distance from the start of slope crown to the end.
%
% Example1:
% h =93.4; betaGdeg =3.5; betaSdeg =56.6; thetaDeg =35.8;
% Answer:
% l2 =  74.2096
% h2 =  4.5389
% Example2:
% h =48; betaGdeg =15; betaSdeg =55; thetaDeg =42;
% Answer:
% l2 =  28.0454
% h2 =  7.5147

betaG = betaGdeg * pi/180;
betaS = betaSdeg * pi/180;
theta = thetaDeg * pi/180;

%% Byt geometry of triangles
l1 = h * cot(betaS);
h2 = (h*tan(betaG) - l1*tan(theta)*tan(betaG)) / (tan(theta) - tan(betaG));
l2 = h2 / tan(betaG);

% Verification
% hv =h2 *( 1 -tan(theta)*cot(betaG) ) /( tan(theta) *cot(betaS) -1 );
% if h ~= hv
%     error('Calculations of h is wrong');
% end

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.