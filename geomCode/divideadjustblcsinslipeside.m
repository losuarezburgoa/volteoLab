function [dispBlockCtrsVecArray, bPtIndx] = divideadjustblcsinslipeside ( ...
    adjustedTriangSTR, nblcsCell, want2plot)
%
% Description:
% This function gives the matrix structure at the blocks inmmersed at the
% triangular structure and so the serial location at the blocks in the same
% structure.
%
% Input(s):
%
% The structure of an obtuse scalene triangle, same structure as adjustedTriangSTR,
% with reduced side values but same internal angles (the two triangles are
% similar) and new coordiantes scaled from the origim, of a
% new triangle that contains exactly an integer number of blocks
% (triangNewSTR). 
%
% Cell of three elements giving the information of:
%   the number of blocks the side can attain, nblcsCell{1};
%   the constant width of the blocks, nblcsCell{2}; and
%   the distance (parallel to side b, the slip line) of the remainder,
%   nblcsCell{3}.
%
% Outputs(s):
%
% (dispBlockCtrsVecArray)
% Generate the matrix structure at the location ob the blocks into the
% triangular structure.
% 
% (bPtIndx)
% The serial number at the set at blocks located in the triangular
% structure analysis.



%% Inputs management
if nargin < 3
    want2plot = false;
end

%% Coordiantes of the triangle recovered form adjustedTriangSTR
ptBvec = adjustedTriangSTR.slipSideCell{3};
ptCvec = adjustedTriangSTR.crownSlopeCell{3};
ptAvec = adjustedTriangSTR.baseSlopeCell{3};

%% Obtain point E
% Point E is the projection paralell to y-axis of point B into side b.
x = ptBvec(1);
y = obtainyoflinegivenx (x, ptAvec, ptCvec);
ptEvec = [x; y];
% plot( ptEvec(1), ptEvec(2), '*c' );

distFromAtoE = norm(ptEvec);

%% Divide segment b into the number of divisions
slipSideVec = ptCvec - ptAvec;
b = norm(slipSideVec);
unitSlipeSideVec = slipSideVec / b;

% numBlocks = nblcsCell{1};
spacing = nblcsCell{2};
gapDist = nblcsCell{3};

divisionsArray = gapDist / 2:spacing:(b - gapDist/2);
blockCentersArray = 0.5 * (divisionsArray(2:end) + divisionsArray(1:end-1));

distsFromEarray = blockCentersArray - distFromAtoE;

%% Relocate point divisions 
% in order to have one division in point E
[~, closestPtIndx] = min(abs(distsFromEarray));
displacementDist = distsFromEarray(closestPtIndx);

displacedBlockCentersArray = blockCentersArray - displacementDist;

%% Delete or add points in extremes
% deleting
tempo = displacedBlockCentersArray(displacedBlockCentersArray > spacing/2);
displacedBlockCentersArray = tempo(tempo < (b-spacing/2));
% adding
if displacedBlockCentersArray(1) > (1.5*spacing)
    displacedBlockCentersArray = [(displacedBlockCentersArray(1) ...
        -1.5 * spacing), displacedBlockCentersArray];
end
if displacedBlockCentersArray(end) < (b - 1.5*spacing)
    displacedBlockCentersArray = [displacedBlockCentersArray, ...
        (displacedBlockCentersArray(end) + 1.5*spacing)];
end 

%% the index of B
relBlcsCentsArray = displacedBlockCentersArray - distFromAtoE;
bPtIndx = find(relBlcsCentsArray == 0);

%% Block centers coordiantes at base (on line b)
% The angle from x-axis to the slipSide 
iotaRad = acos(dot(unitSlipeSideVec, [1,0]));
dispBlockCtrsVecArray = [cos(iotaRad); -sin(iotaRad)] ...
    * displacedBlockCentersArray;

%% Plotting
if want2plot
    hold on
    plotobtusescalenetriang (adjustedTriangSTR);
    plot(dispBlockCtrsVecArray(1,:), dispBlockCtrsVecArray(2,:), 'rx');
end

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.