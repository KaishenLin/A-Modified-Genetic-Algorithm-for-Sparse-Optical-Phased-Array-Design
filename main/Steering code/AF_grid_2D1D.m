% position = bestsolution;
% [theta, AF_dB] = AF_grid_ZZ(position, ang_left, ang_right, L);
% Psll00 = PSLL(AF_dB, theta);
% Psll00
function [theta, AF_dB] = AF_grid_2D1D(position, ang_left, ang_right, L)
    w = position;
    N = length(position);
    num = nnz(position);
    theta = linspace(ang_left, ang_right, L);
    AF_value = zeros(1, L);
    z = deg2rad(theta(:));
    m = 0:N-1;
    phase_matrix =  z * m;
    AF_value = exp(1j * phase_matrix) * w(:);
    AF_dB = 20 * log10(abs(AF_value)./num);
end


