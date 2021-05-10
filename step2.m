function [xafter, tafter, xbefore, tbefore] = step2(xin)
% STEP2   Simulate 1 step and calculate state after impact.
%
% [xafter, tafter, xbefore, tbefore] = step2(xin);
%
% INPUTS:
% + xin = input state vector, angles and their rates of change. 

% OUTPUTS:
% + xafter = state after impact.
% + tafter = time at impact. 
% + xbefore = vector of the states at each integration time, up to impact.
% + tbefore = vector of times for each state

global M Mp g L slope eqnhandle dim modeldir wd p Eref

% initialize the invalid results flag
invalidResults = 0;

if size(xin) ~= [1 dim]
    fprintf('step2 error: Input state vector must have 1 row and %i cols.\n', dim);
    xafter = []; tafter = []; xbefore = []; tbefore = [];
    return
end

% Restrict values of the input vector
if norm(xin) > 1E8
    fprintf('step2 warning: Input state too large. Stopping run.\n');
    xafter = []; tafter = []; xbefore = []; tbefore = [];
    return
end

% Perform the integration
tspan = [0 2];
options = odeset('Events', 'guard2','RelTol', 2.22045e-06, 'AbsTol', 1e-10);
[t x tcontact xcontact] = ode113(eqnhandle, tspan, xin, options);

% Decide how to process 
if (length(xcontact) == 0 || length(tcontact) == 0) % If no contact
    fprintf('step2 warning: No contact made w/ slope in %i seconds, stopping run.\n', tspan(2));
    xafter = x(end,:);
    tafter = t(end);
else
    xafter = feval(eqnhandle, 0, xcontact, 'i'); 
    tafter = tcontact;
end

xbefore = x;
tbefore = t;