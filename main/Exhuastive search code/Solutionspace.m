clc;
close all;
clear;
minGap = 2;  
maxGap = 6;  
chromosomeSize = 30;
generateSolutions(minGap, maxGap, chromosomeSize);
function generateSolutions(minGap, maxGap, chromosomeSize)
    allSolutions = {};  
    currentSeq = 1;     
    allSolutions = recEnumerate(1, currentSeq, allSolutions, minGap, maxGap, chromosomeSize);
    solutionMatrix = cell2mat(allSolutions');
    csvFileName = sprintf('%d-%d-%d-solutions.csv', minGap, maxGap, chromosomeSize);
    writematrix(solutionMatrix, csvFileName);
    fprintf('Found %d solutions and saved as %s\n', size(solutionMatrix, 1), csvFileName);
end
function allSolutions = recEnumerate(current, currentSeq, allSolutions, minGap, maxGap, chromosomeSize)
    
    if current == chromosomeSize
        sol = zeros(1, chromosomeSize);
        sol(currentSeq) = 1;
        allSolutions{end+1} = sol;
        return;
    end
    for gap = minGap:maxGap
        next = current + gap;
        if next <= chromosomeSize
            allSolutions = recEnumerate(next, [currentSeq, next], allSolutions, minGap, maxGap, chromosomeSize);
        end
    end
end
