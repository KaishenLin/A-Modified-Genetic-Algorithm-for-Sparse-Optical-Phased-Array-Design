function [theta, AF_dB] = AF_2D1D_FFT(position, ang_left, ang_right, L)
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
    Omega_theta = deg2rad(theta);  

    target_freq = -Omega_theta;
    wrapped_freq = mod(target_freq + pi, 2*pi) - pi;
    AF_value = interp1(omega_axis, W_fft, wrapped_freq, 'pchip', 0);% Interpolate FFT values at target frequencies using piecewise cubic interpolation
    AF_dB = 20 * log10(abs(AF_value) ./ num);
end