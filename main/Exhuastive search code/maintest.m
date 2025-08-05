clc;
clear;
close all;

% Define parameters
lam = 1550e-9;                  % Wavelength (m)
K = 2 * pi / lam;               % Wavenumber
ang_left = -90;                 % Left angle limit (degrees)
ang_right = 90;                 % Right angle limit (degrees)
L = 10001;                      % Number of sampling points
st_ang = 0;                     % Starting angle
space = 0.4 * lam;              % Element spacing
filename = 'solutions.csv';     % Input file name

% Read solutions from CSV file
A = readmatrix(filename);
numSolutions = size(A, 1);      % Number of solutions
countOnes = sum(A, 2);          % Count of active elements
PSLL_values = zeros(numSolutions, 1); % Initialize PSLL values

% Initialize parallel pool if not already running
if isempty(gcp('nocreate'))
    parpool;
end

% Compute PSLL for each solution in parallel
parfor i = 1:numSolutions
    [t, a] = AF_grid(A(i, :), ang_left, ang_right, L, K, st_ang, space);
    PSLL_values(i) = PSLL(a, t);
end

% Save results to CSV file
result = [(1:numSolutions)', countOnes, PSLL_values];
output_filename = 'result_output_30.csv';
headers = {'SolutionIndex', 'Num', 'PSLL'};
writecell(headers, output_filename);
writematrix(result, output_filename, 'WriteMode', 'append');

%% Process results: Select the worst-case PSLL for each unique count of ones
result = readmatrix(output_filename);
[sorted_result, ~] = sortrows(result, 2);
unique_ones = unique(sorted_result(:, 2));
final_result = [];

for i = 1:length(unique_ones)
    rows = sorted_result(sorted_result(:, 2) == unique_ones(i), :);
    rounded_values = round(rows(:, 3), 8);
    max_val = max(rounded_values);
    max_rows = rows(rounded_values == max_val, :);
    final_result = [final_result; max_rows];
end

% Save the final selected results
writematrix(final_result, 'final_result.csv');


