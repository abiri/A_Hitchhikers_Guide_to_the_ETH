% Matrix mit den Verbindungen 
% knoten 1 == Central 
% Knoten 2 == Polybahn
% Knoten 3 == Tramhaltestelle Central
% Knoten 4 == Fussweg unter Polybahn
% Knoten  == Eth HG 




Links = [0 1 1 1 0; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 1; 0 0 0 0 0];
ids = {'Central'; 'Polybahn'; 'Tramstop'; 'under poly walk'; 'ETH HG'};
viz = biograph(Links,ids);
get(viz.nodes,'ID')
view(viz)