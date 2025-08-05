clc;
close;
clear;


     
lam = 1550e-9;                    
K = 2 * pi / lam;   
%norPos = ones(1,1000);

% bestPos1 = [1	0	0	0	0	1	0	0	0	1	0	0	0	0	1	0	0	0	0	1	0	0	0	0	1	0	0	0	0	1];
% bestPos2 = bestPos1(end:-1:1);

ang_left = -90;                   
ang_right = 90;                    
L = 10001;                        
st_ang = 0;                       % steering angle
space = 0.4*lam;

%[theta1, AF_dB1] = AF_grid(norPos, ang_left, ang_right, L, K, st_ang,space);
[theta21, AF_dB21] = AF_grid(bestPos1, ang_left, ang_right, L, K, st_ang,space);
[theta22, AF_dB22] = AF_grid(bestPos2, ang_left, ang_right, L, K, st_ang,space);



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
plot(theta21, AF_dB21, 'LineWidth', 1.5);
grid on;
xlabel('Angle (degrees)');
ylabel('Array Factor (dB)');
title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
xlim([ang_left, ang_right]);
ylim([-50, 0.5]); 
psl21 = PSLL(AF_dB21);
disp(psl21);


figure;
plot(theta22, AF_dB22, 'LineWidth', 1.5);
grid on;
xlabel('Angle (degrees)');
ylabel('Array Factor (dB)');
title(['Array Pattern (Steering Angle = ', num2str(st_ang), '°)']);
xlim([ang_left, ang_right]);
ylim([-50, 0.5]); 
psl22 = PSLL(AF_dB22);
disp(psl22);







