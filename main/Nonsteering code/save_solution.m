function save_solution(alpha, psll, bestsolution)
    filename = 'normaltest_bestsolu.mat';

    % 如果已有文件就加载旧数据
    if isfile(filename)
        data = load(filename);
        record_list = data.record_list;
    else
        record_list = {};
    end

    % 新记录添加到 cell 数组
    new_record = struct('alpha', alpha, 'psll', psll, 'bestsolution', bestsolution);
    record_list{end+1} = new_record;

    % 保存整个 cell 数组
    save(filename, 'record_list');
end

