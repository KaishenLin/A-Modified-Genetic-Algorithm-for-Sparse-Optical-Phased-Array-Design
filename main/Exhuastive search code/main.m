
clc;
clear;
close all;

   
lam = 1550e-9;                    
K = 2 * pi / lam;                  
ang_left = -90;                   
ang_right = 90;                    
L = 10001;                         
st_ang = 0;                  % steering angle
space = 0.4 * lam;             % The limit of 1/2 lam
populationSize = 50;
chromosomeSize = 30;       % space * chromosomeSize = 1000;
maxiter = 500;
p_cross = 0.95;     
p_mutation = 0.5; 

minDist = 2;                 % space * minDist >= 1;
maxDist = 5;
tournamentSize = 2;
alpha =59;  

% Sparsity level
beta = 200;                  % Penalty of space violation
elitismCount =2;            % Number of elites to preserve
globalBestFitness = -inf;     
globalBestSolution = [];
% Initialize population
pop = population_minmax(populationSize, chromosomeSize,minDist,maxDist);
fitnesses = zeros(1, populationSize);
if isempty(gcp('nocreate'))
    parpool; 
end

%mpiprofile on

tic;
% %GA - Elite
for iter = 1:maxiter
    % calcualte fitness value
    fitnesses = zeros(populationSize, 1);
    parfor i = 1:populationSize
        [t, a] = AF_fft(pop(i, :), ang_left, ang_right, L, K, st_ang,space);
        psll = PSLL(a,t);
        fitnesses(i) = fitnessFunctionSSP (psll,pop(i, :),minDist,maxDist,alpha,beta);
    end

    [bestFitness, bestIdx] = max(fitnesses); 
    bestSolutions(iter, :) = pop(bestIdx, :);
    bestFitnesses(iter) = bestFitness;

    if bestFitness > globalBestFitness
        globalBestFitness = bestFitness;
        globalBestSolution = pop(bestIdx, :);
        firstOccurrence = iter;
    end

    [~, eliteIdx] = maxk(fitnesses, elitismCount); 
    eliteIndividuals = pop(eliteIdx, :);

    nonEliteMask = true(populationSize, 1);
    nonEliteMask(eliteIdx) = false; % set the elit position to false
    % Selection, crossover, and mutation for non-elite individuals
    %use tournament selection operator 
    %newpop = tournamentSelection(pop(nonEliteMask, :), fitnesses(nonEliteMask), populationSize - elitismCount, tournamentSize);
    %use roulette wheel selection operator
    newpop = RWselection(pop(nonEliteMask, :), fitnesses(nonEliteMask), populationSize - elitismCount);
    newpop_c = Crossover(newpop, populationSize - elitismCount, chromosomeSize, p_cross);
    newpop_m = MutationSIM(newpop_c, populationSize - elitismCount, chromosomeSize,p_mutation);
    pop(nonEliteMask, :) = newpop_m;
    pop(eliteIdx, :) = eliteIndividuals; 
    Stop_num = firstOccurrence;
end
% mpiprofile off
% mpiprofile viewer
elapsedTime = toc;  % 结束计时并获取时间


% plot
figure;
plot(1:maxiter, bestFitnesses, '-o', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Best Fitness');
title('Convergence of Modified GA');
grid on;

[value, index] = max(bestFitnesses);
bestsolution = bestSolutions(index,:);
actpos = nnz(bestsolution);
[theta, AF_dBbest] = AF_grid(bestsolution, ang_left, ang_right, L, K, st_ang,space);


figure;
plot(theta, AF_dBbest, 'LineWidth', 1.5);
grid on;
xlabel('Angle (degrees)');
ylabel('Array Factor (dB)');
title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
xlim([ang_left, ang_right]);
ylim([-50, 0.5]); 

pslbest = PSLL(AF_dBbest,theta);

activatedPosition = find(bestsolution == 1);
spacingDiffs = diff(activatedPosition);
illegalnum = sum(spacingDiffs < minDist)+sum(spacingDiffs > maxDist);
sparsityLevel = actpos/chromosomeSize;


disp(['PSLL: ', num2str(pslbest)]);
disp(['Activate number: ',num2str(actpos)]);
disp(['SparsityLevel: ',num2str(sparsityLevel)]);
disp(['Illegal positions: ',num2str(illegalnum)])
disp(['运行时间: ', num2str(elapsedTime)]);
disp(['停止进化在：',num2str(Stop_num),'次'])


%save1(populationSize, chromosomeSize, maxiter, p_cross, p_mutation,minDist, maxDist, elitismCount, alpha, beta,pslbest, actpos, sparsityLevel, illegalnum, elapsedTime,Stop_num);


