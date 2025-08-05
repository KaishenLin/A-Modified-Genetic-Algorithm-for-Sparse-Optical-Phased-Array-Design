clc;
clear;

x= [0
0
10
10
14
15
16
18
20
20
30
30
40
40
40
50
50
60
60
70
70
80
80
90
90
100
100];

y1 =[635
640
604
587
536
412
361
337
299
306
124
115
108
119
86
71
78
75
64
51
64
51
59
49
49
42
44];

y2=[32.4512
32.17612625
32.2945
32.30555198
31.6986
27.5168
26.62513153
26.1901
25.7165
26.68966411
22.0142
22.21116991
21.114
17.1645
19.79065408
18.4023
18.55468234
17.3441
18.18699683
14.714
17.62360768
15.4876
16.57714472
15.3346
15.24528198
13.4957
14.67069673];
%%
% 数据

x = [0 10 15 16  20 24 30 40 50 60 70 80 90 100];
y1 = [637.5 595.5 418.5 361  302.5 135.5 119.5 104.3333333 74.5 69.5 57.5 55 49 43];
y2 = [32.31366313 32.30002599 28.2084 26.62513153 26.20308206  23.21105	22.11268496 19.35638469 18.47849117 17.76554842 16.16880384 16.03237236 15.28994099 14.08319837];

% 创建图形
figure('Units', 'inches', 'Position', [1, 1, 3.5, 2.8]);
set(gcf, 'Color', 'white');

% 绘制双 y 轴图
yyaxis left;
plot(x, y1, '-o', 'LineWidth', 1.2, 'MarkerSize', 5, 'Color', [0 0.447 0.741], ...
    'MarkerFaceColor', [0 0.447 0.741], 'DisplayName', 'Nuber of antenna');
ylabel('Antenna', 'FontName', 'Times New Roman', 'FontSize', 12, ... % 10 -> 12
    'Color', [0 0.447 0.741]);
set(gca, 'YColor', [0 0.447 0.741]);

yyaxis right;
plot(x, y2, '--s', 'LineWidth', 1.2, 'MarkerSize', 5, 'Color', [0.85 0.325 0.098], ...
    'MarkerFaceColor', [0.85 0.325 0.098], 'DisplayName', 'PSLL');
ylabel('PSLL', 'FontName', 'Times New Roman', 'FontSize', 12, ... % 10 -> 12
    'Color', [0.85 0.325 0.098]);
set(gca, 'YColor', [0.85 0.325 0.098]);

% 设置坐标轴属性
xlabel('Alpha', 'FontName', 'Times New Roman', 'FontSize', 12); % 10 -> 12

set(gca, 'FontName', 'Times New Roman', 'FontSize', 12, ... % 10 -> 12（刻度标签）
    'LineWidth', 0.8, 'Box', 'on', 'TickDir', 'out');
set(gca, 'XTick', 0:20:100);

% 浅色网格
grid on;
set(gca, 'GridColor', [0.85 0.85 0.85], 'GridAlpha', 0.5, 'MinorGridAlpha', 0.2);

% 图例
legend('show', 'FontName', 'Times New Roman', 'FontSize', 12, ... % 10 -> 12
    'Location', 'northeast', 'Box', 'off', 'EdgeColor', 'none', 'Color', 'none');



%% 
% B1 = reshape(final_psll,[],size(final_psll,3));
% B2 = reshape(first_24_iter,[],size(first_24_iter,3));


% num_ones = cell(length(mutation_rates), length(crossover_rates), num_experiments);
% 
% for i = 1:length(mutation_rates)
%     for j = 1:length(crossover_rates)
%         for exp = 1:num_experiments
%             % 获取 final_position 中的每个位置向量
%             position_vector = final_position{i, j, exp};
% 
%             % 统计 position_vector 中 1 的数量
%             num_ones{i, j, exp} = nnz(position_vector == 1);  % nnz counts non-zero elements, so this counts the 1's
%         end
%     end
% end
% 
% mean_column = mean(avg_psll,1);



%% count one

%%
matrix_data = readmatrix('处理.xlsx');
alpha = matrix_data(:, 1);  % 第一列: alpha
psll = matrix_data(:, 2);   % 第二列: psll
activatenumber = matrix_data(:, 3);  % 第三列: activateNumber
figure;
scatter(alpha,activatenumber)
figure;
scatter(alpha,psll)
figure;
plotyy(alpha,psll,alpha,activatenumber,@stem,@stem)
%%
figure;
scatter(activatenumber,psll)

%%
A = [
    20.360  20.970  21.240  21.968 22.218 22.145;
    20.547  21.307  21.720  22.036 22.146 22.106;
    20.263  21.658  21.617  23.662 23.802 23.749;
    28.094  28.069  28.864  29.296 29.456 29.339;
    23.283  23.011  23.012  23.056 23.280 23.000;

];



%%
%mesh
data = load("avg.mat");
mat = struct2array(data);  % 确保 mat 是数值数组

% 设置坐标轴变量
y = [0.01, 0.05, 0.1, 0.3, 0.6];
x = [0.6, 0.7, 0.8, 0.9 0.95 0.97];
[X, Y] = meshgrid(x, y);

% 创建网格图
figure;
mesh(X, Y, A);

% 设置标签，符合 IEEE 风格
xlabel('Crossover rate', 'Interpreter', 'latex', 'FontSize', 15);
ylabel('Mutation rate', 'Interpreter', 'latex', 'FontSize', 15);
zlabel('PSLL', 'Interpreter', 'latex', 'FontSize', 15);



% 设置图形风格符合 IEEE 格式
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
grid on;
box on;
%%
%mesh2
mat = load("avg2.mat");
mat = struct2array(mat);  % 确保 mat 变成一个数值数组
y = [ 0.3 ,0.4,0.5];
x = [0.9,0.95,0.97,0.99];


[X, Y] = meshgrid(x, y);  % 生成匹配网格
figure;
mesh(X, Y, mat);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('Mesh Plot');
%% Plot 3*3,0,5,10
clc;
close all;
clear;


freq = 100e6;                     
c = physconst('LightSpeed');       
lam = c / freq;                    
K = 2 * pi / lam;   
space = 1 * lam;
alpha = 0;

bestsolution = load("bestsolution_640_32.1.csv");
ang_left = -18;                   
ang_right = 18;                    
L = 10001;  
secondtarget_ang = 10;
test_ang = 5;
w1 = 1;
w2 = 0;
elapsedTime = 0 ;
Stop_num = 0;


actpos = nnz(bestsolution);
[theta, AF_dBbest] = AF_grid(bestsolution, ang_left, ang_right, L, K, 0,space);
psll_0 = PSLL(AF_dBbest,theta);
[t02, a02] = AF_grid(bestsolution, ang_left, ang_right, L, K, secondtarget_ang,space);
psll_S = PSLL(a02,t02);
[t03, a03] = AF_grid(bestsolution, ang_left, ang_right, L, K,test_ang,space);
psll_test = PSLL(a03,t03);


ang_all = -17.5:0.5:17.5;
psll_values = zeros(1, length(ang_all));
for i = 1:length(ang_all)
    ang = ang_all(i);
    [theta, AF_dB21] = AF_grid(bestsolution, ang_left, ang_right, L, K, ang,space);
    psll_values(i) = PSLL(AF_dB21);
end
psll_avg = mean(psll_values);

%save_MOO(w1,psll_0,w2, psll_S, test_ang,psll_test,psll_avg,alpha,actpos,elapsedTime,Stop_num);
%%

T = readtable('WeightMOO.csv'); 

x = 1:1:10;
y1 = table2array(T(:,2));  % 第2列
y2 = table2array(T(:,4));  % 第4列
y3 = table2array(T(:,6));  % 第5列
y4 = table2array(T(:,7));  % 第6列

figure;
plot(x, y1, 'r-', 'LineWidth', 1.5);  % 红色实线
hold on;
plot(x, y2, 'g-', 'LineWidth', 1.5);  % 绿色实线
plot(x, y3, 'b-', 'LineWidth', 1.5);  % 蓝色实线
plot(x, y4, 'k-', 'LineWidth', 1.5);  % 黑色实线
hold off;

% 添加图例、标题和坐标轴标签
xlabel('Set');
ylabel('PSLL');
title('Steering');
legend('psll 0', 'psll S', 'psll test', 'psll avg');

% 打开网格
grid on;
%% plot test on 2d1d comparsion
clc;
clear;
close all;
load('normaltest_bestsolu.mat');
                
lam = 1550e-9;                    
K = 2 * pi / lam;   

bestsolution_1 = load('bestsolution_425_28.9.csv');
ang_left = -18;                   
ang_right = 18;                    
L = 10001;  
space = 1 * lam;

st_ang_all = -17.5:0.1:17.5;
PSLL_all_1 = zeros(1,length(st_ang_all));
for i = 1:length(st_ang_all)
    ang = st_ang_all(i);
    [theta, AF] = AF_grid(bestsolution_1, ang_left, ang_right, L, K, ang,space);
    PSLL_all_1(i) = PSLL(AF);
end

bestsolution_2 = record_list{6}.bestsolution;
st_ang_all = -17.5:0.1:17.5;
PSLL_all_2 = zeros(1,length(st_ang_all));
for i = 1:length(st_ang_all)
    ang = st_ang_all(i);
    [theta, AF] = AF_grid(bestsolution_2, ang_left, ang_right, L, K, ang,space);
    PSLL_all_2(i) = PSLL(AF);
end
space_3 = 1/2 * lam;
bestsolution_3 = record_list{22}.bestsolution;
%bestsolution_3 = struct2array(load("28行测试玩玩.mat"));
%bestsolution_3(1763) = 0;
st_ang_all = -17.5:0.1:17.5;
PSLL_all_3 = zeros(1,length(st_ang_all));
for i = 1:length(st_ang_all)
    ang = st_ang_all(i);
    [theta, AF] = AF_grid(bestsolution_3, ang_left, ang_right, L, K, ang,space_3);
    PSLL_all_3(i) = PSLL(AF);
end
%% 2D1D 和 普通的结果作对比

figure;

% 定义颜色（柔和易区分）
blue = [0 0.4470 0.7410];
red = [0.8500 0.3250 0.0980];
green = [0.4660 0.6740 0.1880];

% 绘制曲线
plot(st_ang_all, PSLL_all_1, '-', 'Color', blue, 'LineWidth', 1.5); 
hold on;
plot(st_ang_all, PSLL_all_2, '--', 'Color', red, 'LineWidth', 1.5);
plot(st_ang_all, PSLL_all_3, '-.', 'Color', green, 'LineWidth', 1.5);

% 坐标轴标签（IEEE格式）
xlabel('Steering Angle', 'FontSize', 10, 'FontName', 'Times New Roman');
ylabel('PSLL (dB)', 'FontSize', 10, 'FontName', 'Times New Roman');

% 标题（可选，IEEE 通常不建议用图标题，可注释掉）
% title('PSLL under Different Steering Angles', 'FontSize', 10, 'FontName', 'Times New Roman');

% 图例（IEEE格式）
legend({
    'Without steering process',
    'With steering (grid = \lambda)',
    'With steering (grid = \lambda/2)'
}, ...
    'FontSize', 9, ...
    'FontName', 'Times New Roman', ...
    'Location', 'best');

% 设置网格和边框
grid on;
box on;

% 设置坐标轴字体
set(gca, 'FontSize', 10, 'FontName', 'Times New Roman', 'LineWidth', 1);

% 设置图形大小：3.5 inch × 2.5 inch，适用于单栏 IEEE 图
set(gcf, 'Units', 'inches', 'Position', [1, 1, 3.5, 2.5]);

% 调整边距以防止标签截断（可选）

hold off;




%% plot gird space reuslts
% 示例数据：每个 alpha 对应三个方法的 PSLL 值
data = [ 32.1, 32.9, 34.7;   % alpha = 0.1
         28.9, 29.4, 29.4;  % alpha = 0.5
         23.3, 24.2, 25.6]; % alpha = 0.9

xLabels = {'\alpha'' = 0', '\alpha'' = 0.015', '\alpha'' = 0.024'};
groupLabels = {'Grid space = 1 \lambda', 'Grid space = 1/2 \lambda', 'Grid space = 1/4 \lambda'};  % 每根柱子代表一个方法

% 创建图形
figure('Color', 'w');
b = bar(data, 'grouped');

% 彩色设置
colors = [0.2 0.6 0.8;   % 蓝
          0.4 0.8 0.4;   % 绿
          0.9 0.6 0.2];  % 橙
for k = 1:length(b)
    b(k).FaceColor = colors(k,:);
end

% 字体与标签（IEEE 风格）
set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
ylabel('PSLL (dB)', 'FontSize', 11, 'FontName', 'Times New Roman');
xlabel('Different Value of \alpha''', 'FontSize', 11, 'FontName', 'Times New Roman');
set(gca, 'XTickLabel', xLabels);

%图例
legend(groupLabels, 'Location', 'northeast', ...
       'FontSize', 9, 'FontName', 'Times New Roman', 'Box', 'off');

% 网格美化
box off;
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.3);

%% 找到并修改violation
v = readmatrix('PSLL=22.4,antenna=155.xlsx');
%v = [1 0 1 0 0 1 0 0 1 1];
idx = find(v(1:end-1) == 1 & v(2:end) == 1)  % 找到相邻1的起始索引
