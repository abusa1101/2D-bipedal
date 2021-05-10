function [out1 out2 out3] = walk2(xi, steps, graph, movie)
% WALK2   Walk the robot for "steps", optionally graph or animate motion.
%
% [out1,out2,out3] = walk2(xi, steps, graph, movie)
%
% INPUT:
% + xi = the input state vector, angles and their velocites. Passed to
%   step2.
% + steps = specify the # of steps the walker should take.
% + graph = the display option. If graph = 0 or is null, nothing displayed.
%   If graph equals 1, then the walking is graphed. If graph is 2, the
%   walker is animated using animate2.
% + movie = the movie recording option. If movie == '', no recording is 
%   made. Otherwise, this string is used as the movie's file name.
%
% OUTPUT:
% + out1 = If graph = 0, 1 or null, out1 is the state after impact on the 
%   last step. If graph = 2,  out1 is something to do with the output of 
%   animate3, although truth be told I haven't yet fixed this feature.
% + out2 = null if graph = 2, otherwise contains all the states beginning
%   from time = 0 to the time of the last point of contact w/ the slope.
%
% xafter = state after computing impact
% tafter = time at which the guard triggers
% xbefore = all states over time prior to computing impact
% tbefore = the corresponding times, always from 0 to tlast.
%             tbefore(end,:) = tafter
% tlast = the tbefore from the previous step


global M Mp g L slope eqnhandle dim modeldir wd p Eref

if size(xi) ~= [1 dim]
    fprintf('walk2 error: Input state vector must have %i row and %i cols.\n', size(xi)*[1 0]', size(xi)*[0 1]');
    out1 = []; out2 = []; out3 = [];
    return
end

% Parse inputs ...
if nargin < 3
    graph = 0;
end        
if nargin < 4
   movie = '';
end

x = []; t = [];
tlast = 0;

for step=1:steps
    [xafter tafter xbefore tbefore] = step2(xi);
         
    t = [t ; tbefore+tlast];
    x = [x ; xbefore];
    tlast = tafter+tlast;
    xi = xafter;
end
t = [t; tlast];
x = [x; xafter];
out1 = xafter;
out2 = [t x];

if graph == 1        
    figure(1), hold on, box off
    plot(x(:,1), x(:,3), 'r',x(:,2), x(:,4), 'b','LineWidth',2)
    x_handle = xlabel('Angular positions [rad]');
    y_handle = ylabel('Angular velocities [rad/sec]');
    legend_handle = legend('$(\theta_1,\dot\theta_1)$','$(\theta_2,\dot\theta_2)$');
    set(x_handle,'Interpreter','tex','FontSize',12);
    set(y_handle,'Interpreter','tex','FontSize',12);
    set(legend_handle,'Interpreter','latex','FontSize',13);
    
    figure(2), hold on, box off
    plot(t, x(:,1), 'r', t, x(:,2), 'b','LineWidth',2)%, t, x(:,1)+x(:,2)+2*slope, 'g')
    x_handle = xlabel('Time [sec]');
    y_handle = ylabel('Angular positions [rad]');
    legend_handle = legend('$\theta_1(t)$','$\theta_2(t)$');
    set(x_handle,'Interpreter','tex','FontSize',12);
    set(y_handle,'Interpreter','tex','FontSize',12);
    set(legend_handle,'Interpreter','latex','FontSize',13);
    
    tilefigs
elseif graph == 2
    animate2(out2, movie);        
end