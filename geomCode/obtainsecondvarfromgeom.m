function [ secondVariablesSTR ] =obtainsecondvarfromgeom ...
    ( slopeMeasuredSTR, slipPlaneSTR, discontSTR )
% Description:
% This function gives the geometric arguments used to calculate the
% toppling failure as well as angles, number of blocks at the triangular
% structure, distances of the break points at the triangular structure,
% unit weight at the material of the slope and the phisical parameters as
% well as the phiD, and phiB, angles wich are the internal friction angles
% of the discontinuities.
%
% Input(s):
% slopeMeasuredSTR = Geometrical parameters as well as l2, h2, hh as follows
% h2 = Vertical distance from the start of slope crown to an end.
% l2 = Horizontal distance from the start of slope crown to an end.
% hh = Vertical distance from the real distance at the begining of the problem
% to the end at slope crown.
%
% (slipPlaneSTR) Slope Base parameters as well as the phiBdeg, thetaDeg
% wich the friction angle of the slope fault base and the thetaDeg what are
% the inclination of the slope fault base.
% The discontinuities structure (discontSTR), composed by:
%    discontSTR.dipDeg, which is the dip angle of the discontinuities (in
%    sexagesimal degrees);
%    discontSTR.separation, which is the constant spacing de
%    discontinuities have.
% Output(s):
% The parameters at the triangular ultimate structure.
% secondVariablesSTR =struct( 'h', h, 'betaGrDeg', betaGrDeg, ...
%     'betaDeg', betaDeg, 'betaSrDeg', betaSrDeg, 'thetaRdeg', thetaRdeg, ...
%     'unitWeight', unitWeight, 't', t, 'betaBdeg', betaBdeg, ...
%     'betaSdeg', betaSdeg, 'betaBrDeg', betaBrDeg, 'phiDdeg', phiDdeg, ...
%     'phiBdeg', phiBdeg, 'thetaDeg', thetaDeg, ...
%     'mBlcSlendRatio', mBlcSlendRatio, 'numCalcBlcs', numCalcBlcs );
%
%%%%%%%%%%%%%%%%%
% [ secondVariablesSTR ] =obtainsecondvarfromgeom ...
%    ( slopeMeasuredSTR, slipPlaneSTR, discontSTR )
%%%%%%%%%%%%%%%%%

%% Calculation of the problem geometry.
slipplaneSlopeSTR =obtainslipslopestructure(slopeMeasuredSTR, slipPlaneSTR);

triangSTR =obtusescalenetriangfromtopo( slipplaneSlopeSTR );
adjustedTriangSTR =adjusttriangstructure2dipcoordsys(triangSTR, discontSTR);

nblcsCell =divideadjustedstructurebaseblocks(adjustedTriangSTR, discontSTR);
[ dispBlockCtrsVecArray, bPtIndx ] =divideadjustblcsinslipeside ...
    ( adjustedTriangSTR, nblcsCell );

blcsSTRCell =createblcsinadjustedtriangstr( adjustedTriangSTR, ...
    dispBlockCtrsVecArray, bPtIndx, nblcsCell );
blcsUnrotSTRCell =blockstructuresinunrotsystem( blcsSTRCell, discontSTR );

%% Defining the secondary input variables.

% Variables of the slope geometry in the unrotated system.
% angles
betaBdeg =90 -discontSTR.dipDeg;
betaDeg =betaBdeg;
betaGdeg =atan(slopeMeasuredSTR.h2 /slopeMeasuredSTR.l2) *180/pi;
thetaDeg =slipPlaneSTR.thetaDeg;
betaSdeg =slopeMeasuredSTR.betaSdeg;
% distances
h =slipplaneSlopeSTR.h;

% Variables of the slip surface
phiBdeg =slipPlaneSTR.phiBdeg;

% Variables of the slope geometry in the rotated system.
% It is an orthogonal coordiante system such that x- and y-axes are,
% respectively, perpendicular and paralell to the dip of the dominant
% discontinuity set.
betaGrDeg =betaGdeg -betaDeg;
thetaRdeg =thetaDeg -betaDeg;
betaSrDeg =betaSdeg -betaDeg;
betaBrDeg =0;

% Rock mass variables
% discontinuities
t =discontSTR.separation;
phiDdeg =discontSTR.phiDdeg;
% rock material
unitWeight =discontSTR.unitWeight;

%% Number of blocks and position of the principal block
% Total number of blocks on the slope
numTotBlcs =length( blcsUnrotSTRCell );

% Analysing the stable blocks by the height to with ratio (slederness
% ratio)
blcsAreStableTrueArray =obtainstableblocs( blcsUnrotSTRCell, betaBdeg );
% The uppermost block susceptible to toppling
lastCrestStableBlcIndx =find(blcsAreStableTrueArray==0, 1) -1;

% Block at crest, i.e. the m-block defined by its indexm, the mIndx.
mIndx =positionblockatcrest(betaGrDeg, thetaRdeg, betaSrDeg, ...
    betaDeg, betaSdeg, h, t, betaBrDeg);

%% Slenderness ratio of m-block (major block at crest)
% The slederness ratio is defined as the ratio of the height of m-block to
% the block thikness.
majorBlockSTR =blcsUnrotSTRCell{mIndx +lastCrestStableBlcIndx};%
mBlcSlendRatio =majorBlockSTR.height /majorBlockSTR.width;

%% Definig blocks index for calculation
% Number of blocks for the calculation
numCalcBlcs =numTotBlcs -lastCrestStableBlcIndx;

%% Making the structure
secondVariablesSTR =struct( 'h', h, 'betaGrDeg', betaGrDeg, ...
    'betaDeg', betaDeg, 'betaSrDeg', betaSrDeg, 'thetaRdeg', thetaRdeg, ...
    'unitWeight', unitWeight, 't', t, 'betaBdeg', betaBdeg, ...
    'betaSdeg', betaSdeg, 'betaBrDeg', betaBrDeg, 'phiDdeg', phiDdeg, ...
    'phiBdeg', phiBdeg, 'thetaDeg', thetaDeg, ...
    'mBlcSlendRatio', mBlcSlendRatio, 'numCalcBlcs', numCalcBlcs );

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.