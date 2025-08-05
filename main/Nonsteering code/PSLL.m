
% PSLL = 20*log10(R_main/R_peaksidelobe) = 10*log10(I_main/I_peaksidelobe)

% function Psll = PSLL(AF_dB,theta)
%     [value, loc] = findpeaks(AF_dB,'SortStr','descend');
%     Psll = value(1) - value(2);
% end

function Psll = PSLL(AF_dB, theta)
    [value, loc] = findpeaks(AF_dB, 'SortStr', 'descend');
    if length(value) < 2
        Psll = 0; 
    else
        peaksidelobe = max([value(2), AF_dB(1), AF_dB(end)]);
        Psll = value(1) - peaksidelobe; 
    end
end

% 
% function Psll = PSLL(AF_dB, theta, st_ang)
%     % 找到离st_ang最近的角度索引
%     [~, main_idx] = min(abs(theta - st_ang));
% 
%     % 主瓣最大值
%     mainlobe_val = AF_dB(main_idx);
% 
%     % 构建屏蔽掩码：排除主瓣±0.1°的区域
%     mask = abs(theta - theta(main_idx)) > 0.09;
% 
%     % 应用掩码
%     AF_masked = AF_dB(mask);
% 
%     % 寻找掩码区域内的局部最大值（旁瓣候选）
%     sidelobes = findpeaks(AF_masked);
% 
%     % 找到最大旁瓣
%     if isempty(sidelobes)
%         max_sidelobe = max([AF_dB(1), AF_dB(end)]);  % 边界点也作为候选
%     else
%         max_sidelobe = max([sidelobes(:)', AF_dB(1), AF_dB(end)]);
%     end
% 
%     % PSLL = 主瓣 - 最大旁瓣
%     Psll = mainlobe_val - max_sidelobe;
% end




