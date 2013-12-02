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

             y_w(i) = 9*( x_w(i) - time1 ) + y_w(time1) ;

         else

             y_w(i) = -5*( x_w(i) - time2 ) + y_w(time2) ;

         end
     end
     

end
calc = 1; % prevents multiple plottings


% Plots the agents at their corresponding position
agent_y = zeros(old_top - previous,1);
agent_x = zeros( old_top - previous,1);
plot_size = ones( old_top - previous,1);

plot_poly = 300;
plot_tram = 400;
plot_walk = 80;
plot_wait = 200;
     
until = old_top - previous;

 for i = 1:(until+1)
     
    time = M(i+(previous-1),2);
    agent_x(i) = round(time/dt);
    
    if (time > 0)
        switch M(i+(previous-1),1)
            case 1
                agent_y(i) = y_p(agent_x(i));     % Polybahn
                agent_x(i) = 18*agent_x(i) + 390;
                plot_size(i) = plot_poly;
            case 2
                agent_y(i) = y_t(agent_x(i));     % Tram
                agent_x(i) = 7*agent_x(i) + 390;
                plot_size(i) = plot_tram;
            case 3
                agent_y(i) =  y_w(agent_x(i));    % Walking
                agent_x(i) = 5*agent_x(i) + 390;
                plot_size(i) = plot_walk;
        end
    elseif ( M(i+(previous-1),1) > 3 )
        switch M(i+(previous-1),1)
            case 4
                agent_y(i) = 500;                  % Waiting for Polybahn
                agent_x(i) = 5 * poly_tempw(current);
                plot_size(i) = plot_wait;
            case 5
                agent_y(i) = 520;                  % Waiting for tram
                agent_x(i) = 5 * tram_tempw(current);
                plot_size(i) = plot_wait;
            case -1
                agent_y(i) = 347;                  % finished
                agent_x(i) = 625;
                plot_size(i) = plot_wait;
            otherwise
                X = fprintf('There was an agent with path %d and waiting time %d\n', M(i+(previous-1),1), M(i+(previous-1),3));
                agent_y(i) = 200;
                agent_x(i) = 200;
                plot_size(i) = plot_wait;
        end
    else
        agent_y(i) = 0;
        plot_size(i) = 1;
    end
    
 end

 figure (fid);
 
 imshow(A,map);
 hold on;

 ylim([0 550]); % so that waiting lines are printed correctly
 
 scatter(agent_x,agent_y, plot_size, 'fill', 'MarkerEdgeColor','r', 'MarkerFaceColor','g');
 
 frame = getframe(fid);
 writeVideo(video,frame);
 
 hold off;
 %pause(0.1);
 
 