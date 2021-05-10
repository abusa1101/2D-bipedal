global M Mp g L slope eqnhandle dim modeldir wd p Eref


    M = 5
    Mp = 10
    g = 9.8
    L = 1
    
    % Potential energy shaping for energy-tracking (Spong)
    p = 10
    Eref = 153.7864;
    
    dim = 4
    slope = 0 %0.052
    xi = [0.2884   -0.5767   -1.1231    0.8411] % Start on limit cycle