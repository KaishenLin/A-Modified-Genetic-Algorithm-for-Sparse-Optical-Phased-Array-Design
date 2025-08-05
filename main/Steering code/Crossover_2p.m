
function newpop_c = Crossover_2p(newpop, populationSize, chromosomeSize, p_cross)
    newpop_c = newpop; 
    for i = 1:2:populationSize-1
        if rand < p_cross
            c_p = randperm(chromosomeSize-1, 2);%avoid being into one-point or I should leave it
            c_p = sort(c_p);

            newpop_c(i, c_p(1):c_p(2)) = newpop(i+1, c_p(1):c_p(2));
            newpop_c(i+1, c_p(1):c_p(2)) = newpop(i, c_p(1):c_p(2));
        end
    end
end

