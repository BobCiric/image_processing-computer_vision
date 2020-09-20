function hough_lines_draw(img, outfile, peaks, rho, theta)
    % Draw lines found in an image using Hough transform.
    %
    % img: Image on top of which to draw lines
    % outfile: Output image filename to save plot as
    % peaks: Qx2 matrix containing row, column indices of the Q peaks found in accumulator
    % rho: Vector of rho values, in pixels
    % theta: Vector of theta values, in degrees

    % TODO: Your code here
    %get the edges
     [row,col] = size(img);
     imshow(img); title('Line Segmentation')
     hold on
     t = pi*(theta(peaks(:,2)))/180;
     r = abs(rho(peaks(:,1)));
     col = linspace(1,col,col);
     for i = 1:length(peaks(:,2))
        angle = round(t(i),3);
        distance = r(i);
        if angle == 0 % vertical lines
        xline(r(i),'LineWidth',2,'Color','g'); echo off
        end
        y = -cos(angle)/sin(angle) * x + distance/sin(angle);
        if angle == -1.571
            y = ones(size(x)) * distance;
        end
        line(x,y,'Color','g', 'LineWidth',2); 
     end

%% Saving image
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,outfile]);  % save as output/ps1-1-a-1.png


end
