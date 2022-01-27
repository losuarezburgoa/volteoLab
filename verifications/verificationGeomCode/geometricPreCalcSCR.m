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
% display( 'Please write the path where ''volteoLab'' 
% resides (without the last directory) ' )
% mainPathString = input ...
%    ('For example: ''/media/ludger/datos/ownDevProgsMATLAB/''');
% genPathString =genpath( [mainPathString, 'volteoLab/'] );
% addpath(genPathString);

scaleFact =10/0.90;

%% Definition of input parameters.
% slope
slopeMeasuredSTR =struct( 'l2', 6.90*scaleFact, 'h2', 0.6*scaleFact, ...
    'betaSdeg', 56.6, 'hh', 13.3*scaleFact );
% slip plane
slipPlaneSTR =struct( 'phiBdeg', 38.15, 'thetaDeg', 35.8 );
% rock mass
discontSTR =struct( 'dipDeg', 60, 'separation', 0.90*scaleFact, ...
    'phiDdeg', 38.15, 'unitWeight', 25 );

%% Calculation of the overall geometry of rock slope.
hold on
slipplaneSlopeSTR = obtainslipslopestructure (slopeMeasuredSTR, ...
    slipPlaneSTR, true);

triangSTR =obtusescalenetriangfromtopo( slipplaneSlopeSTR, true );
adjustedTriangSTR =adjusttriangstructure2dipcoordsys( triangSTR, discontSTR );

nblcsCell =divideadjustedstructurebaseblocks( adjustedTriangSTR, discontSTR );
[ dispBlockCtrsVecArray, bPtIndx ] =divideadjustblcsinslipeside( adjustedTriangSTR, nblcsCell );

blcsSTRCell =createblcsinadjustedtriangstr( adjustedTriangSTR, dispBlockCtrsVecArray, bPtIndx, nblcsCell );
blcsUnrotSTRCell =blockstructuresinunrotsystem( blcsSTRCell, discontSTR, true );
set( gca, 'YDir', 'reverse' );
axis equal

%% Defining the secondary input variables for the calculation of the support force.
% Variable slope geometry without rotation
betaB =90 -discontSTR.dipDeg;
betaDeg =betaB;
betaGdeg =atan(slopeMeasuredSTR.h2 /slopeMeasuredSTR.l2) *180/pi;
thetaDeg =slipPlaneSTR.thetaDeg;
betaSdeg =slopeMeasuredSTR.betaSdeg;

% Variable slope geometry with rotation
betaGr =betaGdeg -betaDeg;
thetaR =thetaDeg -betaDeg;
betaSr =betaSdeg -betaDeg;
betaBr =0; %%% Ojo que no está generalizado

phiBdeg =slipPlaneSTR.phiBdeg;

% Position and number of blocks
numTotBlocks =length(blcsUnrotSTRCell);
blcsAreStableTrueArray =obtainstableblocs( blcsUnrotSTRCell, betaB );
lastCrestStableBlcIndx =find( blcsAreStableTrueArray==0, 1 )-1;

% Calculation Block at crest in the slope.
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

% Preprocessing
[ ag, as ] =calculaagas( betaGr, betaSr, thetaR );
i =1:1:numBlqs;

% pesobrutoagas.m 
% calculovariospesosbrutoSCR.m
% Calculate the gross weight at the serial blocks
wiArray =zeros(1,numBlqs);
 for i=1 :numBlqs
  wi =pesobrutoagas( unitWeight, radioEsbeltez, bloqueCresta, i, t, ag, as );
  wiArray(i) =wi;
 end
display (wiArray);

% pesogeometrico.m
% calculovariospesosgeomSCR.m
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
ct =coeftransf( radioEsbeltez, bloqueCresta, posBloque, phiD, ag, as, ...
    betaSr, betaGr, betaBr );
display(ct);

% normalstresscalcarray.m
% Calculate the normal contact force betwen blocks in the serial of analisys.
Narray =normalstresscalcarray( ct, wipArray, posBloque );

% fuerzanormalbase.m
% Calculate the basal normal force at the serial blocks of analysis.
Ri =fuerzanormalbase( wiArray, betaB, phiD, betaBr, Narray, posBloque );
% fuerzacortantebase.m
% Calculate the basal shear force at the serial blocks of analysis.
Si =fuerzacortantebase( wiArray, betaB, betaBr, phiD, Narray, posBloque );

% stsoporte.m
% Calculate the support force at all problem wich guarantees equilibrium at
% the sistem of blocks.
forceP =stsoporte( wiArray, betaB, wipArray, ct, Narray, betaBr, phiD, phiBdeg, posBloque );
display( forceP );

% output_args =findindxslidingblcs( input_args );
% nIindx =11;
% nValueIminusOne =Narray( nIindx -1 );
% totalWeightSlidingblocs =6000.6;
% forceP =suppportforce( nValueIminusOne, totalWeightSlidingblocs, betaB, phiD, phiBdeg );
% 

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.