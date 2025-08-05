% Inputs:
%   ...
%   alpha      - Weight for sparsity.
%   beta       - Weight for spacing penalty.
% Output:
%   fvalue     - Fitness value calculated as:
%                fvalue = psll - alpha*sparsityLevel - beta*spacingPenalty
function fvalue = fitnessFunctionSSP(psll,position,minSpacing,alpha,beta) %spasity level + space constrains + Psll
    activatedPositions = find(position == 1);    
    spacingDiffs = diff(activatedPositions);
    violations = sum(spacingDiffs < minSpacing);
    spacingPenalty = violations;
    sparsityLevel = length(activatedPositions)/length(position);
    fvalue = psll - alpha * sparsityLevel - beta * spacingPenalty;
end


