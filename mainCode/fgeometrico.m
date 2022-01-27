function [ fi ] =fgeometrico( wi, betaB, wip, ct, N, betaBr, phiD, phiB, i)
% Description:
% Calculate the sliding factor of instability at the serial numbers 
% that contain the set of toppling and sliding failure.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :wi, wip, ct, N.
%
% Input(s):
% wi          =   matrix that contain the set of weight in the block
%                 toppling failure.
% ct          =   matrix that contain the results of the transfer coeficient for a set
% wip         =   matrix that contain the results of the toppling weight for a set
%                 of block that are under toppling failure.
% N           =   matrix of the normal contact force between toppling blocks at the serial numbers 
%                 that contain the set of toppling and sliding failure. 
% i           =   matrix of the serial number at all block toppling is to (1...nblocks).
% phiB        =   Friction angle of the principal base block discontinuity.
% phiD        =   Friction angle of the principal contact block discontinuity.
% betaBr      =   Angle of inclination of the block base in the serial
%                 number at (1...n).
% betaB       =   Angle of inclination of the imaginarious axis X with respect to
%                 the real axis (x), and it is the inclination of the base of the serial 
%                 blocks with respecto to the real axis (x).
%
% Output(s):
% fi          =   matrix of the sliding factor of instability at the serial numbers 
%                 that contain the set of toppling and sliding failure.
%
% Example 1
% wi    =    (8.7267, 9.3607, 9.9946, 10.6285, 11.2625, 11.8964, 12.5303, 
%            13.1643, 13.7982, 14.4321, 15.0661, 15.7000, 14.6801, 13.6602, 
%            12.6403, 11.6203, 10.6004, 9.5805, 8.5606, 7.5407,  6.5208, 
%            5.5008, 4.4809, 3.4610, 2.4411, 1.4212, 0.4013];
%
% ct    =    ( 0.7205, 0.7383, 0.7539, 0.7677, 0.7801, 0.7912, 0.8013, 0.8104, 
%             0.8187, 0.8264, 1.0143, 0.9190, 0.9114, 0.9022, 0.8909, 0.8767, 
%             0.8581, 0.8330, 0.7970, 0.7413, 0.6436, 0.4271, -0.4594, 3.6661, 
%             1.6967, 1.4007, 1.2812];
%
% wip   =    (0.0313, 0.1652, 0.2992, 0.4332, 0.5671, 0.7011, 0.8351, 
%            0.9691, 1.1030, 1.2370, 1.3710, 1.8317, 1.5934, 1.3508, 
%            1.1027, 0.8469, 0.5807, 0.2992, -0.0057, -0.3490, -0.7624,
%            -1.3253, -2.3103, -5.6767, 8.7707, 1.5555, 0.2879];
%
% N     =    (0.0313, 0.1878, 0.4378, 0.7633, 1.1531, 1.6006, 2.1015, 2.6530,
%            3.2530, 3.9002, 4.5942, 6.4916, 7.5591, 8.2402, 8.5370, 8.4525,
%            7.9910, 7.1563, 5.9555, 4.3975, 2.4975, 0.2821, -2.1898, -4.6707, 
%            -8.3525, -12.6163, -17.3837);
%
% i     =    (1:1:27);
% 
% betaB       =    25;
% betaBr      =    0; 
% phiD        =    43.25;
% phiB        =    43.25;
% 
% Answer:
%
% fi    =    (0.4933, 0.4845, 0.4788, 0.4749, 0.4721, 0.4699, 0.4682, 0.4669, 0.4657,
%             0.4647, 0.4639, 0.4047, 0.4439, 0.4611, 0.4799, 0.5005, 0.5231, 0.5483,
%             0.5763, 0.6077, 0.6430, 0.6827, 0.7267, 0.7663, 0.8828, 0.9758, 1.0825);

%%%%%%%%%%
%[ fi ] =fgeometrico( wi, betaB, wip, ct, N, betaBr, phiD, phiB, i)
%%%%%%%%%%

betaBrRad =betaBr *pi/180;      
betaBRad =betaB *pi/180;          
phiDRad = phiD *pi/180;     
phiBRad = phiB *pi/180; 

numVals =length(i);            
fi0 =zeros(1,numVals);          
fi1 = zeros(1,numVals);          
                                

fi0(1) = ((wi(1)* sin(betaBRad))- ( (wip(1) +((0)-1)*(0))* ((cos(betaBrRad)) + (tan(phiD)*sin(betaBrRad)))))...
    / (( (wi(1) * cos(betaBRad)) - (((wip(1)) + ((0) -1) * (0)) * ((tan(phiDRad))*(cos(betaBrRad))) - (sin(betaBrRad))) )* (tan(phiBRad))); 

for i=2 :numVals
    
    fi1(i) = ((wi(i)* sin(betaBRad))- ( (wip(i) +((ct(i-1))-1)*(N(i-1)))* ((cos(betaBrRad)) + (tan(phiD)*sin(betaBrRad)))))...
        / (( (wi(i) * cos(betaBRad)) - (((wip(i)) + ((ct(i-1)) -1) * (N(i-1))) * ((tan(phiDRad))*(cos(betaBrRad))) - (sin(betaBrRad))) )* (tan(phiBRad)));
end

fi = fi0 + fi1;
display (fi)
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.