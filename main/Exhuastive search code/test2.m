clc;
clear;
close all;


A = readmatrix('solutions.csv');
B = readmatrix('result_output_30.csv');

illegal_index = [80977,81972,52797,13392,1681,38513,13081,3,1];
r1 = find(ismember(A, flip(A(80977,:)), 'rows'));
r2 = find(ismember(A, flip(A(81972,:)), 'rows'));
r3 = find(ismember(A, flip(A(52797,:)), 'rows'));
r4 = find(ismember(A, flip(A(13392,:)), 'rows'));
r5 = find(ismember(A, flip(A(1681,:)), 'rows'));
r6 = 72503;
r7= 57644;
r8 = 72453;
r9= 34889;
Psll1 = B(illegal_index,3);
Psll2 = B([r1,r2,r3,r4,r5,r6,r7,r8,r9],3);

for i = 1:length(Psll1)
    fprintf('Psll1(%d) = %.15f, Psll2(%d) = %.15f\n', i, Psll1(i), i, Psll2(i));
end


%%
result = readmatrix('result_output_30.csv');
[sorted_result, sort_idx] = sortrows(result, 2);
unique_ones = unique(sorted_result(:, 2));  
final_result = [];  
for i = 1:length(unique_ones)
    rows = sorted_result(sorted_result(:, 2) == unique_ones(i), :);
    rounded_values = round(rows(:, 3), 7);  
    max_val = max(rounded_values);  
    max_rows = rows(rounded_values == max_val, :);  
    final_result = [final_result; max_rows];  
end


disp(final_result);
%writematrix(final_result, 'final_result.csv');
