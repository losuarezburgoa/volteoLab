% allfunctions34bloques.m
% Description:
% Calculate the P support full-featured as well as, gross weight, toppling
% weight, transfer coefficient, and so on; in the case of the 34
% blocks.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
%% Defining the input values
H = 48;
betaGr =-10;
betaDeg = 25;
betaSr =30;
thetaR =17;
unitWeight =25;
radioEsbeltez =6.892;
t =2;
numBlqs = 34;
betaB = 25;
betaS = 55;
betaBr = 0;
posBloque =1:1:numBlqs;
phiD = 39;
phiBdeg = 39;
theta = 42;


%% Calling the scripts
% preprocessing
[ ag, as ] =calculaagas( betaGr, betaSr, thetaR );
display( ag );
display( as );

%% Calculate the block at crest
bloqueCresta  =positionblockatcrest(betaGr, thetaR, betaSr, betaDeg, betaS, H, t, betaBr);
display( bloqueCresta );

% pesobrutoagas.m 
% calculovariospesosbrutoSCR.m
% Calculate the gross weight at the serial blocks
i =1:1:numBlqs;
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

% fgeometrico.m
% calculate the relationship betwen the resistant forces and the acting forces
% in the sliding failure.
fi  =fgeometrico( wiArray, betaB, wipArray, ct, Narray, betaBr, phiD, phiBdeg, posBloque);

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

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.