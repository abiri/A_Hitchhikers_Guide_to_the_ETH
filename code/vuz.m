 x_w = 0: time_walk/ dt' ;
 y_w = 0: time_walk / dt  ;
 
 for i = 1:length(x_w)
     
     if (i<=floor(time_walk / dt*0.2)+1)
         
         y_w(i)= 4;
         
     elseif (i>floor(time_span / dt*0.2)+1 && i <=floor(time_span / dt*0.6)+1) 
         
         % additional terms clear irregularities induced by changing
         % conditions
         
         y_w(i) = 2*x_w(i) + y_w(floor(time_span / dt*0.2)+1) - 2*(floor(time_span / dt*0.2)+1);
         
     else
         
         y_w(i) = -3*x_w(i) + y_w(floor(time_span / dt*0.6)+1) + 3*(floor(time_span / dt*0.6)+1);
     
      end
    
 end
 fid = figure;
   
 for k = previous:(apti*(i-1))
     hold on
     for ii = 1 : length(y)
     
 