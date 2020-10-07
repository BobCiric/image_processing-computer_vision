
function D = disparity_ssd(L, R)
tic
    % Compute disparity map D(y, x) such that: L(y, x) = R(y, x + D(y, x))
    %
    % L: Grayscale left image
    % R: Grayscale right image, same size as L
    % D: Output disparity map, same size as L, R
    
    % TODO: Your code here
    win = 3;
    win_M = floor(win/2);
    dim = size(R);
    msg = 'Creating Disparity map ...';
    ssd(1,1) = Inf;
    D = zeros(dim(1),dim(2));
    wb = waitbar(0, msg);
    for i = 2:1:dim(1)-1
        for j = 2:1:dim(2)-1
            template = L(i-1:i+1,j-1:j+1); % template with a window size of 3
            for jj = 2:dim(2)-1 %sliding the template across the strip
              comp = R(i-1:i+1,jj-1:jj+1);
              ssd(jj) = sum((comp - template).^2,'all');
            end
            [val,loc] = min(ssd);
            D(i,j) = j-loc;
        end

     counter = (i/(dim(1)-win_M));
     waitbar(counter,wb)
     
    end
delete(wb)
toc
    end
    
    