% geometricPreCalcSCR
% Description:
% Calculate the P support full-featured as well as, gross weight, toppling
% weight, transfer coefficient, and so on; in the case of the thirteen
% blocks based also on the geometric calculation (it is all the problem resume).
%
% Script that calculates parameters such as (ct) ratio
% Transfer (wi) weight of each block that is part of the rock mass,
% (Wip) called tipping weight (N) normal force between blocks,
% (Fi) destabilizing block (forceps) anchoring force
% Allowing the stabilization of the rock mass subjected to overturn.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% Initially generalization of geometry allowing arises
% Calculate the rollover for certain spatial conditions, but
% Which in turn taken through field parameters allows your
% Analysis.

% Called the destination folder containing scripts and analysis functions
% Of tipping.
display( 'Please write the path where ''volteoLab'' resides (without the last directory) ' )
mainPathString =input( 'For example: ''/Users/Alejo/Desktop/'' ' );
genPathString =genpath( [mainPathString, 'volteoLab Caso2/'] );
addpath( genPathString );

% Definition of a scale factor
scaleFact =10/0.90;

%% Definition of input parameters.
% Using this definition it is possible to clearly establish both
% Geometric parameters such as angles and heights, as well as the
% Geomechanical parameters such as friction angles between points
% Own importance and material parameters such as weight
% Unit.

% slope
slopeMeasuredSTR =struct( 'l2', 6.90*scaleFact, 'h2', 0.6*scaleFact, 'betaSdeg', 56.6, 'hh', 13.3*scaleFact );
% slip plane
slipPlaneSTR =struct( 'phiBdeg', 38.15, 'thetaDeg', 35.8 );
% rock mass
discontSTR =struct( 'dipDeg', 60, 'separation', 0.90*scaleFact, 'phiDdeg', 38.15, 'unitWeight', 25 );
%
% Beta = angle of inclination of the slope of cut relative to the
% Inlination.
%
% PhiBdeg = friction angle block assembly base under
% toppling.
%
% ThetaDeg = Angle of inclination of the main discontinuity
% To the horizontal.
%
% PhiDdeg = Angle of friction of the major discontinuity.
%
% unitWeight= UnitWeight own material unit weight of each block of rock.


%% Calculation of the overall geometry of rock slope.
hold on
slipplaneSlopeSTR =obtainslipslopestructure( slopeMeasuredSTR, slipPlaneSTR, true );

triangSTR =obtusescalenetriangfromtopo( slipplaneSlopeSTR, true );
adjustedTriangSTR =adjusttriangstructure2dipcoordsys( triangSTR, discontSTR );

nblcsCell =divideadjustedstructurebaseblocks( adjustedTriangSTR, discontSTR );
[ dispBlockCtrsVecArray, bPtIndx ] =divideadjustblcsinslipeside( adjustedTriangSTR, nblcsCell );

blcsSTRCell =createblcsinadjustedtriangstr( adjustedTriangSTR, dispBlockCtrsVecArray, bPtIndx, nblcsCell );
blcsUnrotSTRCell =blockstructuresinunrotsystem( blcsSTRCell, discontSTR, true );
set( gca, 'YDir', 'reverse' );
axis equal

%% Definition of variables prior to the calculation of the strength of 
%% support secondary entrance.
% Variable slope geometry without rotation
% betaB = Block inclination angle with respect to the horizontal real axis (x).
% betaB = betaDeg.
betaB =90 -discontSTR.dipDeg;
betaDeg =betaB;
% values are assumed
% betaGdeg =atan(slopeMeasuredSTR.h2 /slopeMeasuredSTR.l2) *180/pi;
% betaGdeg = Inclination angle of the slope crown with respect to the horizontal
% real axis (x).
betaGdeg = 3.5;
%
% thetaDeg = Inclination angle of the major discontinuity with respect to
% the horizontal real axis(x).
thetaDeg =slipPlaneSTR.thetaDeg;
%
% betaSdeg = Inclination cut angle of the slope with respect to the horizontal
% real axis (x).
betaSdeg =slopeMeasuredSTR.betaSdeg;
%
%%%%%
%
% Variable slope geometry with rotation
%betaGr =betaGdeg -betaDeg;
% betaGr = Angle of inclination of the crown of the slope of the plane
% Given x, y and this parallel and perpendicular to the base face
% block.
betaGr = -26.5;
% thetaR = Angle of inclination of the main slope discontinuity
% Relative to the determined rock x, y plane being parallel and this
% And perpendicular to the base face of the block.
thetaR =thetaDeg -betaDeg;
% betaSr =betaSdeg -betaDeg;
% betaSr = Inclination cut slope angle with respect to horizontal real axis (x), 
% y and this parallel and perpendicular to the base and face Block.
betaSr = 26.63;
% betaBr = Inclination angle of each block with respect to the major
% discontinuity line.
betaBr =0; %%% Ojo que no está generalizado
% phiBdeg  = Friction base angle of the set of bloks submitted to toppling
% failure.
phiBdeg =slipPlaneSTR.phiBdeg;

% Position and number of blocks
% Is calculated via the geometry of the amount reflected above
% Blocks of rock immersed in it and its respective position in an order
% Desendete growing in form from the crown to the same leg.
numTotBlocks =length(blcsUnrotSTRCell);
blcsAreStableTrueArray =obtainstableblocs( blcsUnrotSTRCell, betaB );
lastCrestStableBlcIndx =find( blcsAreStableTrueArray==0, 1 )-1;

% Calculation Block at crest in the slope.
% Is obtained through the bloqueCrestaRelIndx script, which may
% Using equation [29] the initial reference document.
bloqueCrestaRelIndx =positionblockatcrest(betaGr, thetaR, betaSr, ...
    betaDeg, betaSdeg, slipplaneSlopeSTR.h, discontSTR.separation, betaBr);
majorBlockSTR =blcsUnrotSTRCell{bloqueCrestaRelIndx +lastCrestStableBlcIndx};
radioEsbeltez =majorBlockSTR.height /majorBlockSTR.width; % slenderness ratio of the block at crest (m).
bloqueCresta =bloqueCrestaRelIndx;

numBlqs =numTotBlocks -lastCrestStableBlcIndx; % number of blocks in the calculate process.
posBloque =1:1:numBlqs;

% Variables rock mass
t =discontSTR.separation;
unitWeight =discontSTR.unitWeight; % old gamma
phiD =discontSTR.phiDdeg;

%% Calculation of the variable ct, wi, wip, Ny forceP through the call to
%% Corresponding script containing the detail of the process.

%calculovariospesosbrutoSCR
% Through the use of equations [8] Document
% Reference calculating the weight of each stone block is performed.
% Preprocessing
[ ag, as ] =calculaagas( betaGr, betaSr, thetaR );
% Calculate the unit weight of all blocks
i =1:1:numBlqs;

% pesobrutoagas.m 
% calculovariospesosbrutoSCR.m
% Calculate the gross weight at the serial blocks
% i =1:1:numCalcBlcs;
wiArray =zeros(1,numBlqs);
 for i=1 :numBlqs
  wi =pesobrutoagas( unitWeight, radioEsbeltez, bloqueCresta, i, t, ag, as );
  wiArray(i) =wi;
 end
 display (wiArray);

% pesogeometrico.m
% calculovariospesosgeomSCR.m
% Through the use of equations [34] Document
% Reference weight calculation rollover rock each block is performed.
% Calculate the toppling weight (geometric weight denominated in this software)
% at the serial blocks.
wipArray =zeros(1,numBlqs);
 for i=1 :numBlqs
  wip =pesogeometrico( unitWeight, t, radioEsbeltez, bloqueCresta, ...
        i, ag, betaB, betaBr, as, betaSr );
  wipArray(i) =wip;
 end
 display (wipArray);

% calculocoeftransSCR
% coeftransf.m
% Calculate the transfer coefficient at the serial blocks.
% Through the use of equations [34] Document
% Reference calculating the coefficient transfer takes
% For the failure by overturning a rock mass.
ct =coeftransf( radioEsbeltez, bloqueCresta, posBloque, phiD, ag, as, ...
    betaSr, betaGr, betaBr );
display(ct);

% normalstresscalcarray.m
% Calculate the normal contact force betwen blocks in the serial of analisys.
% By using equation [19], it is possible to calculate the
% Normal force between blocks taking into account the toppling weight, and
% Transfer coefficient for the iterative computation in
% Each posicipon the given set of blocks.
Narray =normalstresscalcarray( ct, wipArray, posBloque );

% fgeometrico.m
% Destabilization factor calculation block.
% With the use of the [37] This document is possible
% Destabilizing factor calculation block which allows
% Determine the sliding which all these subject
% Meet the specific cause inequality in turn fails
% toppling a rock slope.
fi  = fgeometrico(wiArray, betaB, wipArray, ct, Narray, betaBr, phiD, ...
    phiBdeg, posBloque);

% Calculation of the normal basal force blocks.
% Equation [35], to determine the normal reaction component
% Strength in the base of each block of rock subject to failure by
% toppling.
Ri =fuerzanormalbase( wiArray, betaB, phiD, betaBr, Narray, posBloque );

% Calculation of basal shear block.
% Equation [36], to determine the shear component reaction
% Strength in the base of each block of rock subject to failure by
% toppling.
Si =fuerzacortantebase( wiArray, betaB, betaBr, phiD, Narray, posBloque );

% Support Force
% Equation [38] provides the reaction force to be applied
% To contain the failure by toppling a whole which is
% Formed by the set of blocks subjected to sliding coupled with a
% Above normal force of the same block. This force must be
% Applied parallel to the base of the blocks.
forceP = stsoporte(wiArray, betaB, wipArray, ct, Narray, betaBr, phiD, ...
    phiBdeg, posBloque);
display(forceP);

% output_args =findindxslidingblcs( input_args );
% nIindx =11;
% nValueIminusOne =Narray( nIindx -1 );
% totalWeightSlidingblocs =6000.6;
% forceP = suppportforce( nValueIminusOne, totalWeightSlidingblocs, betaB, phiD, phiBdeg );

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.