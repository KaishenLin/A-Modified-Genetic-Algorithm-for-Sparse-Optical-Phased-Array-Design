clc;
clear;
close all;

lam = 1550e-9;                    
K = 2 * pi / lam;   
% load('normaltest_bestsolu.mat');
% bestPos1 = record_list{11}.bestsolution; % 取出字段
% load('28行测试玩玩.mat');
% bestPos1 = bestsolution_test_28;
% bestPos2 = [];
bestPos1 = readmatrix('PSLL=22.8,antenna=147.xlsx');
ang_left = -18;                   
ang_right = 18;                    
L = 10001;                        
st_ang = 0;                       % steering angle
space = 1/2*lam;

%[theta, AF_dB1] = AF_grid(norPos, ang_left, ang_right, L, K, st_ang,space);
[theta, AF_dB21] = AF_grid(bestPos1, ang_left, ang_right, L, K, st_ang,space);

%[theta, AF_dB21] = AF_2D1D_FFT(bestPos1, ang_left, ang_right, L);

% [theta, AF_dB22] = AF_grid(bestPos2, ang_left, ang_right, L, K, st_ang,space);
   activatedPositions = find(bestPos1 == 1);
  
    spacingDiffs = diff(activatedPositions);
    violations = sum(spacingDiffs < 2)


% figure;
% plot(theta, AF_dB1, 'LineWidth', 1.5);
% grid on;
% xlabel('Angle (degrees)');
% ylabel('Array Factor (dB)');
% title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
% xlim([ang_left, ang_right]);
% ylim([-50, 0.5]); 
% psl1 = PSLL(AF_dB1,theta);
% disp(psl1);

figure;
plot(theta, AF_dB21, 'LineWidth', 1.5);
grid on;
xlabel('Angle (degrees)');
ylabel('Normalized intensity(dB)');
title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
xlim([ang_left, ang_right]);
ylim([-50, 0.5]); 
psl21 = PSLL(AF_dB21);
disp(psl21);


%activatedPosition = find(bestPos1 == 1);


%%
    [value, loc] = findpeaks(AF_dB21, 'SortStr', 'descend');
    if length(value) < 2
        Psll = 0; 
    else
        peaksidelobe = max([value(2), AF_dB21(1), AF_dB21(end)]);
        Psll = value(1) - peaksidelobe; 
    end
% AF_max = max(AF_dB21);
% threshold = AF_max - 3;
% 
% 
% 
% left_idx = find(AF_dB21(1:find(AF_dB21 == AF_max)) <= threshold, 1, 'last');
% right_idx = find(AF_dB21(find(AF_dB21 == AF_max):end) <= threshold, 1, 'first') + find(AF_dB21 == AF_max) - 1;




% figure;
% plot(theta, AF_dB22, 'LineWidth', 1.5);
% grid on;
% xlabel('Angle (degrees)');
% ylabel('Array Factor (dB)');
% title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
% xlim([ang_left, ang_right]);
% ylim([-50, 0.5]); 
% psl22 = PSLL(AF_dB22);
% disp(psl22);







