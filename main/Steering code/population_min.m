% clc;
% clear;
% close all;
% 
% population = population_min(5, 30, 2);
% disp(population)
% max(diff(find(population(1,:)==1)));

function population = population_min(populationSize, chromosomeSize, minDist)
    population = zeros(populationSize, chromosomeSize); % 初始化种群
    
    for i = 1:populationSize
        while true
           
            chromosome = zeros(1, chromosomeSize);
            chromosome(1) = 1; % 第一个位置固定为1
            chromosome(end) = 1; % 最后一个位置固定为1
          
            idx = 1+minDist; % 当前位置
            
            while idx <= chromosomeSize - 1
                if rand > 0.49  
                    chromosome(idx) = 1;
                    idx = idx + minDist; 
                else
                    idx = idx + 1;
                end
            end
            
            onesIdx = find(chromosome == 1);
            if all(diff(onesIdx) >= minDist)
                population(i, :) = chromosome;
                break;
            end
        end
    end
end

