function H = hough_circles_acc(BW, radius)
    % Compute Hough accumulator array for finding circles.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius: Radius of circles to look for, in pixels

    % TODO: Your code here
    [row,col] = size(BW);
    BW = padarray(BW,[radius,radius],0);
    counter = 1;
    for i = 1:row
        for j = 1:col
            if BW(i,j) == 1
                loc(counter,1) = i;
                loc(counter,2) = j;
                counter = counter + 1;
            end
        end
    end
    %HSpace = zeros(max(loc(:,1))+radius,max(loc(:,2))+radius);
    HSpace = zeros(size(BW));
    
    for i = 1:length(loc)
        for theta = linspace(0,2*pi,360)
            roww = ceil(loc(i,1) + sin(theta) * radius);
            coll = ceil(loc(i,2) + cos(theta) * radius);
            HSpace(roww,coll) = HSpace(roww,coll) + 1; 
        end
    end
    H = HSpace(radius:row+radius-1,radius:col+radius-1);
end
