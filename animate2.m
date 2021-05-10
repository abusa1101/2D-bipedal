function animate2(xcycle, movie)
%
% ANIMATE2   Visualize the walker walking down a slope. May need to edit
% depending on the model.
%
% INPUT: 
% + xcycle = vector of the states at each integration step. See walk2.
% + movie = the movie recording option. If movie == '', no recording is 
%   made. Otherwise, this string is used as the movie's file name.
%
% Notes:
% Avoid running anything computationally intensive when you use  this
% animation.
%
% Written by Eric D.B. Wendel and Robert D. Gregg

global M Mp g L slope eqnhandle dim modeldir wd p Eref

draw_overlay = 1;

if nargin < 2
    movie = '';
end

t = xcycle(:,1);
s = xcycle(:,2);
ns = xcycle(:,2) + xcycle(:,3);

fig=figure;
set(fig,'DoubleBuffer','on');
set(gca,'xlim',[-80 80],'ylim',[-80 80],...
   'NextPlot','replace','Visible','off')

impactNSPoints = [];
impactHipPoints = [];
impactRefPoints = [];

ground = [0 0
          0 0];          
refPoint = [0 0];
steps = 0;
lastNsPoint = refPoint(1);

xlabel('x')
ylabel('y')

% Initialize the movie
if length(movie) ~= 0
    FramesPerSec=34;
%     TimeIncrementsPerSec=80;
%     incrementsperframe=round(TimeIncrementsPerSec/FramesPerSec);
    nextFrameTime = 0;
    mov=avifile(movie);
    mov.Quality=100;
    mov.Compression='Cinepak';
    %mov.ImageType='truecolor';
    %mov.Width=250;
    %mov.Length=250;
    mov.fps=FramesPerSec;
    F=0;
    set(groupTitle);
end

for i=1:length(t)
    
    % Switch stance, nonstance legs
    if i >= 2 & s(i) == ns(i-1)
        %         fprintf('Impact made.\n');
        steps = steps + 1;
        
        if draw_overlay
            impactRefPoints(:,steps) = refPoint;
            impactNSPoints(:,steps) = nsPoint;
            impactHipPoints(:,steps) = hipPoint;
        end

        ground = [0           0
                  nsPoint(1)  nsPoint(2)];
        refPoint = nsPoint;
%         pause
    end
    
    % Determine the hip and feet positions in 2D space
    hipPoint = refPoint + [L*sin(-s(i)) L*cos(s(i))];
    nsPoint = hipPoint - [L*sin(-ns(i)) L*cos(ns(i))];
    x = [refPoint(1) hipPoint(1) nsPoint(1)];
    y = [refPoint(2) hipPoint(2) nsPoint(2)];
    
    hold off

    plot(x, y, 'LineWidth',3)
    
    hold on
    
    % Draw fancy-lookin x's, and the ground.
    plot(hipPoint(1), hipPoint(2), 'o','LineWidth',2,'MarkerSize',12,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63])
    plot(refPoint(1), refPoint(2), 'x')
    plot(nsPoint(1), nsPoint(2), 'x')
    plot(ground(:,1), ground(:,2), 'k')

%     if i == 1
%         xmin = 0; ymin = 0;
%     end  
%     ymax = max([nsPoint(2)+1, refPoint(2)+1]);
%     if ymin >= ymax
%         ymin = min(y);
%         ymax = max(y);
%     end
    
    if i == 1
        ymax = hipPoint(2)+.2;
        ymin = -ymax+1;
        xmin = 0;
    end
    
    xmax = max([nsPoint(1)+1, refPoint(1)+1]);
    if xmin >= xmax
        xmin = min(x);
        xmax = max(x);
    end
    
    axis([xmin      xmax ...
          ymin      ymax])
    axis equal
%     axis([ground(1,1)-.5 ground(2,1)+.5 ground(1,2)-.5 ground(2,2)+.5])
%     axis equal

%     set(h,'EraseMode','xor');
    drawnow
    
    % Add movie frames?
    if length(movie) ~= 0
        %         if eq(mod(i,round(incrementsperframe)),0)
        if t(i) >= nextFrameTime
            nextFrameTime = nextFrameTime + 1/FramesPerSec;
            F = getframe(gcf);
            mov = addframe(mov,F);
        end
        %       pause(.001);
    end
%     if (length(movie) ~= 0 && eq(mod(i,round(incrementsperframe)),0))
%         F = getframe(gca);
%         mov = addframe(mov,F);
% %       pause(.001);
%     end
end

if length(movie) ~= 0
    mov = close(mov);
elseif draw_overlay
    hold off
    ground = [0           0
              nsPoint(1)  nsPoint(2)];
    hold on
    for j = 1:steps
        x = [impactRefPoints(1,j) impactHipPoints(1,j) impactNSPoints(1,j)];
        y = [impactRefPoints(2,j) impactHipPoints(2,j) impactNSPoints(2,j)];
        plot(x, y,'LineWidth',3)
        plot(impactHipPoints(1,j), impactHipPoints(2,j),'o','LineWidth',2,'MarkerSize',12,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63])
        plot(impactRefPoints(1,j), impactRefPoints(2,j),'x')
        plot(impactNSPoints(1,j), impactNSPoints(2,j), 'x')
        plot(ground(:,1), ground(:,2), 'k')
    end
    
    drawnow
end