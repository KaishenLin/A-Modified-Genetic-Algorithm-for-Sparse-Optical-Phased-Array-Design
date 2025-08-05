% clc;
% close;
% clear;
% 
% pop = population_minmax(5, 20, 2, 5);
% disp(pop);


function population = population_minmax(populationSize, chromosomeSize, minDist, maxDist)
% 生成一个 populationSize x chromosomeSize 的二进制矩阵，
% 每一行都是一个染色体，保证第一个和最后一个位置为1，
% 且任意两个相邻1之间的距离在 [minDist, maxDist] 范围内。
% 初始化种群矩阵
population = zeros(populationSize, chromosomeSize);

% 对于种群中的每一个个体
for i = 1:populationSize
    chrom = zeros(1, chromosomeSize);  % 单个染色体
    pos = 1;                           % 当前1的位置（第一个1固定在位置1）
    chrom(pos) = 1;                    % 设置起点1
    
    % 直到到达染色体末端（即最后一个位置必须为1）
    while pos < chromosomeSize
        remaining = chromosomeSize - pos;  
        % 可能的步长：至少为 minDist，最多为 maxDist，但不能超过剩余长度
        possibleGaps = minDist : min(maxDist, remaining);
        feasibleGaps = [];
        
        % 检查每个可能的步长是否可行
        for gap = possibleGaps
            r = remaining - gap;  % 选择该步长后剩余的长度
            if r == 0
                % 正好走到末尾：一定可行
                feasibleGaps = [feasibleGaps, gap];
            else
                % 若还未走完，必须确保剩下的距离能分成若干步，每步至少 minDist，最多 maxDist。
                % 设剩下需要 k 步，则必须存在整数 k 满足：
                %       k*minDist <= r <= k*maxDist
                % 这要求：ceil(r/maxDist) <= floor(r/minDist)
                k_min = ceil(r / maxDist);
                k_max = floor(r / minDist);
                if k_min <= k_max
                    feasibleGaps = [feasibleGaps, gap];
                end
            end
        end
        
        % 如果没有可行的步长，说明参数不匹配或前面的选择出了问题
        if isempty(feasibleGaps)
            error('在染色体第 %d 个位置时无可行步长，请检查参数设置！', pos);
        end
        
        % 从可行步长中随机选择一个
        chosenGap = feasibleGaps(randi(length(feasibleGaps)));
        pos = pos + chosenGap;  % 移动到下一个1的位置
        chrom(pos) = 1;         % 标记该位置为1
    end
    
    % 保存生成的染色体
    population(i, :) = chrom;
end

end
