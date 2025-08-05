function save_1D2D(populationSize, chromosomeSize, maxiter, minDist, alpha, pslbest, actpos, sparsityLevel, illegalnum, elapsedTime,Stop_num,bestsolution);

    csv_filename = '1D2D_results.csv';

    data = [populationSize, chromosomeSize, maxiter,  ...
            minDist,  alpha, ...
            pslbest, actpos, sparsityLevel, illegalnum,elapsedTime,Stop_num];


    headers = {'populationSize', 'chromosomeSize', 'maxiter',  ...
               'minDist',  'alpha_sparsity', ...
               'PSLL', 'Activate_number', 'SparsityLevel', 'Illegal_positions','Time','Stop_at'};

    % 检查 CSV 文件是否存在
    if exist(csv_filename, 'file') == 0
        % 创建 CSV 并写入表头
        fid = fopen(csv_filename, 'w');
        fprintf(fid, '%s,', headers{1:end-1});
        fprintf(fid, '%s\n', headers{end});
        fclose(fid);
    end

     % 追加数据行
    fid = fopen(csv_filename, 'a');
    fprintf(fid, '%d,%d,%d,%d,%d,%.4f,%d,%.4f,%d,%.4f,%d\n', data);
    fclose(fid);


    % ----------- 控制台输出 ------------
    disp(['PSLL: ', num2str(pslbest)]);
    disp(['Activate number: ', num2str(actpos)]);
    disp(['Sparsity Level: ', num2str(sparsityLevel)]);
    disp(['Illegal positions: ', num2str(illegalnum)]);
    disp(['运行时间: ', num2str(elapsedTime)]);
    disp(['停止进化在：', num2str(Stop_num), '次']);
end
