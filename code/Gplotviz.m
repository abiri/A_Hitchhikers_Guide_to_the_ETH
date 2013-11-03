%Gplot viz with coordinates
%[A,map]=imread('C:\Users\Monkey D
%Zorro\Documents\GitHub\Main_Branch\presentation\Maps_GeoAdmin','png')%
% same node legend as in biographviz

%Links = [0 1 1 1 0; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 0];
%Coord = [1 0; 4 -3; 4 0; 8 -2.5; 15 -3 ];
%gplot(Links,Coord,'-o')
%axis ( [-2 16 -5 2 ] )
 x=[0:0.1:16]';
 y=[0:0.1:16];
 for i = 1:length(x)
     if (i<=31)
         y(i)= 4;
     elseif (i>31 && i <=81) 
         
         y(i) = 2*x(i)-2.2;
         
     else
         
         y(i) = -3*x(i)+y(81) + 3 * 8.1;
     
     end
    
 end
fid=figure;
hold on
 plot(x,y)
 
 writerObj = VideoWriter('path.avi');
 writerObj.FrameRate = 60;
 open(writerObj); 
 
 for ii=1:size(y)      
    % We just use pause but pretend you have some really complicated thing here...
    pause(0.1);
    figure(fid); % Makes sure you use your desired frame.
    plot(x(ii),y(ii),'or');
    
       %if mod(i,4)==0, % Uncomment to take 1 out of every 4 frames.
        frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
        writeVideo(writerObj, frame);
    %end
 
 end
hold off
close(writerObj); % Saves the movie.
 