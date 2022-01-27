function [ y ] =obtainyoflinegivenx( x, pt1Vec, pt2Vec )
%
% Description:
% In R^2 cartesian coordiante system, this funcction obtains
% the y value of a line (defined by two points) when given 
% the x value.
%
% Input(s):
% Coordiante of x (abscisa) from which y is wanted to obtain (x).
%
% First point given as a 2x1 vector that defines the line 
% equation (pt1Vec).
%
% Second point given as a 2x1 vector that defines the line
% equation (pt2Vec).
%
% Output(s):
% Coordiante of y (ordiante) that has an absisa of x and that
% belongs to the line that is defined by point 1 a 2.
%
%%%%%%%%%%%%
% y =obtainyoflinegivenx( x, pt1Vec, pt2Vec )
%%%%%%%%%%%%

lineSegmentVec =pt2Vec -pt1Vec;
lineSegmentUnitVec =lineSegmentVec /norm(lineSegmentVec);

k =( x -pt1Vec(1) ) /lineSegmentUnitVec(1);
y =pt1Vec(2) +k*lineSegmentUnitVec(2);

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.