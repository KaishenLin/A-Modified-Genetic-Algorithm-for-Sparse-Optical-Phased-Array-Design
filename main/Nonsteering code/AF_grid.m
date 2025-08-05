function [theta, AF_dB] = AF_grid(position, ang_left, ang_right, L,  K, st_ang,space)
    w = position;
    N = length(position);
    num = nnz(position);
    theta = linspace(ang_left, ang_right, L);
    AF_value = zeros(1, L); % Ensure theta is a column vector
    theta = theta(:);
    delta_sin = sind(theta) - sind(st_ang);
    m = (0:N-1) * space;
    phase_matrix = K * (delta_sin * m);
    AF_value = exp(1j * phase_matrix) * w(:);
% delta_sin = sind(theta) - sind(st_ang);      % L x 1 向量
% m = (0:N-1) * space;                         % 1 x N 向量
% phase_matrix = K * (delta_sin * m);          % L x N 矩阵
% AF_value = exp(1j * phase_matrix) * w(:);    % L x N 与 N x 1 相乘，得到 L x 1
% 
    % for n = 1:L
    %      AF_value(n) = sum(w .* exp(1j * K * (0:N-1)* space * (sind(theta(n)) - sind(st_ang))));
    % end
    AF_dB = 20 * log10(abs(AF_value)./num);
end
