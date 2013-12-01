
% Draws the agents on the map 

load data;

if (calc == 0)
    
    % Walking
    y_w = zeros(time_walk/dt,1);
    x_w = 1:(time_walk/dt);

     for i = 1:length(y_w)

         if (i <= ceil(time_walk/dt *0.2))

             y_w(i)= 4;

         elseif (i > ceil(time_walk/dt * 0.2) && i <= ceil(time_walk/dt * 0.6)) 

             % additional terms clear irregularities induced by changing conditions

             y_w(i) = 2*x_w(i) + y_w(ceil(time_walk/dt * 0.2)) - 2*(ceil(time_walk/dt * 0.2));

         else

             y_w(i) = -3*x_w(i) + y_w(ceil(time_walk/dt * 0.6)) + 3*(ceil(time_walk/dt * 0.6));

         end

     end

     % Polybahn
    y_p = zeros(time_poly/dt,1);
    x_p = 1:(time_poly/dt);

     for i = 1:length(y_p)

         if (i <= ceil(time_poly/dt *0.2))

             y_p(i)= 4;

         elseif (i > ceil(time_poly/dt * 0.2) && i <= ceil(time_poly/dt * 0.6)) 

             % additional terms clear irregularities induced by changing conditions

             y_p(i) = 2*x_p(i) + y_p(ceil(time_poly/dt * 0.2)) - 2*(ceil(time_poly/dt * 0.2));

         else

             y_p(i) = -3*x_p(i) + y_p(ceil(time_poly/dt * 0.6)) + 3*(ceil(time_poly/dt * 0.6));

         end

     end
     
    % Tram
    x_t = 1:(time_tram/dt);
    y_t = zeros(time_tram/dt,1);

     for i = 1:length(y_t)

         if (i <= ceil(time_tram/dt *0.2))

             y_t(i)= 4;

         elseif (i > ceil(time_tram/dt * 0.2) && i <= ceil(time_tram/dt * 0.6)) 

             % additional terms clear irregularities induced by changing conditions

             y_t(i) = 2*x_t(i) + y_t(ceil(time_tram/dt * 0.2)) - 2*(ceil(time_tram/dt * 0.2));

         else

             y_t(i) = -3*x_t(i) + y_t(ceil(time_tram/dt * 0.6)) + 3*(ceil(time_tram/dt * 0.6));

         end

     end
     
     %plot(x_w,y_w);
     %pause(5);

end
calc = 1; % prevents multiple plottings


agent_y = zeros(previous - (apti*(i-1)),1);
agent_pos = zeros(previous - (apti*(i-1)),1);
 
     
 for i = previous:(apti*(i-1))
     
    time = M(i,2);
    agent_pos(i) = round(time/dt);
    
    if (time > 0)
        switch M(i,1)
            case 1
                agent_y(i) =  y_p(agent_pos(i));    % Polybahn
            case 2
                agent_y(i) =  y_t(agent_pos(i));    % Tram
            case 3
                agent_y(i) =  y_w(agent_pos(i));    % Walking
            case -1
                agent_y(i) = 0; % finished
            otherwise
                agent_y(i) = 0;
        end
    else
        agent_y(i) = 0;
    end
    
 end

 figure (fid);
 xlim([0 150]);
 ylim([0 60]);

 scatter(agent_pos,agent_y);
 pause(0.3);
 
 