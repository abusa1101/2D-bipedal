function [out] = dynamics2(t, x, flag)

global M Mp g L slope eqnhandle dim modeldir wd p Eref

if nargin < 3, flag = 's'; end
Beta = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the dynamics 's'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (flag == 's') || (flag == 'u')
    % Determine control laws
    
    if regexp(modeldir, 'pbc') ~= 0  % PBC / potential energy shaping
        define_dynamics_terms
        %%
        %%% TO DO %%%
        u_input = ...;%to be determined
        u1 = u_input(1);
        u2 = u_input(2);
        %%%%%%%%%%%%%
    else % Passive Walking
        u1 = 0; u2 = 0;
    end
    
    if (flag == 'u')
        out(1) = u1;
        out(2) = u2;
    end
end

if flag == 's'
    % Determine closed-loop vector field
    define_dynamics_terms
   
    out(dim/2+1:dim) = Dmtx\(-Cthetadot-Nvect+[u1;u2]);  
    out(1:dim/2) = x(dim/2+1:dim);
    out = out';
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calculate the impact 'i'
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif flag == 'i'
    out(3) = (-2.*(M + 2.*Mp)*cos(- x(2))*x(3) + M*(x(3)+x(4)))/(-3.*M - 4.*Mp + 2.*M*cos(2.*( - x(2))));
    out(4) = ((M - 4.*(M + Mp)*cos(2.*(- x(2))))*x(3) + 2.*M*cos( - x(2))*(x(3)+x(4)))/(-3.*M - 4.*Mp + 2.*M*cos(2.*( - x(2))));
    
    out(4) = out(4) - out(3);
    
    out(1) = x(1) + x(2);
    out(2) = -x(2);
%     out = out';
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calculate the guard 'g'
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif flag == 'g'
    %%
    %%% TO DO %%%
    out = guard2(;%define the constraint
    
    %%%%%%%%%%%%%
end


