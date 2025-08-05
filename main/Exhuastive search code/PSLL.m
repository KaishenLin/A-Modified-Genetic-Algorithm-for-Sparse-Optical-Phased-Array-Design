
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





