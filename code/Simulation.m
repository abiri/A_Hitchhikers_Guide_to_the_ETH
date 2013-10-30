% Evaluation / Simulation

load data;

M = Equal;

% initialize variables and preallocate memory (for maximized speed)
total = 0;
total_temp = 1:time_span/dt;
poly_temp  = 1:time_span/dt;
tram_temp  = 1:time_span/dt;
walk_temp  = 1:time_span/dt;
previous = 1; % index of maximal block of agents that has already been progressed

for i = 1:(time_span/dt); % loops through all time intervals
    
    total = total + apti;
    
    for k = (apti*(i-1) + 1):(apti*i) % loops through new agents at the end of stack
       
        % evaluate situation and position new agents
    end
    
    while ( M(previous,1) < 0)  % skips agents that already progressed through the entire system,  Path "-1" == done
        previous = previous + 1;
    
    for k = previous:(apti*(i-1))  % loops through previous agents
            
        % update old agents
        
    end
    
    total = total - gone;
    
    % statistic data
    total_temp(i) = total;
    
    end

subplot(4,1,1), plot(total_temp);
subplot(4,1,2), plot(poly_temp);
subplot(4,1,3), plot(tram_temp);
subplot(4,1,4), plot(walk_temp);



