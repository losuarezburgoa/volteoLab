% allfunctionsSCR13bloques.m
% Description:
% Calculate the P support full-featured as well as, gross weight, toppling
% weight, transfer coefficient, and so on; in the case of the thirteen
% blocks.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
%% Defining the input values
h = 93.4;
betaGrDeg =-26.5;
betaDeg = 30;
betaSrDeg =26.6;
thetaRdeg =5.8;
unitWeight =25;
t =10;
betaBdeg = 30;
betaSdeg = 56.6;
betaBrDeg = 0;
phiDdeg = 38.15;
phiBdeg = 38.15;
thetaDeg = 35.8;
mBlcSlendRatio =4;
numCalcBlcs = 13;
calcBlcsArray =1:1:numCalcBlcs;

%% Calling the scripts
% preprocessing
[ ag, as ] =calculaagas( betaGrDeg, betaSrDeg, thetaRdeg );
display( ag );
display( as );

%% Calculate the block at crest
bloqueCresta  = bloqueatcresta( ag,betaBdeg, betaSrDeg, betaSdeg, as, h, t );
display( bloqueCresta );

% pesobrutoagas.m 
% calculovariospesosbrutoSCR.m
% Calculate the gross weight at the serial blocks
% i =1:1:numCalcBlcs;
wiArray =zeros(1,numCalcBlcs);
 for i=1 :numCalcBlcs
  wi =pesobrutoagas( unitWeight, mBlcSlendRatio, bloqueCresta, i, t, ag, as );
  wiArray(i) =wi;
 end
display (wiArray);

% pesogeometrico.m
% calculovariospesosgeomSCR.m
% Calculate the toppling weight (geometric weight denominated in this software)
% at the serial blocks.
wipArray =zeros(1,numCalcBlcs);
 for i=1 :numCalcBlcs
  wip =pesogeometrico( unitWeight, t, mBlcSlendRatio, bloqueCresta, ...
        i, ag, betaBdeg, betaBrDeg, as, betaSrDeg );
  wipArray(i) =wip;
 end
display (wipArray);

% calculocoeftransSCR
% coeftransf.m
% Calculate the transfer coefficient at the serial blocks.
ct =coeftransf( mBlcSlendRatio, bloqueCresta, calcBlcsArray, phiDdeg, ag, as, ...
    betaSrDeg, betaGrDeg, betaBrDeg );
display(ct);

% normalstresscalcarray.m
% Calculate the normal contact force betwen blocks in the serial of analisys.
Narray =normalstresscalcarray( ct, wipArray, calcBlcsArray );
display( Narray );

% fgeometrico.m
% calculate the relationship betwen the resistant forces and the acting forces
% in the sliding failure.
fi  =fgeometrico( wiArray, betaBdeg, wipArray, ct, Narray, betaBrDeg, phiDdeg, phiBdeg, calcBlcsArray);

% fuerzanormalbase.m
% Calculate the basal normal force at the serial blocks of analysis.
Ri =fuerzanormalbase( wiArray, betaBdeg, phiDdeg, betaBrDeg, Narray, calcBlcsArray );
display(Ri);
% fuerzacortantebase.m
% Calculate the basal shear force at the serial blocks of analysis.
Si =fuerzacortantebase( wiArray, betaBdeg, betaBrDeg, phiDdeg, Narray, calcBlcsArray );
display(Si);

% stsoporte.m
% Calculate the support force at all problem wich guarantees equilibrium at
% the sistem of blocks.
forceP =stsoporte( wiArray, betaBdeg, wipArray, ct, Narray, betaBrDeg, phiDdeg, phiBdeg, calcBlcsArray );
display( forceP );

% Result.
% forceP =0.9932;

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.