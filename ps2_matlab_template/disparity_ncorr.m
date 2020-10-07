function D = disparity_ncorr(L, R)
    % Compute disparity map D(y, x) such that: L(y, x) = R(y, x + D(y, x))
    %
    % L: Grayscale left image
    % R: Grayscale right image, same size as L
    % D: Output disparity map, same size as L, R

    % TODO: Your code here
    win = 7;
    win_M = floor(win/2);
    dim = size(R);
    msg = 'Creating Disparity map ...';
    ssd(1,1) = Inf;
    D = zeros(dim(1),dim(2));
    wb = waitbar(0, msg);
    for i = 4:1:dim(1)-3
        for j = 4:1:dim(2)-3
            template = L(i-3:i+3,j-3:j+3); % template with a window size of 7
              comp = R(i-3:i+3,1:end);
              c = normxcorr2(template, comp);       
            [ypeak,xpeak] = find(c==max(c(:)));
            D(i,j) = j-xpeak;
        end

     counter = (i/(dim(1)-win_M));
     waitbar(counter,wb)
     
    end
delete(wb)
toc
end
