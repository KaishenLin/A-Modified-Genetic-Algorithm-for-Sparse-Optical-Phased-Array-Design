clc;
clear;
close all;

lam = 1550e-9;                    
K = 2 * pi / lam;   
%load("normaltest_bestsolu.mat");
%bestPos1 = record_list{9}.bestsolution;
% norPos = ones(1,1000);
bestPos1 = readmatrix('PSLL=29.5,antenna=423.xlsx');

%bestPos1 = bestsolution;
%bestPos1 = struct2array(load("139-23.3687-bestsolu.mat"));
%bestPos1  = ones(1,20);
% bestPos2 = [];



ang_left = -18;                   
ang_right = 18;                    
L = 10001;                        
st_ang = 0;                       % steering angle
space =1/4*lam;

%[theta1, AF_dB1] = AF_fft(bestPos1, ang_left, ang_right, L, K, st_ang,space);
[theta, AF_dB21] = AF_grid(bestPos1, ang_left, ang_right, L, K, st_ang,space);
% [theta, AF_dB22] = AF_grid(bestPos2, ang_left, ang_right, L, K, st_ang,space);



    % [value, loc] = findpeaks(AF_dB1, 'SortStr', 'descend');
    % if length(value) < 2
    %     Psll = 0; 
    % else
    %     peaksidelobe = max([value(2), AF_dB1(1), AF_dB1(end)]);
    %     Psll = value(1) - peaksidelobe; 
    % end


% figure;
% plot(theta1, AF_dB1, 'LineWidth', 1.5);
% grid on;
% xlabel('Angle (degrees)');
% ylabel('Array Factor (dB)');
% title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
% xlim([ang_left, ang_right]);
% ylim([-50, 0.5]); 
% psl1 = PSLL(AF_dB1,theta1);
% disp(psl1);

figure;
plot(theta, AF_dB21, 'LineWidth', 1.5);
grid on;
xlabel('Angle (degrees)');
ylabel('Normalized intensity (dB)');
title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
xlim([ang_left, ang_right]);
ylim([-50, 0.5]); 
psl21 = PSLL(AF_dB21,theta);
disp(psl21);

    activatedPositions = find(bestPos1 == 1);
    
    spacingDiffs = diff(activatedPositions);
    %violations = sum(spacingDiffs < );

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







