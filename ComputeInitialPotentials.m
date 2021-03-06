%COMPUTEINITIALPOTENTIALS Sets up the cliques in the clique tree that is
%passed in as a parameter.
%
%   P = COMPUTEINITIALPOTENTIALS(C) Takes the clique tree skeleton C which is a
%   struct with three fields:
%   - nodes: cell array representing the cliques in the tree.
%   - edges: represents the adjacency matrix of the tree.
%   - factorList: represents the list of factors that were used to build
%   the tree. 
%   
%   It returns the standard form of a clique tree P that we will use through 
%   the rest of the assigment. P is struct with two fields:
%   - cliqueList: represents an array of cliques with appropriate factors 
%   from factorList assigned to each clique. Where the .val of each clique
%   is initialized to the initial potential of that clique.
%   - edges: represents the adjacency matrix of the tree. 
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function P = ComputeInitialPotentials(C)

% number of cliques
N = length(C.nodes);

% initialize cluster potentials 
P.cliqueList = repmat(struct('var', [], 'card', [], 'val', []), N, 1);
P.edges = zeros(N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% First, compute an assignment of factors from factorList to cliques. 
% Then use that assignment to initialize the cliques in cliqueList to 
% their initial potentials. 

% C.nodes is a list of cliques.
% So in your code, you should start with: P.cliqueList(i).var = C.nodes{i};
% Print out C to get a better understanding of its structure.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P.edges = C.edges;

%Initial P.cliqueList.var and .card: (1,2);(0,0)
for i = 1:N
    P.cliqueList(i).var = C.nodes{i};
    P.cliqueList(i).card = zeros(1,length(P.cliqueList(i).var));
end

M = length(C.factorList);
tC = zeros(1,M);

for j = 1:N
    for i = 1:M
        % check whether C.factorList(i).var is a subset of P.cliqueList.var(j)
        % set P.cliqueList.card: (1,3)
        [TF,S_IDX] = ismember(C.factorList(i).var,P.cliqueList(j).var) ;
        for k = 1:length(S_IDX)
            if(TF(k))
                P.cliqueList(j).card(S_IDX(k)) = C.factorList(i).card(k);
            end
        end
        % is already assign skip
        if(all(TF) && tC(i) == 0)
            tC(i) = j;
        end
    end
end

for i = 1:N
    P.cliqueList(i).val = ones(1,prod(P.cliqueList(i).card));
end

for i = 1:M
     P.cliqueList(tC(i)) = FactorProduct(P.cliqueList(tC(i)),C.factorList(i));
end

end

