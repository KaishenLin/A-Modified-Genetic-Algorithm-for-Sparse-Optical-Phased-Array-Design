function save_1D2D_solution(psll, bestsolution)


    filename = '1D2D_bestsolu.csv';  % 目标文件名

    % 以追加方式打开文件
    fid = fopen(filename, 'a');


    % 写入：psll保留4位小数，bestsolution转换为字符串
    fprintf(fid, '%.4f\t%s\n', psll, num2str(bestsolution, '%d'));

    fclose(fid);
end