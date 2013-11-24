% Evaluation / Simulation

load data;  % loads time_poly, time_tram and time_walk

M = Homo();

agents = apti * time_span / dt;

% Way -1: already done
% Way 1: Polybahn
% Way 2: Tram (Haldenegg)
% Way 3: Walking (Stairs ETH/University)

% Way 4: Waiting for Polybahn
% Way 5: Waiting for tram

% initialize variables and preallocate memory (for maximized speed)
total = 0;
total_temp = zeros(time_span/dt,1);
poly_temp  = zeros(time_span/dt,1);
tram_temp  = zeros(time_span/dt,1);
walk_temp  = zeros(time_span/dt,1);
poly_tempw = zeros(time_span/dt,1);
tram_tempw = zeros(time_span/dt,1);
previous = 1; % index of maximal block of agents that has already been progressed

poly_capacity = 40;
tram_capacity = 50;
walk_capacity = 10000; % atm infinite

poly_wait = 80;
tram_wait = 50;

% Preparing Visualisation
calc = 0; % for preventing multiple calculations
[A,map] = imread('https://github.com/abiri/A_Hitchhikers_Guide_to_the_ETH/blob/master/presentation/Maps_GeoAdmin.png?raw=true','png');
fid = figure;

for i = 1:(time_span/dt); % loops through all time intervals
    
    while ( M(previous,1) < 0)  % skips agents that already progressed through the entire system,  Path "-1" == done
        previous = previous + 1;
    end
    
    for k = previous:(apti*(i-1))  % loops through "old" agents (skips previous ones)

        % update old agents

        M(k,2) = M(k,2) + dt; % increase timestep

        switch M(k,1)
            case 0
                % nothing happens, just to short-circuit evaluation
            case -1
                % nothing happens, just to short-circuit evaluation
            case 1
                if ( M(k,2) > time_poly )
                    M(k,1) = -1;
                else
                    poly_temp(i) = poly_temp(i) + 1;
                end
            case 2
                if ( M(k,2) > time_tram )
                    M(k,1) = -1;
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
                if ( ( mod(i*dt,time_poly) == 0) && (poly_temp(i) < poly_capacity) )
                    poly_temp(i) = poly_temp(i) + 1;
                    M(k,1) = 1;
                    M(k,2) = 0; % reset timer
                else
                    poly_tempw(i) = poly_tempw(i) + 1;
                end
            case 5
                if ( ( mod(i*dt,time_tram) == 0) && (tram_temp(i) < tram_capacity) )
                    tram_temp(i) = tram_temp(i) + 1;
                    M(k,1) = 2;
                    M(k,2) = 0; % reset timer
                else
                    tram_tempw(i) = tram_tempw(i) + 1;
                end
            otherwise
                X = fprintf('Something went wrong with the path %d at timestep %d !' , M(k,1) , k);
        end
    end


    for j = (apti*(i-1) + 1):(apti*i) % loops through new agents at the end of stack

        % evaluate situation and position new agents
        
        if (( poly_temp(i) < poly_capacity) && ( mod(i*dt,time_poly) == 0))     % Polybahn is just departing
           M(j,1) = 1;
           poly_temp(i) = poly_temp(i) + 1;
        elseif (( tram_temp(i) < tram_capacity) && ( mod(i*dt,time_tram) == 0)) % Tram is just departing
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
    end
    

    % statistic data and visualisation
    
    total_temp(i) = i*apti - sum( M(:,1) == (-1)*ones(agents,1));
    
    current = i; % for stacked display of waiting agents in Visualisation
    Visualisation
    
end

pause(2);

fid2 = figure;
figure (fid2);

subplot(4,2,1), plot(total_temp);
subplot(4,2,3), plot(poly_temp);
subplot(4,2,4), plot(poly_tempw);
subplot(4,2,5), plot(tram_temp);
subplot(4,2,6), plot(tram_tempw);
subplot(4,2,7), plot(walk_temp);



