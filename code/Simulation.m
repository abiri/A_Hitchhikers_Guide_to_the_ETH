% Evaluation / Simulation

load data;  % loads time_poly, time_tram and time_walk

M = Handicapped(0); % in percent -> Handicapped(1) = 1 % of the agents who will always take the Polybahn

agents =  length( M(:,1) );

% Way -1: already done
% Way 1: Polybahn
% Way 2: Tram (Haldenegg)
% Way 3: Walking (Stairs ETH/University)

% Way 4: Waiting for Polybahn
% Way 5: Waiting for Tram

% initialize variables and preallocate memory (for maximized speed)
total_temp = zeros(time_span/dt,1);
poly_temp  = zeros(time_span/dt,1);
tram_temp  = zeros(time_span/dt,1);
walk_temp  = zeros(time_span/dt,1);
poly_tempw = zeros(time_span/dt,1);
tram_tempw = zeros(time_span/dt,1);

previous = 1; % index of maximal block of agents that has already been progressed
old_top = 0;
new_top = 0;

poly_capacity = 40;
tram_capacity = 50;
walk_capacity = 10000; % atm infinite

poly_frequency = (2 *6 + 1)*dt;  % Time interval between Polybahn departures in minutes
tram_frequency = (6 *6 + 1)*dt;

poly_wait = 80;
tram_wait = tram_capacity; % people wait exactly for the next tram, and not more

waiting_poly = 0;
driving_poly = 0;
waiting_tram = 0;
driving_tram = 0;

% Preparing Visualisation
calc = 0; % for preventing multiple calculations
%[A,map] = imread('https://github.com/abiri/A_Hitchhikers_Guide_to_the_ETH/blob/master/presentation/Maps_GeoAdmin.png?raw=true','png');
fid = figure;

video = VideoWriter('Video_1.avi');
% video.FrameRate = 60; % change framerate if required
open(video);

for i = 1:(time_span/dt); % loops through all time intervals
    
    old_top = new_top;
    new_top = new_top + 1 + ceil( apti*abs(sin(2*pi/60 * i)) );    % periodically every hour, but at least plus 1 (so old_top != new_top)
    
    while ( M(previous,1) < 0)  % skips agents that already progressed through the entire system,  Path "-1" == done
        previous = previous + 1;
    end
    
    for k = previous:old_top  % loops through "old" agents (skips previous ones)
    
        if (M(k,1) > 0)
            if (M(k,1) > 3)
                M(k,3) = M(k,3) + dt; % increase waiting time
            else
                M(k,2) = M(k,2) + dt; % increase way time
            end
        end
        
        switch M(k,1)
            case 0
                % nothing happens, just to short-circuit evaluation
            case -1
                % nothing happens, just to short-circuit evaluation
            case 1
                if ( M(k,2) > time_poly )
                    M(k,1) = -1;
                    driving_poly = driving_poly + 1;
                    waiting_poly = waiting_poly + M(k,3);
                else
                    poly_temp(i) = poly_temp(i) + 1;
                end
            case 2
                if ( M(k,2) > time_tram )
                    M(k,1) = -1;
                    driving_tram = driving_tram + 1;
                    waiting_tram = waiting_tram + M(k,3);
                else
                    tram_temp(i) = tram_temp(i) + 1;
                end
            case 3
                if ( M(k,2) > time_walk )
                    M(k,1) = -1;
                else
                    walk_temp(i) = walk_temp(i) + 1;
                end
            case 4
                if ( ( mod(i*dt,poly_frequency) == 0) && (poly_temp(i) < poly_capacity) )
                    poly_temp(i) = poly_temp(i) + 1;
                    M(k,1) = 1;
                else
                    poly_tempw(i) = poly_tempw(i) + 1;
                end
            case 5
                if ( ( mod(i*dt,tram_frequency) == 0) && (tram_temp(i) < tram_capacity) )
                    tram_temp(i) = tram_temp(i) + 1;
                    M(k,1) = 2;
                else
                    tram_tempw(i) = tram_tempw(i) + 1;
                end
            otherwise
                X = fprintf('Something went wrong with the path %d at timestep %d !' , M(k,1) , k);
        end
    end


    for j = (old_top+1):new_top % loops through new agents at the end of stack

        switch M(j,1)
            case 0
                if (( poly_temp(i) < poly_capacity) && ( mod(i*dt,poly_frequency) == 0))     % Polybahn is just departing
                   M(j,1) = 1;
                   poly_temp(i) = poly_temp(i) + 1;
                elseif (( tram_temp(i) < tram_capacity) && ( mod(i*dt,tram_frequency) == 0)) % Tram is just departing
                   M(j,1) = 2;
                   tram_temp(i) = tram_temp(i) + 1;
                elseif ( poly_tempw(i) < poly_wait)
                    M(j,1) = 4;
                    poly_tempw(i) = poly_tempw(i) + 1;
                elseif ( tram_tempw(i) < tram_wait)
                    M(j,1) = 5;
                    tram_tempw(i) = tram_tempw(i) + 1;
                else
                   M(j,1) = 3;
                   walk_temp(i) = walk_temp(i) + 1;
                end
                
            case 4
                poly_tempw(i) = poly_tempw(i) + 1;
            case 5
                tram_tempw(i) = tram_tempw(i) + 1;
        end
    end
    

    % statistic data and visualisation
    
    total_temp(i) = new_top - sum( M(:,1) == (-1)*ones(agents,1));
    
    current = i; % for stacked display of waiting agents in Visualisation
    
    %Visualisation
    
end

%close(video);

mean_poly = waiting_poly/driving_poly;
mean_tram = waiting_tram/driving_tram;

X = fprintf('Average agents in Polybahn: %f \n', mean(poly_temp) );
X = fprintf('Average waiting time at Polybahn: %f \n', mean_poly);
X = fprintf('Average agents in Tram: %f \n', mean(tram_temp) );
X = fprintf('Average waiting time at tram: %f \n', mean_tram);
X = fprintf('Average agents walking: %f \n', mean(walk_temp) );


fid2 = figure;
figure (fid2);

subplot(4,2,1), plot(total_temp);
title('Total agents at the moment');
subplot(4,2,3), plot(poly_temp);
title('Polybahn agents');
subplot(4,2,4), plot(poly_tempw);
title('Polybahn waiting queue');
subplot(4,2,5), plot(tram_temp);
title('Tram agents');
subplot(4,2,6), plot(tram_tempw);
title('Tram waiting queue');
subplot(4,2,7), plot(walk_temp);
title('Walking agents');

frame = getframe(fid2);
[X,map] = frame2im(frame);
imwrite(X,'Subplot_1.jpg','jpg');

X = fprintf('Finished video and picture and saved into GitHub-Folder...\n');





