function M = Homo()
%Initializes homogonous agents

load data;

agents = dt * apti * time_span;
attributes = 2;

M = zeros(agents,attributes);

% Attribute 1: Path chosen

% Attribute 2: Time on way

 