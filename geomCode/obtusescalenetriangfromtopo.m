function [triangSTR] = obtusescalenetriangfromtopo (slipslopeMeasuredSTR, ...
   want2plot, want2display)
%
% Description:
% Given three variables that define the slope movement: the height from the
% base to the first slope, and the complement height to the top of the
% slope, and finally the angle of the slip surface; this funtion obtains
% all the properties of the triangle that slips (valid only for obtuse
% triangles).
%
% Input(s):
% The height of the first slope from global slope base to the point B where
% the slope changes in the back  (h). The slope from base to point B is
% called the base slope.
%
% The height from the point where the slope changes in the back (point B)
% to the higuest point of the global slope (h2). The sum of h and h2 gives
% the total slope height (h1). The slope backwards to point B is calle the
% crown slope.
%
% The slope inclination (in hexagesimal degrees and respect to the
% horizontal) of the base slope (betaSdeg).
% 
% The slope inclination (in hexagesimal degrees and respect to the
% horizontal) of the slide plane (thetaDeg).
%
% A boolean value of true if a plot is wanted to show (want2plot).
% A boolean value of true if the result is wanted to show (want2display).
%
% Output(s):
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
% Example1:
% h =4.3; h2 =0.6; betaSdeg =65; thetaDeg =39;
%
% Example2:
% h =8.81; h2 =0.6; betaSdeg =58; thetaDeg =37;
%

%% Input management
if nargin < 2
    want2plot = false;
    want2display = false;
elseif nargin < 3
    want2display = false;
end

h = slipslopeMeasuredSTR.h;
h2 = slipslopeMeasuredSTR.h2;
betaSdeg = slipslopeMeasuredSTR.betaSdeg;
thetaDeg = slipslopeMeasuredSTR.thetaDeg;

betaRrad = betaSdeg / 180*pi;
thetaRad = thetaDeg / 180*pi;

h1 = h + h2;

%% Obtaining the sides and sine of angles
% Values related to vertex C of the triangle
cAngleRad = betaRrad - thetaRad;
sinCangle = sin(cAngleRad);

adDist = h1 * tan(pi/2 -thetaRad) - h * tan(pi/2 - betaRrad);
c = sqrt(h2^2 + adDist^2);
cAngleDeg = asin(sinCangle) * 180/pi;

% Values realted to vertex A of the triangle
a = h * sec(pi/2 - betaRrad);
sinAangle = (a/c) * sin(cAngleRad);
aAngleDeg = asin(sinAangle) * 180/pi;

% Values related to vertex B of the triangle
b = h1 * csc(thetaRad);
sinPiMinusBangle = (b/c) * sin(cAngleRad);
bAngleDeg = (pi - asin(sinPiMinusBangle)) * 180/pi;
% angle b has ambiguos case for obtuse triangle.

%% Vertex coordiantes
ptAvec = zeros(2,1);
ptBvec = ptAvec + c * [cos(thetaRad - aAngleDeg * pi/180); ...
      sin(thetaRad - aAngleDeg * pi/180)];
ptCvec = ptAvec + b *[cos(thetaRad); sin(thetaRad)];

%% Making the structure
slipSideCell = {b, bAngleDeg, ptBvec};
baseSlopeCell = {a, aAngleDeg, ptAvec};
crownSlopeCell = {c, cAngleDeg, ptCvec};

triangSTR = struct('slipSideCell', {slipSideCell}, ...
    'baseSlopeCell', {baseSlopeCell}, ...
    'crownSlopeCell', {crownSlopeCell});

%% Want to display
if want2display
    % Displaying verifications
    sinTheoremString = sprintf( ...
        'Law of sines evaluation: %5.2f=%5.2f=%5.2f.', ...
        slipSideCell{1} / sin(slipSideCell{2}*pi/180), ...
        baseSlopeCell{1} / sin(baseSlopeCell{2}*pi/180), ...
        crownSlopeCell{1} / sin(crownSlopeCell{2}*pi/180));
    display(sinTheoremString);
    sumAnglesDeg = aAngleDeg + bAngleDeg + cAngleDeg;
    display(sprintf('Sum of three angles are %5.2f deg.\n', sumAnglesDeg));
    % Displaying the result
    display('Results');
    display({sprintf('Slip side: %5.2f [L], %5.2f deg', ...
        slipSideCell{1}, slipSideCell{2}); ...
        sprintf('Slope at base side: %5.2f [L], %5.2f deg', ...
        baseSlopeCell{1},baseSlopeCell{2} ); ...
        sprintf('Slope at crown side: %5.2f [L], %5.2f deg', ...
        crownSlopeCell{1}, crownSlopeCell{2})});
end
%% Want to plot
if want2plot
    hold on
    plotobtusescalenetriang(triangSTR);
    set(gca, 'YDir', 'reverse');
    axis equal
end
    
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.