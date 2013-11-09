function M = Homo()
%Initializes homogonous agents

load data;

agents = apti * time_span / dt;
attributes = 2;

M = zeros(agents,attributes);

% Attribute 1: Path chosen

% Attribute 2: Time on way

 