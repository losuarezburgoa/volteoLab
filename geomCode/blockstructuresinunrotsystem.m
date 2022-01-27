function [blcsUnrotSTRCell] =lockstructuresinunrotsystem ...
    (blcsSTRCell, discontSTR, want2plot)
%
% Description:
% This function gives the structure at the blocs in a space with the
% premise that will be presented as well as a plane with out rotation.
% Is the firs step to obtain the ultimate structure at the blocks inmerse
% at a triangular structure.
%
% Input(s):
% The bloc structure (blcsSTRCell).
% The discontinuities structure (discontSTR), composed by:
%    discontSTR.dipDeg, which is the dip angle of the discontinuities (in
%    sexagesimal degrees);
%    discontSTR.separation, which is the constant spacing de
%    discontinuities have.
%
% Outputs(s):
%
% Cell of the elements as well as blocks in a system with out rotation,
% with the structures of the discontinuities inmersed at the calculate.
%

%% Input management
if nargin < 3
  want2plot = false;
end

blcsUnrotSTRCell = cell(size(blcsSTRCell));

%% Transformation matrices
dipDeg = discontSTR.dipDeg;
rotAngleRad = -(90 - dipDeg) *pi/180;

mirrorMat = [1, 0; 0, -1];
rotMat = [cos(rotAngleRad), sin(rotAngleRad); ...
    -sin(rotAngleRad), cos(rotAngleRad)];

%% Rotating the vertices
numBlcs = length(blcsSTRCell);
for i = 1:numBlcs
  blcSTR = blcsSTRCell{i};
  blcSTR.baseCentreVec = mirrorMat' * rotMat' * blcSTR.baseCentreVec;
  for j = 1:5
    blcSTR.rectangCoordsArray(:, j) = mirrorMat' *rotMat' * ...
        blcSTR.rectangCoordsArray(:, j);
  end
  blcsUnrotSTRCell{i} = blcSTR;
end

%% Plotting
if want2plot
    hold on
    for i = 1:numBlcs
       blcSTR = blcsUnrotSTRCell{i};
       plot(blcSTR.rectangCoordsArray(1,:), ...
           blcSTR.rectangCoordsArray(2,:), 'k-');
    end
end

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.