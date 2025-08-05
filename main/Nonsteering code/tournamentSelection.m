function newpop = tournamentSelection(pop, fitnesses, populationSize, tournamentSize)
    [~, chromosomeSize] = size(pop);  
    newpop = zeros(populationSize, chromosomeSize); 
    selectedIndices = zeros(populationSize, 1);  
    for i = 1:populationSize
        competitors = randperm(populationSize, tournamentSize);
        [~, bestIdx] = max(fitnesses(competitors));
        selectedIndices(i) = competitors(bestIdx);
    end
    newpop = pop(selectedIndices, :);
end



