function [supportForce, blcsBaseNormalForce, blcsBaseTangentForce, ...
    secondVariablesSTR] = volteolab (slopeMeasuredSTR, slipPlaneSTR, ...
    discontSTR)
%
% Description:
% The computer program for 2D toppling modeling, named volteoLab, allows
% interpret the toppling mode of failure of a set of rock-blocks at road
% slopes; all of these by analyzing under a continuum frame taking into 
% account the contact and gravitational forces of the blocks. The analysis is
% done with the limit equilibrium method proposed Liu et al. (2008) [1], which
% starts from the static method given in Goodman and Bray (1976) [2]. In this
% method, the calculation of forces, such as the weight of each rock-block,
% where the base frictional force is also taken into account. On the other
% hand, it is used the concept of transfer coefficient (Ïˆ) propossed by 
% Liu et al. (2008) [1]. Under this concept, there is relation of the
% gravitational force components with the spatial location of each block,
% those against a strategic reference block (called crest block [1] and with a
% location index of m), where the physical meaning divides the slope of
% analysis in two zones: Shear and Crown zones. With the transference
% coefficient and the location of the crown block, it is possible to identify
% vulnerable parts in the slope, and especially it is possible to have a
% numeric value of another variable, which will define the global stability of
% the slope, this that is a horizontal force at the foot of the slope called
% here nailing force (P). If this force is negative, the slope is stable, and
% if the force is positive, the slope is unstable. Besides this, the order of
% magnitude of this force will tell how stable of unstable is the slope to
% this failure mode, and from this force a stabilization measure may proposed.
% The software is restricted to road slopes because of the simple geometry the
% slope cuts have in road works.
%
% Keywords: Rock mass, highway, computer program, toppling failure mode.
%
% Co-authored-by: Luís Alejandro Erazo-Martinez <laerazoma@unal.edu.co>
% Co-authored-by: Ludger O. Suarez-Burgoa <losuarezb@unal.edu.co>
%
% Reference(s):
%
% [0] L.A. Erazo-Martinez and L.O. Suarez-Burgoa, 2021. volteoLab: Computer
% program for the modeling of toppling instability at slopes in road cuts. 
% Boleti­n de Ciencias de la Tierra, Vol. 51. 
% https://revistas.unal.edu.co/index.php/rbct
%
% [1] C.H. Liu and M.B. Jaksa and A.G. Meyers, 2009. A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, Vol.46: 1-9. 
%
% [2] R.E. Goodman and J.W. Bray, 1976. Toppling of rock slopes. Proceedings of
% the Specialty Conference on Rock Engineering for Foundations and Slopes, 
% Boulder Colorado (Aug): 201-234. 
%
% External sub-function(s):
% Input(s): slopeMeasuredSTR, slipPlaneSTR, discontSTR.
% Output(s): supportForce, blcsBaseNormalForce, blcsBaseTangentForce, ...
% secondVariablesSTR
%
% Example1: 
% Example2:


%% Calculation of the problem geometry.
slipplaneSlopeSTR = obtainslipslopestructure (slopeMeasuredSTR, slipPlaneSTR);

triangSTR = obtusescalenetriangfromtopo (slipplaneSlopeSTR);
adjustedTriangSTR = adjusttriangstructure2dipcoordsys (triangSTR, discontSTR);

nblcsCell = divideadjustedstructurebaseblocks(adjustedTriangSTR, discontSTR);
[dispBlockCtrsVecArray, bPtIndx] = divideadjustblcsinslipeside ...
    (adjustedTriangSTR, nblcsCell);

blcsSTRCell = createblcsinadjustedtriangstr (adjustedTriangSTR, ...
    dispBlockCtrsVecArray, bPtIndx, nblcsCell);
blcsUnrotSTRCell = blockstructuresinunrotsystem (blcsSTRCell, discontSTR);

%% Defining the secondary input variables.

% Variables of the slope geometry in the unrotated system.
% angles
betaBdeg = 90 - discontSTR.dipDeg;
betaDeg = betaBdeg;
betaGdeg = atan (slopeMeasuredSTR.h2 / slopeMeasuredSTR.l2) * 180/pi;
thetaDeg = slipPlaneSTR.thetaDeg;
betaSdeg = slopeMeasuredSTR.betaSdeg;
% distances
h = slipplaneSlopeSTR.h;

% Variables of the slip surface
phiBdeg = slipPlaneSTR.phiBdeg;

% Variables of the slope geometry in the rotated system.
% It is an orthogonal coordiante system such that x- and y-axes are,
% respectively, perpendicular and paralell to the dip of the dominant
% discontinuity set.
betaGrDeg = betaGdeg - betaDeg;
thetaRdeg = thetaDeg - betaDeg;
betaSrDeg = betaSdeg - betaDeg;
betaBrDeg = 0;

% Rock mass variables
% discontinuities
t = discontSTR.separation;
phiDdeg = discontSTR.phiDdeg;
% rock material
unitWeight = discontSTR.unitWeight;

%% Number of blocks and position of the principal block
% Total number of blocks on the slope
numTotBlcs = length(blcsUnrotSTRCell);

% Analysing the stable blocks by the height to with ratio (slederness
% ratio)
blcsAreStableTrueArray = obtainstableblocs (blcsUnrotSTRCell, betaBdeg);
% The uppermost block susceptible to toppling
lastCrestStableBlcIndx = find(blcsAreStableTrueArray==0, 1) -1;

% Block at crest, i.e. the m-block defined by its indexm, the mIndx.
mIndx = positionblockatcrest (betaGrDeg, thetaRdeg, betaSrDeg, ...
    betaDeg, betaSdeg, h, t, betaBrDeg);

%% Slenderness ratio of m-block (major block at crest)
% The slederness ratio is defined as the ratio of the height of m-block to
% the block thikness.
majorBlockSTR = blcsUnrotSTRCell{mIndx +lastCrestStableBlcIndx};
mBlcSlendRatio = majorBlockSTR.height / majorBlockSTR.width;
% The support force is highly sensitive with the 'mBlcSlendRatio'.
% mBlcSlendRatio = 4;
% mBlcSlendRatio = 6.8920;
% Perform a sensitivity analysis of this variable.

%% More variables
[ag, as] = calculaagas (betaGrDeg, betaSrDeg, thetaRdeg);

%% Definig blocks index for calculation
% Number of blocks for the calculation
numCalcBlcs = numTotBlcs - lastCrestStableBlcIndx;

%% Making the structure
secondVariablesSTR = struct('h', h, 'betaGrDeg', betaGrDeg, ...
    'betaDeg', betaDeg, 'betaSrDeg', betaSrDeg, 'thetaRdeg', thetaRdeg, ...
    'unitWeight', unitWeight, 't', t, 'betaBdeg', betaBdeg, ...
    'betaSdeg', betaSdeg, 'betaBrDeg', betaBrDeg, 'phiDdeg', phiDdeg, ...
    'phiBdeg', phiBdeg, 'thetaDeg', thetaDeg, 'betaGdeg', betaGdeg, ...
    'mBlcSlendRatio', mBlcSlendRatio, 'numCalcBlcs', numCalcBlcs, ...
    'mIndx', mIndx, 'as', as, 'ag', ag);
% -------------------------------------------------------------------------

%% The calculation blocks index array
calcBlcsArray = 1:1:numCalcBlcs;

%% Calculating the gross weight of blocks
% based on script: calculovariospesosbrutoSCR
wiArray = zeros(1,numCalcBlcs);
for i=1:numCalcBlcs
    wi = pesobrutoagas (unitWeight, mBlcSlendRatio, mIndx, i, t, ag, as);
    wiArray(i) = wi;
end
% display (wiArray);

%% Calculating the geometric weight of blocks
% based on script: calculovariospesosgeomSCR
wipArray = zeros(1, numCalcBlcs);
for i = 1:numCalcBlcs
    wip = pesogeometrico (unitWeight, t, mBlcSlendRatio, mIndx, ...
        i, ag, betaBdeg, betaBrDeg, as, betaSrDeg);
    wipArray(i) = wip;
end

%% Calculating the transference coefficient
% based on script: calculocoeftransSCR
ct = coeftransf (mBlcSlendRatio, mIndx, calcBlcsArray, phiDdeg, ag, as, ...
    betaSrDeg, betaGrDeg, betaBrDeg);

%% Normal stresses on the blocks bases
normalForceArray = normalstresscalcarray (ct, wipArray, calcBlcsArray);

%% Normal and shear forces on the block bases
% normal force
blcsBaseNormalForce = fuerzanormalbase (wiArray, betaBdeg, phiDdeg, ...
    betaBrDeg, normalForceArray, calcBlcsArray);
% shear force
blcsBaseTangentForce = fuerzacortantebase (wiArray, betaBdeg, betaBrDeg, ...
    phiDdeg, normalForceArray, calcBlcsArray);

%% Calculating the support force
% The support force is that force necessary to stabilize the slope against
% toppling, assumed to be applied in the direction parallel to the base of
% the block.
supportForce = stsoporte (wiArray, betaBdeg, wipArray, ct, normalForceArray, ...
    betaBrDeg, phiDdeg, phiBdeg, calcBlcsArray );
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Marti­nez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.
