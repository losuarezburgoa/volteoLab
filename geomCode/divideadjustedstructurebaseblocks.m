function [nblcsCell, nblcsNewCell, triangNewSTR] = ...
    divideadjustedstructurebaseblocks (adjustedTriangSTR, discontSTR)
%
% Description:
% This function gives three possible alternatives to divide the scalene
% obtuse triangle in their side b (i.e. the side where the slip occurs)
% into n parts of blocks, taking into account the block orientation which
% is given relative to the triangle orientation.
% The first alternative is to return the integer number of blocks that
% can be divided by the discontinuties spacing, and a distance that
% represent the remainder of length the side b has without a block. 
% The second alternative is to recalculate an 'exact' real number of a new
% spacing in order to have an exact number of integers of blocks that
% divide the side b (i.e. the side where the slip occurs).
% The third alternative is to reconstruct a small but similar triangle 
% in order to have an exact integer numbers of blocks with the given 
% discontinuity spacing.
%
% Input(s):
% The triangle structure (adjustedTriangSTR).
% The discontinuities structure (discontSTR), composed by:
%    discontSTR.dipDeg, which is the dip angle of the discontinuities (in
%    sexagesimal degrees);
%    discontSTR.separation, which is the constant spacing de
%    discontinuities have.
%
% Outputs(s):
% Cell of three elements giving the information of:
%   the number of blocks the side can attain, nblcsCell{1};
%   the constant width of the blocks, nblcsCell{2}; and
%   the distance (parallel to side b, the slip line) of the remainder,
%   nblcsCell{3}.
%
% Cell of three elements giving the same information above mentioned, but
% with the width of the blocks recalculated.
%
% The structure of an obtuse scalene triangle, same structure as adjustedTriangSTR,
% with reduced side values but same internal angles (the two triangles are
% similar) and new coordiantes scaled from the origim, of a
% new triangle that contains exactly an integer number of blocks
% (triangNewSTR). 
%
% Example1:
% adjustedTriangSTR =struct( 'slipSideCell', {{7.7862, 123.4354, [4.0459; 0.6]}}, ...
%     'baseSlopeCell', {{4.7445, 30.5646, [0;0]}}, 'crownSlopeCell', ...
%     {{4.0901, 26, [6.0510;4.9]}} );
% discontSTR =struct( 'dipDeg', 72, 'separation', 0.43 ); 
%
% Example2:
% adjustedTriangSTR =struct( 'slipSideCell', {{15.6360, 126.9114, [6.9824; 0.6]}}, ...
%     'baseSlopeCell', {{10.3886, 32.0886, [0;0]}}, 'crownSlopeCell', ...
%     {{7.0081, 21, [12.4875; 9.41]}} );
% discontSTR =struct( 'dipDeg', 61, 'separation', 0.90 );
%


%% Input management
bsideUnitVec = (adjustedTriangSTR.crownSlopeCell{3} - ...
    adjustedTriangSTR.baseSlopeCell{3}) / ...
    norm(adjustedTriangSTR.crownSlopeCell{3} - ...
    adjustedTriangSTR.baseSlopeCell{3});
thetaRad = acos(dot(bsideUnitVec, [1, 0]));
% thetaDeg =thetaRad *180/pi;

% From triangle structure
b = adjustedTriangSTR.slipSideCell{1};
% From discontinuities structure
discontSep = discontSTR.separation;

%% Maximum number of blocks
discontSepProj = discontSep * (dot([1, 0], bsideUnitVec));
nblcs = floor(b / discontSepProj);
nblcsCell = {nblcs, discontSepProj, mod(b, discontSepProj)};

%% New discontinuity spacing
discontSepProjNew = b / nblcs;
nblcsNew = floor(b / discontSepProjNew);
nblcsNewCell = {nblcsNew, discontSepProjNew, mod(b, discontSepProjNew)};

%% New triangle based on new slip-side length
bAngleDeg = adjustedTriangSTR.slipSideCell{2};
aAngleDeg = adjustedTriangSTR.baseSlopeCell{2};
cAngleDeg = adjustedTriangSTR.crownSlopeCell{2};

bNew = b -mod(b, discontSepProj);
aNew = bNew * (sin(aAngleDeg*pi/180) / sin(bAngleDeg*pi/180));
cNew = bNew * (sin(cAngleDeg*pi/180) / sin(bAngleDeg*pi/180));

ptAvec = zeros(2, 1);
ptBvec = ptAvec + cNew * [cos(thetaRad - aAngleDeg*pi/180); ...
      sin(thetaRad - aAngleDeg * pi/180)];
ptCvec = ptAvec + bNew * [cos(thetaRad); sin(thetaRad)];

slipSideCell = {bNew, bAngleDeg, ptBvec};
baseSlopeCell = {aNew, aAngleDeg, ptAvec};
crownSlopeCell = {cNew, cAngleDeg, ptCvec};

triangNewSTR = struct( 'slipSideCell', {slipSideCell}, ...
    'baseSlopeCell', {baseSlopeCell}, ...
    'crownSlopeCell', {crownSlopeCell});

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.