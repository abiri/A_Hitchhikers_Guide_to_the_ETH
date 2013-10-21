% Initializing agents list; rows are agents, colum are attributes
agents = 100;
attibutes = 6;

M = zeros(agents,attributes);

% Attribute 1 : stress
stress_low = 40;
stress_high = 60;

% Attribute 2 : physical shape 
shape_low = 60;
shape_high = 90;

% Attribute 3 : form of the day / tiredness
tired_low = 10;
tired_high = 90;

% Attribute 4 : social bonding
bond_low = 20;
bond_high = 40;

% Attribute 5 : habit
habit_low = 0;
habit_high = 1;

% Attribute 6 : tbd
attr_low = 0;
attr_high = 0;
  
% Set attributes

M(:,1) = stress_low + round((stress_high - stress_low)*rand(agents));

M(:,2) = shape_low + round((shape_high - shape_low)*rand(agents));

M(:,3) = tired_low + round((tired_high - tired_low)*rand(agents));

M(:,4) = bond_low + round((bond_high - bond_low)*rand(agents));

M(:,5) = habit_low + round((habit_high - habit_low)*rand(agents));

M(:,6) = attr_low + round((attr_high - attr_low)*rand(agents));

 
