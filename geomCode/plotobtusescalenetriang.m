function [ ] =plotobtusescalenetriang( triangSTR, colorString )
%
% Description:
% Given the obtuse scalene triangle structure, this function plots it.
%
% The origim is at the highest and most back point of the movement
% Point A. In orther to see triangle as a slipe example, the vertical axis
% should be reversed.
%
%%%%%%%%%%%%%%%
% plotobtusescalenetriang( triangSTR )
%%%%%%%%%%%%%%%
if nargin <2
    colorString ='k';
end

ptAvec =triangSTR.baseSlopeCell{3};
ptBvec =triangSTR.slipSideCell{3};
ptCvec =triangSTR.crownSlopeCell{3};
allPtsVecMat =[ ptAvec, ptBvec, ptCvec, ptAvec ];

deltaOffsetText =0.01 *triangSTR.slipSideCell{1};

hold on
% the sides and vertices
plot( allPtsVecMat(1,:), allPtsVecMat(2,:), '-', 'Color', colorString );
plot( allPtsVecMat(1,:), allPtsVecMat(2,:), 'o', 'Color', colorString );
% the verices names
text( ptAvec(1)-deltaOffsetText*1.2, ptAvec(2)-deltaOffsetText*1.2, 'A' );
text( ptBvec(1)+deltaOffsetText*1.1, ptBvec(2)+0, 'B' );
text( ptCvec(1)+deltaOffsetText, ptCvec(2)+deltaOffsetText, 'C' );

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.