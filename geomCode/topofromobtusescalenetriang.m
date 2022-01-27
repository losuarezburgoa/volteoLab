function [ h1, h2, betaRdeg ] =topofromobtusescalenetriang( triangSTR, thetaDeg )
%
% Description:
% Given three the properties of the triangle that slips through a slip
% planes whose inclination in respect to the horizontal plane has an angle
% theta, this function find: the height from the base to the first slope,
% and the complement height to the top of the slope, and finally the angle
% of the base slope.
% This is the inversion function of the obtusescalenetriangfromtopo function.
%
% Input(s):
% The structure of an obtuse triangle ABC; where the vertex A is at origim
% and the other triangle vertices are in the positive quadradnt.
% In anytriangle, every vertex is related with their angle (in greek
% letter) and the oposite side in lowercase letter. For example, to vertex
% A is related the angle alpha and the side a.
% For this problem, the triangle sides receive special names:
%  slipSide is AC=b, baseSlopeSide is BC=a, and crownSlopeSide is AB=c.
% The structure is as follows:
%    triangSTR.slipSideCell{1} gives the length of b;
%    triangSTR.slipSideCell{2} gives the angle of beta in degrees; and
%    triangSTR.slipSideCell{3} gives the 2x1 vector of the point B
%    coordiantes.
% The same is for the other triangle sides.
%
% The angle of the slip plane, side b, respect to the horizontal line and
% given in sexagesimal degrees (thetaDeg).
%
% Output(s):
% The height of the first slope from global slope base to the point B where
% the slope changes in the back  (h1). The slope from base to point B is
% called the base slope.
%
% The height from the point where the slope changes in the back (point B)
% to the higuest point of the global slope (h2). The sum of h1 and h2 gives
% the total slope height (h). The slope backwards to point B is called the
% crown slope.
%
% The inclination (in hexagesimal degrees and respect to the horizontal) of
% the base slope (betaRdeg).
% 
% Example1:
% thetaDeg =37;
% triangSTR =struct( 'slipSideCell', {{15.6360, 126.9114, [6.9824; 0.6]}}, ...
%     'baseSlopeCell', {{10.3886, 32.0886, [0;0]}}, 'crownSlopeCell', ...
%     {{7.0081, 21, [12.4875; 9.41]}} );
% We obtain: h1 =8.81; h2 =0.60; betaRdeg =58;
%
%%%%%%%%%%%%%%
% [ h1, h2, betaRdeg ] =topofromobtusescalenetriang( triangSTR, thetaDeg )
%%%%%%%%%%%%%%

%% Extracting the variables from structure
thetaRad =thetaDeg *pi/180;

b =triangSTR.slipSideCell{1};
a =triangSTR.baseSlopeCell{1};
c =triangSTR.crownSlopeCell{1};

aAngleDeg =triangSTR.baseSlopeCell{2};

%% Obtaining the values

h2 =c *sin( thetaRad -aAngleDeg*pi/180 );
h =b *sin( thetaRad );
h1 =h -h2;
betaRdeg =asin( h1 /a ) *180/pi;
 
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.