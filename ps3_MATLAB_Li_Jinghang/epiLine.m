function lines = epiLine(reducedfM, pts)
    for i = 1:length(pts)
        lines(i,:) = reducedfM * pts(:,i);
    end
end