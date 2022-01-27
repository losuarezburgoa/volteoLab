function [blcsSTRCell] = createblcsinadjustedtriangstr ...
    (adjustedTriangSTR, dispBlockCtrsVecArray, bPtIndx, nblcsCell, want2plot)
%
% Description:
% This function gives the structure at the blocs in a space with the
% premise that all are inmmersed at a triangular structure.
%
% Input(s):
%
% The structure of an obtuse scalene triangle, same structure as adjustedTriangSTR,
% with reduced side values but same internal angles (the two triangles are
% similar) and new coordiantes scaled from the origim, of a
% new triangle that contains exactly an integer number of blocks
% (triangNewSTR). 
% Cell of three elements giving the information of:
%   the number of blocks the side can attain, nblcsCell{1};
%   the constant width of the blocks, nblcsCell{2}; and
%   the distance (parallel to side b, the slip line) of the remainder,
%   nblcsCell{3}.
% (dispBlockCtrsVecArray)
% Generate the matrix structure at the location ob the blocks into the
% triangular structure.
% 
% (bPtIndx)
% The serial number at the set at blocks located in the triangular
% structure analysis.
%
% Outputs(s):
% The bloc structure (blcsSTRCell).
% Cell of the elements as well as blocks in a system with out rotation,
% with the structures of the discontinuities inmersed at the calculate.
%


%% Input management
if nargin < 5
  want2plot = false;
end

%% Retriebing single variables from the structure
% Vertices coordinates
ptBvec = adjustedTriangSTR.slipSideCell{3};
ptAvec = adjustedTriangSTR.baseSlopeCell{3};
ptCvec = adjustedTriangSTR.crownSlopeCell{3};
% spacing of blocks along size b (along the slip line)
spacing = nblcsCell{2};
numBlocks = size(dispBlockCtrsVecArray, 2);

%% Generating the blocks
w = spacing * dot((ptCvec-ptAvec) / norm(ptCvec-ptAvec), [1,0]);

% The upper blocks structure cell
numUpperBlcs = bPtIndx - 1;
uppBlcsSTRCell = cell(1, numUpperBlcs);
j = 1:1:bPtIndx-1;
for i = 1:numUpperBlcs
    k = j(i);
    x = dispBlockCtrsVecArray(1,k);
    y = obtainyoflinegivenx (x, ptAvec, ptBvec);
    h = y - dispBlockCtrsVecArray(2, k);
    cVec = dispBlockCtrsVecArray(:, k);
    rectCoordsArray = [cVec - [w/2;0], cVec + [w/2;0], ...
       cVec + [w/2;h], cVec + [-w/2;h], cVec-[w/2;0]];
    BlcSTR = struct( 'width', w, 'height', h, 'baseCentreVec', cVec, ...
        'rectangCoordsArray', rectCoordsArray);
    uppBlcsSTRCell(i) = {BlcSTR};
end

% The central block structure
i = bPtIndx;
x = dispBlockCtrsVecArray(1,i);
y = obtainyoflinegivenx(x, ptBvec, ptAvec);
h = y - dispBlockCtrsVecArray(2, i);
cVec = dispBlockCtrsVecArray(:, i);
rectCoordsArray = [cVec-[w/2;0], cVec+[w/2;0], cVec+[w/2;h], ...
     cVec+[-w/2;h], cVec-[w/2;0]];
ctrBlcsSTR = struct('width', w, 'height', h, 'baseCentreVec', cVec, ...
    'rectangCoordsArray', rectCoordsArray); 

% The down blocks structure cell
numDownBlcs = numBlocks - (bPtIndx+1) + 1;
dwnBlcsSTRCell = cell(1, numDownBlcs);
j = (bPtIndx+1):1:numBlocks;
for i = 1:length(dwnBlcsSTRCell)
    k = j(i);
    x = dispBlockCtrsVecArray(1,k);
    y = obtainyoflinegivenx (x, ptBvec, ptCvec);
    h = y - dispBlockCtrsVecArray(2, k);
    cVec = dispBlockCtrsVecArray(:, k);
    rectCoordsArray = [cVec-[w/2;0], cVec+[w/2;0], cVec+[w/2;h], ...
        cVec+[-w/2;h], cVec-[w/2;0]];
    BlcSTR = struct('width', w, 'height', h, 'baseCentreVec', cVec, ...
        'rectangCoordsArray', rectCoordsArray);
    dwnBlcsSTRCell(i) = {BlcSTR};
end

%% All the blocks cell
blcsSTRCell = [uppBlcsSTRCell, {ctrBlcsSTR}, dwnBlcsSTRCell];

%% Plotting
if want2plot
    hold on
    for i = 1:numUpperBlcs
       blcSTR = uppBlcsSTRCell{i};
       plot(blcSTR.rectangCoordsArray(1,:), blcSTR.rectangCoordsArray(2,:), ...
       'g-');
    end
    plot(ctrBlcsSTR.rectangCoordsArray(1,:), ...
        ctrBlcsSTR.rectangCoordsArray(2,:), 'k-');
    for i = 1:numDownBlcs
       blcSTR = dwnBlcsSTRCell{i};
       plot(blcSTR.rectangCoordsArray(1,:), blcSTR.rectangCoordsArray(2,:), 'r-');
    end
end
%%
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.