% Inputs:
%   ...
%   alpha      - Weight for sparsity.
%   beta       - Weight for spacing penalty.
% Output:
%   fvalue     - Fitness value calculated as:
%                fvalue = psll - alpha*sparsityLevel - beta*spacingPenalty
function fvalue = fitnessFunctionSSP(psll,position,minSpacing,maxSpacing,alpha,beta) %spasity level + space constrains + Psll
    activatedPositions = find(position == 1);
    sparsityLevel = length(activatedPositions)/length(position);
    spacingDiffs = diff(activatedPositions);
    violations = sum(spacingDiffs < minSpacing)+sum(spacingDiffs > maxSpacing);
    spacingPenalty = violations / length(activatedPositions); %normalize.range
    fvalue = psll - alpha * sparsityLevel - beta * spacingPenalty;
end


