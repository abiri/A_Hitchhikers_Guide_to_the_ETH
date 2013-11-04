%Gplot viz with coordinates

% same node legend as in biographviz

<<<<<<< HEAD
<<<<<<< HEAD
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
 
=======
=======
>>>>>>> ccdfd50a73b468157cb93918b6161c42a58c12db
[A,map] = imread('https://github.com/abiri/A_Hitchhikers_Guide_to_the_ETH/blob/master/presentation/Maps_GeoAdmin.png?raw=true','png');
% Image resolution: 787 * 494

imshow(A);
showaxes

hold on;

x1 = 418 ; y1 = 308; x2 = 597; y2 = 297; % stupid Matlab syntax
% Polybahn
line([x1,x2], [y1,y2], 'LineWidth',3,'Color','r');

% Tram
line([418,447], [308,43], 'LineWidth',3,'Color','r');
line([447,612], [43,287], 'LineWidth',3,'Color','r');

% Fussweg
line([418,544], [308,465], 'LineWidth',3,'Color','r');
line([544,639], [465,407], 'LineWidth',3,'Color','r');

hold off;

% Links = [0 1 1 1 0; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 0];
% Coord = [1 0; 4 -3; 4 0; 8 -2.5; 15 -3 ];
% gplot(Links,Coord,'-o')
<<<<<<< HEAD
% axis ( [-2 16 -5 2 ] )
>>>>>>> ccdfd50a73b468157cb93918b6161c42a58c12db
=======
% axis ( [-2 16 -5 2 ] )
>>>>>>> ccdfd50a73b468157cb93918b6161c42a58c12db
