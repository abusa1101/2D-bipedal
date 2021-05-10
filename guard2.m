function [value, isterminal, direction] = guard2(t, x)
% guard2 determines when the walker strikes the ground.

global M Mp g L slope eqnhandle dim modeldir wd p Eref

height = feval(eqnhandle, 0, x, 'g');
s = x(1); ns = x(1) + x(2);

if ns > 0
    value = height;
else
    value = 1;
end

isterminal = 1;
direction = 0;