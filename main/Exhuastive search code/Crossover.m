function newpop_c = Crossover(newpop,populationSize, chromosomeSize, p_cross)
for i = 1:2:populationSize-1
    if rand < p_cross
        c_p = randi([1, chromosomeSize-1]);  
        newpop_c(i,:) = [newpop(i,1:c_p),newpop(i+1,c_p+1:end)];
        newpop_c(i+1,:) = [newpop(i+1,1:c_p),newpop(i,c_p+1:end)];
    else
        newpop_c(i,:) = newpop(i,:);
        newpop_c(i+1,:) = newpop(i+1,:);
    end

end

end
    
