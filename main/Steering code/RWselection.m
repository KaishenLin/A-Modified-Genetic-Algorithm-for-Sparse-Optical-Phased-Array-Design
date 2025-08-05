% function newpop = RWselection(pop,fitnesses,populationSize)
% 
% fitvalue = fitnesses / sum(fitnesses);  
% p_fitvalue = cumsum(fitvalue);          
% q_rand = sort(rand(populationSize,1));  
%     [~, chromosomeSize] = size(pop);
% newpop = zeros(populationSize, chromosomeSize);  % 初始化新种群
% i = 1;  % Pointer for random numbers
% j = 1;  % Pointer for cumulative probability intervals
% 
% while i <= populationSize
%     if q_rand(i) < p_fitvalue(j)
%         newpop(i,:) = pop(j,:);  % Higher fitness genes have a higher probability of being selected
%         i = i + 1;
%     else
%         j = j + 1;  % Move to the next probability interval when the current one is exhausted
%     end
% end
% end
% 
% function newpop = RWselection(pop, fitnesses, populationSize)
% 
%     [~, chromosomeSize] = size(pop);
% 
%     % Pre-allocate the new population matrix
%     newpop = zeros(populationSize, chromosomeSize);
% 
%     % Calculate fitness probabilities
%     fitvalue = fitnesses / sum(fitnesses);
% 
%     % Compute cumulative probabilities and ensure the last value is 1
%     p_fitvalue = cumsum(fitvalue);
%     p_fitvalue(end) = 1;  % Force the cumulative sum to exactly 1 to avoid floating-point issues
% 
%     % Generate and sort random numbers for selection
%     q_rand = sort(rand(populationSize, 1));
% 
%     % Initialize pointers
%     i = 1;  % Index for q_rand (random numbers)
%     j = 1;  % Index for p_fitvalue (cumulative probabilities)
% 
%     % Perform roulette wheel selection
%     while i <= populationSize
%         if j > populationSize
%             % If j exceeds populationSize, fill the remaining rows with the last individual
%             newpop(i:end, :) = repmat(pop(end, :), populationSize - i + 1, 1);
%             break;
%         end
%         if q_rand(i) < p_fitvalue(j)
% 
%             newpop(i, :) = pop(j, :);
%             i = i + 1;
%         else
%             % Otherwise, move to the next cumulative probability interval
%             j = j + 1;
%         end
%     end
% end


function newpop = RWselection(pop, fitnesses, populationSize)
    min_fitness = min(fitnesses);
    fitnesses_shifted = fitnesses - min_fitness+1;  % 将适应度平移至非负范围
    fitvalue = fitnesses_shifted / sum(fitnesses_shifted);

    % 计算累积适应度
    p_fitvalue = cumsum(fitvalue);
    p_fitvalue(end) = 1; % 确保最后一个值为1

    % 生成随机数并排序
    q_rand = sort(rand(populationSize, 1));

    % 初始化新种群
    [~, chromosomeSize] = size(pop);
    newpop = zeros(populationSize, chromosomeSize);

    i = 1;  % 指向随机数
    j = 1;  % 指向累积适应度

    % 选择过程
    while i <= populationSize
        if q_rand(i) < p_fitvalue(j)
            newpop(i, :) = pop(j, :);
            i = i + 1;
        else
            j = j + 1;
        end
    end
end
