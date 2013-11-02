%Gplot viz with coordinates
%[A,map]=imread('C:\Users\Monkey D
%Zorro\Documents\GitHub\Main_Branch\presentation\Maps_GeoAdmin','png')%
% same node legend as in biographviz

Links = [0 1 1 1 0; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 0];
Coord = [1 0; 4 -3; 4 0; 8 -2.5; 15 -3 ];
gplot(Links,Coord,'-o')
axis ( [-2 16 -5 2 ] )