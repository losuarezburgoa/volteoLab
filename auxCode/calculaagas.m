function [ag, as] = calculaagas (betaGr, betaSr, thetaR)
% Description:
% Calculate geometric relationship between the angle of slope crown and the
% angle of principal fault line with respect at the imaginarious axis (X),
% denominated (ag), and the relationship between the angle of cut slope and
% the angle of principal fault line with respect at the imaginarious axis
% (X), denominated (as).
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :deg2rad.
%
% Input(s):
% betaGr = angle of slope crown with respect at the imaginarious axis (X).
% betaSr = angle of cut slope with respect at the imaginarious axis (X).
% thetaR = angle of principal fault line with respect at the imaginarious
%          axis (X).
%
% Output(s):
 
% Example 1
% [ ag, as ] =calculaagas( 16, 50, 24 );
%
% Answer:
% ag = -0.1585
% as = 0.5548
%
% Example 2
% [ ag, as ] =calculaagas( 16, 55, 24 );
%
% Answer:
% ag = -0.1585
% as = 0.9829
%
  ag = tan(deg2rad(betaGr)) - tan(deg2rad(thetaR));
  as = tan(deg2rad(betaSr)) - tan(deg2rad(thetaR));
end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.