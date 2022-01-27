function [Narray] = normalstresscalcarray (ct, wip, nArray)
   
% Description:
% Calculate the normal contact force between toppling blocks at the serial numbers 
% that contain the set of toppling and sliding failure.
%
% Main Reference:
% Liu, C. H., Jaksa, M. B., & Meyers, A. G. (2008). A transfer coefficient 
% method for rock slope toppling. Canadian Geotechnical Journal, 46(1), 1-9.
%
% External sub-function(s) :ct, wip.
%
% Input(s):
% ct          =   matrix that contain the results of the transfer coeficient for a set
% wip         =   matrix that contain the results of the toppling weight for a set
%                 of block that are under toppling failure.
% nArray      =   matrix of the serial number at all block toppling is to (1...nblocks).
%
% Output(s):
% Narray      =   matrix of the normal contact force between toppling blocks at the serial numbers 
%                 that contain the set of toppling and sliding failure.
%
% Example 1
% 
% ct          =    ( 0.7205, 0.7383, 0.7539, 0.7677, 0.7801, 0.7912, 0.8013, 0.8104, 
%                   0.8187, 0.8264, 1.0143, 0.9190, 0.9114, 0.9022, 0.8909, 0.8767, 
%                   0.8581, 0.8330, 0.7970, 0.7413, 0.6436, 0.4271, -0.4594, 3.6661, 
%                   1.6967, 1.4007, 1.2812];
%
% wip         =    (0.0313, 0.1652, 0.2992, 0.4332, 0.5671, 0.7011, 0.8351, 
%                   0.9691, 1.1030, 1.2370, 1.3710, 1.8317, 1.5934, 1.3508, 
%                   1.1027, 0.8469, 0.5807, 0.2992, -0.0057, -0.3490, -0.7624,
%                   -1.3253, -2.3103, -5.6767, 8.7707, 1.5555, 0.2879];
% nArray      =    (1:1:27);
% Answer:
% N           =    (0.0313, 0.1878, 0.4378, 0.7633, 1.1531, 1.6006, 2.1015, 2.6530,
%                   3.2530, 3.9002, 4.5942, 6.4916, 7.5591, 8.2402, 8.5370, 8.4525,
%                   7.9910, 7.1563, 5.9555, 4.3975, 2.4975, 0.2821, -2.1898, -4.6707, 
%                   -8.3525, -12.6163, -17.3837);
%
% Example 2
% ct          =     coeftransf( 5.2982, 20, 1:1:27, 43.25, -0.1585, 0.7465, 50, 16, 0 )
% ct          =     (0.7326, 0.7488, 0.7632, 0.7761, 0.7876, 0.7980, 0.8074, 0.8160, 
%                   0.8239, 0.8311, 0.8377, 0.8439, 0.8496, 0.8549, 0.8598, 0.8644, 
%                   0.8687, 0.8728, 1.1310, 1.0747, 1.0961, 1.1345, 1.2241, 1.6713, 
%                   0.3261, 0.7757, 0.8654];
%
% wip         =    ( 0.1202, 0.2542, 0.3881, 0.5221, 0.6561, 0.7900, 0.9240, 
%                   1.0580, 1.1919, 1.3259, 1.4599, 1.5939, 1.7278, 1.8618, 
%                   1.9958, 2.1297, 2.2637, 2.3977, 2.5316, 3.4392, 2.7563,
%                   2.0438, 1.2660, 0.2925, -2.0484, 2.4632, 0.1138);

% nArray      =    (1:1:27);
% Answer: 
% N           =    (0.1202, 0.3423, 0.6444, 1.0139, 1.4430, 1.9265, 2.4613, 
%                   3.0453, 3.6769, 4.3553, 5.0796, 5.8490, 6.6638, 7.5234, 
%                   8.4275, 9.3757, 10.3680, 11.4044, 12.4854, 17.5602, 21.6282, 
%                   25.7505, 30.4799, 37.6030, 60.7974, 22.2892, 17.4036];


numVals = length(nArray);                                     
Narray = size(nArray);          
 
for i = 1:numVals
    Narray(i) = normalstresscalc (ct, wip, i);
end


end

function [N] = normalstresscalc (ct, wip, n)
N0 = 0;
for j = 1:n-1
    N0 = N0 + wip(j) * prod(ct(j:n-1));
end
N = N0 + wip(n);

end

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.