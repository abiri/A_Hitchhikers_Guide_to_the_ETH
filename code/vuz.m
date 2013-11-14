
% Draws the agents on the map 

load data;

x_w = zeros(time_walk/dt,1);
y_w = zeros(time_walk/dt,1);
 
 for i = 1:length(x_w)
     
     if (i <= ceil(time_walk / dt *0.2))
         
         y_w(i)= 4;
         
     elseif (i > ceil(time_walk/dt * 0.2) && i <= ceil(time_walk/dt * 0.6)) 
         
         % additional terms clear irregularities induced by changing
         % conditions
         
         y_w(i) = 2*x_w(i) + y_w(ceil(time_walk/dt * 0.2)) - 2*(ceil(time_walk/dt * 0.2));
         
     else
         
         y_w(i) = -3*x_w(i) + y_w(ceil(time_walk/dt * 0.6)) + 3*(ceil(time_walk/dt * 0.6));
     
     end
    
 end
 fid = figure;  
   
 z_w = zeros(time_walk/dt,1);
 
 for k = previous:(apti*(i-1))
     hold on

     for i = 1:length(M(:,2))
        z_w =  y_w(M(i,2));          % calculate plot matrix
     end
     
     plot(x_y,z_w); %% not sure if correct
 
     hold off
 end
     
 