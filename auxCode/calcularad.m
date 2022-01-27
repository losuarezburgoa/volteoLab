function [ betaSrRad, betaBRad , phiDRad, betaGrRad ] =calcularad( betaSr, betaB, betaGr, phiD  )
% Description:
% Transform angle in degrees to radians.
%
% External sub-function(s) :none.
%
% Input(s):
% betaGr =  angle of slope crown with respect at the imaginarious axis (X).
% betaSr =  angle of cut slope with respect at the imaginarious axis (X).
% betaB =   angle of the imaginarious axis (X) with the real horizontal axis
%           (x).
% phiD =    friction angle of principal fault line of block discontinuities.
%
% Output(s):
% Example 1
% [ betaSrRad, betaBRad , phiDRad, betaGrRad ] =calcularad( 16, 45, 24, 45  )
%
% Answer:
% [ betaSrRad, betaBRad , phiDRad, betaGrRad ] =  (0.2793,  0.7854, 0.7854,
%                                                  0.4189)
%
% Example 2
% [ betaSrRad, betaBRad , phiDRad, betaGrRad ] =calcularad( 17, 35, 28, 49.55  )
%
% Answer:
% [ betaSrRad, betaBRad , phiDRad, betaGrRad ] =  (0.2967,  0.6109, 0.8648,
%                                                   0.4887)  
%
  betaSrRad = betaSr *pi/180; 
  betaBRad = betaB *pi/180;
  phiDRad = phiD *pi/180;
  betaGrRad  =betaGr *pi/180;
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.