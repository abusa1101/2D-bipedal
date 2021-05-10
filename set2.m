function [modeldir wd] = set2(option)

% global M Mp g L R K slope eqnhandle dim modeldir
global M Mp g L slope eqnhandle dim modeldir wd p Eref

eqnhandle = [];
modeldir = [];

model_options = [1 2]; % point footed, midleg mass

if nargin == 0
    option = [];
end

while length(option) == 0
    fprintf('Choose a model:\n\n');

    fprintf('   [1] Passive Walking\n');
    fprintf('   [2] Passivity-Based Control\n');

    fprintf('\n');
    option = input('Make a choice: ');
end

if length(find(option == model_options(1, :))) ~= 0
    dir = 'pointfoot-midlegmass';
else
    fprintf('Choose one of the options above.\n');
    return
end    

if option == 1
    dir = 'pointfoot-midlegmass/passive';
elseif option == 2
    dir = 'pointfoot-midlegmass/pbc';
else
    fprintf('Choose one of the options above.\n');
    return
end

% Parse the input
wd = feval('pwd');
modeldir = strcat(wd, '/', dir, '/')