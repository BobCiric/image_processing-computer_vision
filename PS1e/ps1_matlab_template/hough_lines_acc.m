function [H, theta, rhos] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    %
    % Please see the Matlab documentation for hough():
    % http://www.mathworks.com/help/images/ref/hough.html
    % Your code should imitate the Matlab implementation.
    %
    % Pay close attention to the coordinate system specified in the assignment.
    % Note: Rows of H should correspond to values of rho, columns those of theta.

    %% Parse input arguments
    p = inputParser();
    addParameter(p, 'RhoResolution', 1);
    addParameter(p, 'Theta', linspace(-90, 89, 180));
    parse(p, varargin{:});

    rhoStep = p.Results.RhoResolution;
    theta = p.Results.Theta;

    %% TODO: Your code here
    %Locations of the edge points
    [row,col]=size(BW);
    counter = 1;
    for i = 1:row
        for j = 1:col
            if BW(i,j) == 1
                loc(counter,1) = i;
                loc(counter,2) = j;
                counter = counter +1;
            end
        end
    end
    %rho = x*cos(theta) + y*sin(theta)
    thetaResolution = 1;
    rhoResolution = 1;
    %theta = -90:thetaResolution:89;
    diag = round(sqrt(row^2 + col^2));
    rhos = -diag:rhoStep:diag;
    H = zeros(length(rhos),length(theta),'uint8');
    
    %computing rho
    for i = 1:max(size(loc))
        x = loc(i,2);
        y = loc(i,1);
        
        for j = 1:max(size(theta))
            t = theta(j)*pi/180;
            rho = round(x * cos(t) + y * sin(t))+diag;
            H(rho,j) = H(rho,j) + 1;
            H = double(H);
        end
    end
end
