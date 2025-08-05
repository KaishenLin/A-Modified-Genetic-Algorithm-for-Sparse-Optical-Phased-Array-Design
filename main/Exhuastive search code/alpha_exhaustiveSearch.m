clc;
close all;
clear;


data = readmatrix('final_result.csv');
data = data(:, [2, 3]);

number = data(:,1);
PSLL = data(:,2);
sparsitylevel = number / 30;
alpha = 0:0.5:100;
num_alpha = length(alpha);
num_data = length(number);

% 预分配结果矩阵
result = zeros(num_data * num_alpha, 5);

% 计算并存储结果
row_idx = 1;
for i = 1:num_data
    for j = 1:num_alpha
        final_value = PSLL(i) - alpha(j) * sparsitylevel(i);
        result(row_idx, :) = [number(i), sparsitylevel(i), PSLL(i), alpha(j), final_value];
        row_idx = row_idx + 1;
    end
end

% 按 alpha 排序（默认已经从小到大）
sorted_result = sortrows(result, 4);

% 找到相同 alpha 下 FinalResult 的最大值对应的整行数据
alpha_unique = unique(sorted_result(:,4)); % 获取唯一的 alpha 值
max_rows = zeros(length(alpha_unique), 5); % 存储最终结果

for i = 1:length(alpha_unique)
    alpha_value = alpha_unique(i);
    % 筛选相同 alpha 的行
    mask = sorted_result(:,4) == alpha_value;
    subset = sorted_result(mask, :); % 选出当前 alpha 相关的所有行
    [~, max_idx] = max(subset(:,5)); % 找到 FinalResult 最大值的索引
    max_rows(i, :) = subset(max_idx, :); % 选取对应的完整行
end

headers = {'Number', 'SparsityLevel', 'PSLL', 'Alpha', 'FinalResult'};
writecell(headers, 'max_psll_alpha_full_results.csv');
writematrix(max_rows, 'max_psll_alpha_full_results.csv', 'WriteMode', 'append');
