% clc;
% clear;
% close all;
% 
% % 假设有 98 个个体的适应度值（随机生成）
% fitness = randi([1, 20], 1, 20); 
% pop = fitness';
% % 设置选择数量等于种群大小，确保一致
% numSelect = 20; 
% tournamentSize = 3;  % 每次竞标赛 3 个个体
% 
% % 运行竞标赛选择
% newpop = tournamentSelection(pop,fitness, numSelect, tournamentSize);
% 
% % 输出验证
% disp(['输入种群大小: ', num2str(length(fitness))]);
% disp(newpop);
% %disp(['输出选择大小: ', num2str(length(selected))]);
% % disp('选中的个体索引:');
% % disp(selected);


function newpop = tournamentSelection(pop, fitnesses, populationSize, tournamentSize)
    [~, chromosomeSize] = size(pop);  % 获取染色体大小
    newpop = zeros(populationSize, chromosomeSize);  % 初始化新种群
    selectedIndices = zeros(populationSize, 1);  % 预分配空间
    
    for i = 1:populationSize
        % 随机挑选 tournamentSize 个个体进行锦标赛
        competitors = randperm(populationSize, tournamentSize);
        
        % 选择适应度最好的个体
        [~, bestIdx] = max(fitnesses(competitors));
        
        % 将最优个体的索引保存到 selectedIndices
        selectedIndices(i) = competitors(bestIdx);
    end
    
    % 用选择的个体填充新种群
    newpop = pop(selectedIndices, :);
end



