function [centers, radii] = find_circles(BW, radius_range)
    % Find circles in given radius range using Hough transform.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius_range: Range of circle radii [min max] to look for, in pixels

    % TODO: Your code here
    counter = 1;
    H = {};
    centers = {};
    for radius = radius_range(1):1:radius_range(2)
        H{counter} = hough_circles_acc(BW, radius);
        c = hough_peaks(H{counter}, 'Threshold', round(max(max(cell2mat(H)))*0.73),'numpeaks',10, 'NHoodSize',[30,30]);
        if isempty(c) == 0
        radii(counter,1) = radius;
        centers{counter,1} = c;
        end
         counter = counter + 1;
    end
    
end
