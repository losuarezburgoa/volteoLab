function [ intPtVec ] =intersecctiontwo2Dlines( line1ParamEqSTR, line2ParamEqSTR, ...
    want2plot )
% Idea taken from:
% http://geomalgorithms.com/a05-_intersect-1.html#intersect2D_2Segments%28%29
%
% Example 1
% line1ParamEqSTR =struct( 'xoVec', [6.9; 0.6], 'uVec', [0.52992; 0.84805] );
% line2ParamEqSTR =struct( 'xoVec', [0;0], 'uVec', [0.79864; 0.60182] );
% intPtVec =intersecctiontwo2Dlines( line1ParamEqSTR, line2ParamEqSTR, true );
%
% Example 2
% line1ParamEqSTR =struct( 'xoVec', [6.9; 0.6], 'uVec', [0.52992; 0.84805] );
% line2ParamEqSTR =struct( 'xoVec', [0;0], 'uVec', [0.52992; 0.84805] );
%
%%%%%%%%%%%%%
%%%%%%%%%%%%%

%% Input management
if nargin < 3
 want2plot =false;
end

%% Recalculate unit vectors for precision
u1Vec =line1ParamEqSTR.uVec /norm(line1ParamEqSTR.uVec);
u2Vec =line2ParamEqSTR.uVec /norm(line2ParamEqSTR.uVec);
x01Vec =line1ParamEqSTR.xoVec;
x02Vec =line2ParamEqSTR.xoVec;

%% Precalculations
x12Vec =x01Vec -x02Vec;
u1PerpVec =[ 0, -1; 1, 0 ] *u1Vec;
u2PerpVec =[ 0, -1; 1, 0 ] *u2Vec;

x12uVec=x12Vec /norm(x12Vec);

%% Tests
if dot( u1Vec, u2Vec ) ==0
  % are they paralell or colinear
  intPtVec =nan(2,1);
  plotInt =false;
  if and( dot(u1Vec, x12uVec), dot(u2Vec, x12uVec) )
    % the are colinear
    intPtVec =inf(2,1);
    return
  end
  return
end

%% Finding out the intersection
plotInt =true;
k1 =dot(-u2PerpVec, x12Vec) /dot(u2PerpVec, u1Vec);
k2 =dot( u1PerpVec, x12Vec) /dot(u1PerpVec, u2Vec);

intPt1Vec =x01Vec +k1 *u1Vec;
intPt2Vec =x02Vec +k2 *u2Vec;
%if any( intPt1Vec == intPt2Vec )
  intPtVec =intPt1Vec;
%end

%% Plotting the problem
if want2plot
  hold on
  line1PtsArray =[ x01Vec, intPt1Vec ];
  plot( line1PtsArray(1,:), line1PtsArray(2,:), 'b-' );
  line2PtsArray =[ x02Vec, intPt2Vec ];
  plot( line2PtsArray(1,:), line2PtsArray(2,:), 'r-' );
  if plotInt
    plot( intPtVec(1), intPtVec(2), 'ko' );
  end
end

end


% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.