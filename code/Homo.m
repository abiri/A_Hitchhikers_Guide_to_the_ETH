function M = Homo()
%Initializes homogonous agents

load data;

% Calculate sum of all agents
agents = 0;
for i = 1:(time_span/dt)
    agents = agents + 1 + ceil( apti*abs(sin(2*pi/60 * i)) );
end

attributes = 3;

M = zeros(agents,attributes);

% Attribute 1: Path chosen

% Attribute 2: Time on the way

% Attributes 3: Time waiting

 