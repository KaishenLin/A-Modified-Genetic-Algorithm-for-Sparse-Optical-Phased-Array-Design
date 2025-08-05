function [theta, AF_dB] = AF_fft(position, ang_left, ang_right, L, K, st_ang, space)
    w = position;
    N = length(position);
    num = nnz(position);
    theta = linspace(ang_left, ang_right, L);  
    theta = theta(:);  
    % Zero-padding: pad FFT to improve interpolation accuracy
    M = 2^nextpow2(10 * N);  % 10 times zero padding
    W_fft = fft(w, M);       
    W_fft = fftshift(W_fft); % Shift zero frequency to center
    omega_axis = (-M/2:M/2-1) * (2*pi/M); % Create normalized frequency axis
    Omega_theta = K * space * (sind(theta) - sind(st_ang));  

% 1. 计算目标频率
target_freq = -Omega_theta;

% 2. 将超出范围的频率“折叠”回 [-pi, pi) 的区间内
wrapped_freq = mod(target_freq + pi, 2*pi) - pi;

% 3. 使用折叠后的频率进行插值
AF_value = interp1(omega_axis, W_fft, wrapped_freq, 'pchip', 0);

    %AF_value = interp1(omega_axis, W_fft, -Omega_theta, 'pchip', 0); % Interpolate FFT values at target frequencies using piecewise cubic interpolation
    AF_dB = 20 * log10(abs(AF_value) ./ num);

end





