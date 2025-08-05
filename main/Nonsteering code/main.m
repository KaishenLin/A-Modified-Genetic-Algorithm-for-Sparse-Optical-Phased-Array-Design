clc;
clear;
close all;

lam = 1550e-9;                    
K = 2 * pi / lam;                  
ang_left = -18;                   
ang_right=18;                    
L = 10001;                         
st_ang = 0;                  % steering angle
space = 1/4 * lam;           
populationSize = 1000;
chromosomeSize = 4000;       % space * chromosomeSize = 1000;
maxiter = 2000;
p_cross = 0.95;     
p_mutation = 0.3; 
minDist = 4;                 % space * minDist = 1;
maxDist = 7;
tournamentSize = 2;
alpha = 90;                  % To control sparsity level

% beta = 0.2;                % Penalty of space violation
V_max = 10;                  % Maximum scaling for beta (controls final value)
k_e = 6;                     % Exponential growth rate factor

elitismCount = 2;            % Number of elites to preserve
globalBestFitness = -inf;     
globalBestSolution = [];


if isempty(gcp('nocreate'))
    parpool; 
end


% %GA - Elite
tic;
pop = population_min(populationSize, chromosomeSize,minDist);
%pop(1,:) = load("bestsolution_640_32.1.csv");
% %Initial population based on the bestsolution of 1lambda
% Initial = struct2array(load('139-23.3687-bestsolu.mat'));
% pop_best = zeros(1, 2000);
% pop_best(1:2:end) = Initial;
% pop_best(end) = 1;
% pop_best(end-1) = 0;
% pop(1,:) = pop_best;
% fitnesses = zeros(1, populationSize);

%Initial population based on the bestsolution of 1/2lambda
% load('normaltest_bestsolu.mat');
% Initial = record_list{10}.bestsolution;
% pop_best = zeros(1, 4000);
% pop_best(1:2:end) = Initial;
% pop_best(end) = 1;
% pop_best(end-1) = 0;
% pop(1,:) = pop_best;
% fitnesses = zeros(1, populationSize);

for iter = 1:maxiter
    % calcualte fitness value
    fitnesses = zeros(populationSize, 1);
    beta_iter = Beta_Adap_exp(iter,maxiter,V_max,k_e);
    parfor i = 1:populationSize
        [t, a] = AF_fft(pop(i, :), ang_left, ang_right, L, K, st_ang,space);
        psll = PSLL(a,t);
        fitnesses(i) = fitnessFunctionSSP (psll,pop(i, :),minDist,alpha,beta_iter);
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
    newpop_c = Crossover(newpop, populationSize - elitismCount, chromosomeSize, p_cross);
    newpop_m = MutationSIM(newpop_c, populationSize - elitismCount, chromosomeSize, p_mutation);
    pop(nonEliteMask, :) = newpop_m;
    pop(eliteIdx, :) = eliteIndividuals; 
    Stop_num = firstOccurrence;
end

elapsedTime = toc;  

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
[theta, AF_dBbest] = AF_grid(bestsolution, ang_left, ang_right, L, K, st_ang,space);

figure;
plot(theta, AF_dBbest, 'LineWidth', 1.5);
grid on;
xlabel('Angle (degrees)');
ylabel('Normalized intensity (dB)');
title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
xlim([ang_left, ang_right]);
ylim([-50, 0.5]); 

pslbest = PSLL(AF_dBbest,theta);
activatedPosition = find(bestsolution == 1);
spacingDiffs = diff(activatedPosition);
illegalnum = sum(spacingDiffs < minDist);
sparsityLevel = actpos/chromosomeSize;

% diary('log.txt')
% disp(['PSLL: ', num2str(pslbest)]);
% disp(['Activate number: ',num2str(actpos)]);
% disp(['SparsityLevel: ',num2str(sparsityLevel)]);
% disp(['Illegal positions: ',num2str(illegalnum)])
% disp(['运行时间: ', num2str(elapsedTime)]);
% disp(['停止进化在：',num2str(Stop_num),'次'])
% diary off




save_normaltest(populationSize, chromosomeSize, maxiter, p_cross, p_mutation,minDist, maxDist, elitismCount, alpha,pslbest, actpos, sparsityLevel, illegalnum, elapsedTime,Stop_num);
save_solution(alpha,pslbest, bestsolution);

%%
% figure;
% plot(angle, Y1, 'LineWidth', 1.5);
% grid on;
% xlabel('Angle (degrees)');
% ylabel('Array Factor (dB)');
% title(['Array Pattern (Steering Angle = ', num2str(0), '°)']);
% xlim([fov.left, fov.right]);
% ylim([-90, 0.5]); 
% 
% Kun1 = PSLL (Y1,angle);
% Kun2 = PSLL (Y2,angle);
% Kun4 = PSLL (Y4,angle);
% 
% function Psll = PSLL(AF_dB, theta)
%     [value, loc] = findpeaks(AF_dB, 'SortStr', 'descend');
%     if length(value) < 2
%         Psll = 0; 
%     else
%         peaksidelobe = max([value(2), AF_dB(1), AF_dB(end)]);
%         Psll = value(1) - peaksidelobe; 
%     end
% end
