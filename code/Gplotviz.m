%Gplot viz with coordinates

% same node legend as in biographviz

[A,map] = imread('https://github.com/abiri/A_Hitchhikers_Guide_to_the_ETH/blob/master/presentation/Maps_GeoAdmin.png?raw=true','png');
% Image resolution: 787 * 494
x = 787;
y = 494;

imshow(A);
showaxes

hold on;
axis ij;

% rectangle('Position',[10 10 700 400])
% line([100,100],[200,200], 'LineWidth',3,'Color','r');

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
% axis ( [-2 16 -5 2 ] )