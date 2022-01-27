% installVolteoLabSCR.m

%% Specify the path of the functions
display (['Please write the path where ''volteoLab'' resides ', ...
    '(without the last directory)'] );
mainPathString = input('For example: ''/media/ludger/datos/ownDevProgsMATLAB/'' ' );
if isempty(mainPathString)
    mainPathString ='/media/ludger/datos/ownDevProgsMATLAB/';
end
genPathString = genpath([mainPathString, 'volteoLab/']);
addpath(genPathString);
% help volteolab

% BSD 2 license.
% https://opensource.org/licenses/BSD-2-Clause
% Copyright (c) 2015-2021, Luis A. Erazo-Martínez, Ludger O. Suarez-Burgoa
% and Universidad Nacional de Colombia.
% All rights reserved.