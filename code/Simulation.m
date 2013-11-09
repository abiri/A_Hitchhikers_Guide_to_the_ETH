% Evaluation / Simulation

load data;  % loads time_poly, time_tram and time_walk

M = Homo();

agents = apti * time_span / dt;

% Way -1: already done
% Way 1: Polybahn
% Way 2: Tram (Haldenegg)
% Way 3: Walking (Stairs ETH/University)

% initialize variables and preallocate memory (for maximized speed)
total = 0;
total_temp = 1:time_span/dt;
poly_temp  = 1:time_span/dt;
tram_temp  = 1:time_span/dt;
walk_temp  = 1:time_span/dt;
previous = 1; % index of maximal block of agents that has already been progressed

poly_capacity = 80;
tram_capacity = 120;
walk_capacity = 10000; % atm infinite

for i = 1:(time_span/dt); % loops through all time intervals
    
    
    while ( M(previous,1) < 0)  % skips agents that already progressed through the entire system,  Path "-1" == done
        previous = previous + 1;
    end
    
    for k = previous:(apti*(i-1))  % loops through previous agents

        % update old agents

        M(k,2) = M(k,2) + dt; % increase timestep

        switch M(k,1)
            case 1
                poly_temp(i) = poly_temp(i) + 1;
                if ( M(k,2) > time_poly )
                    M(k,1) = -1;
                end
            case 2
                tram_temp(i) = tram_temp(i) + 1;
                if ( M(k,2) > time_tram )
                    M(k,1) = -1;
                end
            case 3
                walk_temp(i) = walk_temp(i) + 1;
                if ( M(k,2) > time_walk )
                    M(k,1) = -1;
                end
        end
    end


    for k = (apti*(i-1) + 1):(apti*i) % loops through new agents at the end of stack

        % evaluate situation and position new agents
        
        if ( poly_temp(i) < poly_capacity)
           M(k,1) = 1;
           poly_temp(i) = poly_temp(i) + 1;
        elseif ( tram_temp(i) < tram_capacity)
           M(k,1) = 2;
           tram_temp(i) = tram_temp(i) + 1;
        else
           M(k,1) = 3;
           walk_temp(i) = walk_temp(i) + 1;
        end     
    end
    

    % statistic data
    
    %poly_temp(i)  = sum( M(:,1) == ones(agents)); 
    %tram_temp(i)  = sum( M(:,1) == 2*ones(agents)); 
    %walk_temp(i)  = sum( M(:,1) == 3*ones(agents)); 
    
    total_temp(i) = i*apti - sum( M(:,1) == (-1)*ones(agents,1));
    
end

subplot(4,1,1), plot(total_temp);
subplot(4,1,2), plot(poly_temp);
subplot(4,1,3), plot(tram_temp);
subplot(4,1,4), plot(walk_temp);



