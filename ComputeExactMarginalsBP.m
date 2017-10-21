%COMPUTEEXACTMARGINALSBP Runs exact inference and returns the marginals
%over all the variables (if isMax == 0) or the max-marginals (if isMax == 1). 
%
%   M = COMPUTEEXACTMARGINALSBP(F, E, isMax) takes a list of factors F,
%   evidence E, and a flag isMax, runs exact inference and returns the
%   final marginals for the variables in the network. If isMax is 1, then
%   it runs exact MAP inference, otherwise exact inference (sum-prod).
%   It returns an array of size equal to the number of variables in the 
%   network where M(i) represents the ith variable and M(i).val represents 
%   the marginals of the ith variable. 
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function M = ComputeExactMarginalsBP(F, E, isMax)

% initialization
% you should set it to the correct value in your code
M = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% Implement Exact and MAP Inference.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


P = CreateCliqueTree(F, E);

P = CliqueTreeCalibrate(P, isMax);

v = [];
for i = 1:length(F)
    v = [v,[F(i).var]];
end

V = unique(v);
M = repmat(struct('var', [], 'card', [], 'val', []), length(V), 1);
for i = 1:length(P)
    for j = 1: length(P(i).var)
        id = find(V==(P(i).var(j)))
        if isempty(M(id))
            t = ComputeMarginal(P(i).var(j), P(i), []);
            M(id).var = t.var
            M(id).card = t.card
            M(id).val = t.val
        end
    end   
end









end
