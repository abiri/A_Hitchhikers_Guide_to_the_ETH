
% Draws the agents on the map 

load data;

if (calc == 0)
    
    % Polybahn
    y_p = zeros(time_poly/dt,1);
    x_p = 1:(time_poly/dt);
    time1 = round(time_poly/dt *0.1);
    time2 = round(time_poly/dt *0.35);

     for i = 1:length(y_p)

         if (i <= time1)

             y_p(i)= 290;

         elseif ( i <= time2 ) 

             % additional terms clear irregularities induced by changing conditions

             y_p(i) = 13*( x_p(i) - time1 ) + y_p(time1);

         else

             y_p(i) = -5*(  x_p(i) - time2 ) + y_p(time2);

         end
     end
     
    % Tram
    y_t = zeros(time_tram/dt,1);
    x_t = 1:(time_tram/dt);
    time1 = round(time_walk/dt *0.15);
    time2 = round(time_walk/dt *0.25);

     for i = 1:length(y_t)

         if (i <= time1)

             y_t(i)= 290;

         elseif ( i <= time2) 

             % additional terms clear irregularities induced by changing conditions

             y_t(i) = -50*( x_t(i) - time1 ) + y_t(time1);

         else

             y_t(i) = 15*( x_t(i) - time2 ) + y_t(time2);

         end
     end
     
     % Walking
    y_w = zeros(time_walk/dt,1);
    x_w = 1:(time_walk/dt);
    time1 = round(time_walk/dt *0.27);
    time2 = round(time_walk/dt *0.67);

     for i = 1:length(y_w)

         if (i <= time1)

             y_w(i)= 290;

         elseif ( i <= time2) 

             % additional terms clear irregularities induced by changing conditions

             y_w(i) = 9*( x_w(i) - time1 ) + y_w(time1) ;

         else

             y_w(i) = -5*( x_w(i) - time2 ) + y_w(time2) ;

         end
     end
     

end
calc = 1; % prevents multiple plottings


% Plots the agents at their corresponding position
agent_y = zeros(previous - (apti*(current-1)),1);
agent_x = zeros(previous - (apti*(current-1)),1);
 
     
 for i = previous:(apti*(current-1))
     
    time = M(i,2);
    agent_x(i) = round(time/dt);
    
    if (time > 0)
        switch M(i,1)
            case 1
                agent_y(i) = y_p(agent_x(i));    % Polybahn
                agent_x(i) = 18*agent_x(i) + 390;
            case 2
                agent_y(i) = y_t(agent_x(i));    % Tram
                agent_x(i) = 7*agent_x(i) + 390;
            case 3
                agent_y(i) =  y_w(agent_x(i));    % Walking
                agent_x(i) = 5*agent_x(i) + 390;
            case 4
                agent_y(i) = 500;                 % Waiting for Polybahn
                agent_x(i) = 5 * poly_tempw(current);
            case 5
                agent_y(i) = 510;                 % Waiting for tram
                agent_x(i) = 5 * tram_tempw(current);
            case -1
                agent_y(i) = 347;                   % finished
                agent_x(i) = 625;
            otherwise
                agent_y(i) = 200;
                agent_x(i) = 200;
        end
    else
        agent_y(i) = 0;
    end
    
 end

 figure (fid);
 
 imshow(A,map);
 hold on;

 ylim([0 510]); % so that waiting lines are printed correctly

 scatter(agent_x,agent_y, 200, 'fill', 'MarkerEdgeColor','r', 'MarkerFaceColor','g');
 
 % Further option: individual size and color of the different paths, see doc
 % of scatter at http://www.mathworks.ch/ch/help/matlab/ref/scatter.html
 
 hold off;
 pause(0.3);
 
 