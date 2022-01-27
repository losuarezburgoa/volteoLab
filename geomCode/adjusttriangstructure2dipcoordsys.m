function [adjustedTriangSTR] = adjusttriangstructure2dipcoordsys( ...
    triangSTR, discontSTR, want2plot)

% Description:
% The triangle is rotated and mirroded in order be oriented in a coordiante
% system where the block heights are vertical and the block widths are
% horizontal.
%
% The triangle structure (triangSTR).
% The dip of the discontinuties familiy that generates the blocks, in
% degrees (dipDeg).
%
% Output(s):
% The traingle structure now rotated and mirroded (i.e. adjusted) to the
% system with the y-axis paralell to the block heights and the x-axis
% paralell to the block widhts (adjustedTriangSTR).
%
% Example1:
% triangSTR =struct( 'slipSideCell', {{15.6360, 126.9114, [6.9824; 0.6]}}, ...
%     'baseSlopeCell', {{10.3886, 32.0886, [0;0]}}, 'crownSlopeCell', ...
%     {{7.0081, 21, [12.4875; 9.41]}} );
% dipDeg =61;
%


%% Input management
if nargin < 3
  want2plot = false;
end

dipDeg = discontSTR.dipDeg;
%separation =discontSTR.separation;

%% Extracting the coordiantes of the triangle vertices
ptBvec = triangSTR.slipSideCell{3};
ptAvec = triangSTR.baseSlopeCell{3};
ptCvec = triangSTR.crownSlopeCell{3};

%% Rotating the triangle vertices
rotAngleRad = (90 - dipDeg) * pi/180;

mirrorMat = [1, 0; 0, -1];
rotMat = [cos(rotAngleRad), sin(rotAngleRad); ...
    -sin(rotAngleRad), cos(rotAngleRad)];

%% The triangle angles and lengths remain the same
adjustedTriangSTR = triangSTR;
adjustedTriangSTR.slipSideCell{3} = mirrorMat * rotMat * ptBvec;
adjustedTriangSTR.baseSlopeCell{3} = mirrorMat * rotMat * ptAvec;
adjustedTriangSTR.crownSlopeCell{3} = mirrorMat * rotMat * ptCvec;

%% Plotting
if want2plot
    hold on
    % plotobtusescalenetriang (triangSTR, 'r'); % old triangle
    plotobtusescalenetriang (adjustedTriangSTR); % adjusted triangle
end

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.