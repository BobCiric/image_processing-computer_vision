function [a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin)
    R = harrisMap(image, gaussianWin);
    newMap = (R>threshold); %Thresholding 
    % non-maximal suppression
    newR = newMap.*R;
    
    for row = 1 : size(newR,1)/suppressionWin
        for col = 1 : size(newR,2)/suppressionWin
                rows = 1+(row-1)*suppressionWin:suppressionWin*row;
                cols = 1+(col-1)*suppressionWin:suppressionWin*col;
                winValue = newR(rows, cols);
                maxValue = max(winValue(:));
                newR(rows, cols) = 0;
                [a,b] = find(winValue == maxValue);
                newR(rows(a),cols(b)) = maxValue;
        end
    end

[a,b] = find((newR > 0) == 1); 
    
end