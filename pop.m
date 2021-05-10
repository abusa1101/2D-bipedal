% Just an easy way to get those default variables out.  

if exist('modeldir') == 0
global M Mp g L slope eqnhandle dim modeldir wd p Eref
[modeldir wd] = set2;
end
eqnhandle = @dynamics2;
run(strcat(modeldir, '/pop'))