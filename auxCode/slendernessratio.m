function [ radioEsbeltez ] = slendernessratio( hm, t )
% Description:
% Calculate the Relationship between the height of the block in the slope crest
% and the width of the serial block toppling.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :hm.
%
% Input(s):
% hm =      height at the block in the slope crest.
% t  =      blocks width of the serial of analisys.
%
% Output(s):
% radioEsbeltez =  the Relationship between the height of the block in the slope crest
% and the width of the serial block toppling.
%
% Example 1
% [ radioEsbeltez ] = slendernessratio( 2.1193,0.40 )
% Answer: 
% radioEsbeltez =  5.2982
%
% Example 2
% [ radioEsbeltez ] = slendernessratio( 1.57,0.40 )
% Answer: 
% radioEsbeltez =  3.9250
%

radioEsbeltez = hm/t;

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.