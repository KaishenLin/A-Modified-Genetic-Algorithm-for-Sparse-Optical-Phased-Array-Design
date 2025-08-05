clc;
clear;
close all;
%load("normaltest_bestsolu.mat");
% new fitness function  = a_n*e^-jnz, z in [0,z_max]
% True_detect_ang = 18;
ang_left = -112;
ang_right = 112;

lam = 1550e-9;                    
K = 2 * pi / lam;                  
                 
L = 10001;                         

space = 1/2 * lam;             % The limit of 1/2 lam
%z_max = min([pi,2*K*space*sind(True_detect_ang)]);
populationSize = 1000;
chromosomeSize = 2000;       % space * chromosomeSize = 1000;
maxiter = 3000;
p_cross = 0.95;     
p_mutation = 0.3; 
minDist = 2;                 % space * minDist >= 1;

tournamentSize = 2;
alpha = 26;                   % Sparsity level   
beta = 0.2;                 % Penalty of space violation
elitismCount = 2;            % Number of elites to preserve
globalBestFitness = -inf;     
globalBestSolution = [];


if isempty(gcp('nocreate'))
    parpool; 
end


% %GA - Elite
tic;
pop = population_min(populationSize, chromosomeSize,minDist);

%Initial population based on the bestsolution of 1lambda
%Initial = struct2array(load('11行2列的solution.mat'));

load("normaltest_bestsolu.mat");
Initial = record_list{6}.bestsolution;

pop_best = zeros(1, 2000);
pop_best(1:2:end) = Initial;
pop_best(end) = 1;
pop_best(end-1) = 0;
pop(1,:) = pop_best;

% %1/4lambda
% load("normaltest_bestsolu.mat");
% Initial = record_list{30}.bestsolution;
% 
% pop_best = zeros(1, 4000);
% pop_best(1:2:end) = Initial;
% pop_best(end) = 1;
% pop_best(end-1) = 0;
% pop(1,:) = pop_best;



fitnesses = zeros(1, populationSize);
for iter = 1:maxiter
    % calcualte fitness value
    fitnesses = zeros(populationSize, 1);
    parfor i = 1:populationSize
        [t, a] = AF_2D1D_FFT(pop(i, :), ang_left, ang_right, L);
        psll = PSLL(a,t);
        fitnesses(i) = fitnessFunctionSSP (psll,pop(i, :),minDist,alpha,beta);
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
    newpop = tournamentSelection(pop(nonEliteMask, :), fitnesses(nonEliteMask), populationSize - elitismCount, tournamentSize);
    %newpop = RWselection(pop(nonEliteMask, :), fitnesses(nonEliteMask), populationSize - elitismCount);
    newpop_c = Crossover(newpop, populationSize - elitismCount, chromosomeSize, p_cross);
    newpop_m = MutationSIM(newpop_c, populationSize - elitismCount, chromosomeSize, p_mutation);
    pop(nonEliteMask, :) = newpop_m;
    pop(eliteIdx, :) = eliteIndividuals; 
    Stop_num = firstOccurrence;
end

elapsedTime = toc;  % 结束计时并获取时间


% plot
figure;
plot(1:maxiter, bestFitnesses, '-o', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Best Fitness');
title('Convergence of Genetic Algorithm');
grid on;



[value, index] = max(bestFitnesses);
bestsolution = bestSolutions(index,:);
actpos = nnz(bestsolution);

real_left = -18;
real_right = 18;


[theta, AF_dBbest] = AF_grid(bestsolution, real_left, real_right, L, K, 0,space);
pslbest = PSLL(AF_dBbest,theta);
activatedPosition = find(bestsolution == 1);
spacingDiffs = diff(activatedPosition);
illegalnum = sum(spacingDiffs < minDist);
sparsityLevel = actpos/chromosomeSize;


save_2D1D_normaltest(populationSize, chromosomeSize, maxiter, minDist, alpha, pslbest, actpos, sparsityLevel, illegalnum, elapsedTime,Stop_num);
save_2D1D_solution(alpha,space, pslbest, bestsolution)
%%
% left_ang = -60;
% right_ang = 180;
% st_ang = 0;
% 
% 
% 
% 
% figure;
% plot(theta, AF_dBbest, 'LineWidth', 1.5);
% grid on;
% xlabel('Angle (degrees)');
% ylabel('Array Factor (dB)');
% title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
% xlim([left_ang, right_ang]);
% ylim([-50, 0.5]); 
% 
% 
% 
% disp(['PSLL: ', num2str(pslbest)]);





