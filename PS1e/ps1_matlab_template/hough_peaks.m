function peaks = hough_peaks(H, varargin)
    % Find peaks in a Hough accumulator array.
    %
    % Threshold (optional): Threshold at which values of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Please see the Matlab documentation for houghpeaks():
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    % Your code should imitate the matlab implementation.

    %% Parse input arguments
    p = inputParser;
    addOptional(p, 'numpeaks', 1, @isnumeric);
    addParameter(p, 'Threshold', 0.5 * max(H(:)));
    addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 2 + 1);  % odd values >= size(H)/50
    parse(p, varargin{:});

    numpeaks = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;
    a = nHoodSize(1);
    b = nHoodSize(2);

    % TODO: Your code here
    [row,col] = size(H);
    peak_list = sort(unique(reshape(H,[row*col,1])),'descend');
    counter = 1;
    num = length(find(peak_list<=max(max(H)) & peak_list>threshold));
    peaks = zeros(numpeaks,2);
    
    for k = 1:num
        peak = peak_list(k);
    for i =1:row
        for j = 1:col
            if H(i,j) == peak
                peaks(counter,1) = i;
                peaks(counter,2) = j;
                counter = counter + 1;
                x_low_bound = i - round(a/2); 
                x_up_bound = i + round(a/2);
                y_low_bound = j - round(b/2);
                y_up_bound = j + round(b/2);
                if x_low_bound < 1
                    x_low_bound = 1;
                end
                if x_up_bound > row
                    x_up_bound = row;
                end
                if y_low_bound < 1
                    y_low_bound = 1;
                end
                if y_up_bound > col
                    y_up_bound = col;
                end
                H(x_low_bound:x_up_bound,y_low_bound:y_up_bound) = 0; %suppression
                if counter > numpeaks
                    break
                end
            end
        end
    end
    end
    
    peaks = peaks(1:numpeaks,:);
    peaks( ~any(peaks,2), : ) = [];
    
%     [x,y] = find(H <= peak & H > threshold);
%     fprintf('Peaks before suppression: \n')
%     peaks = [x,y];
%     
%     fprintf('Suppressing neighborhood....\n')
%     for i = 1:length(peaks)
%         H(peaks(i,1)+1:peaks(i,1)+nHoodSize(1),peaks(i,2)+1:peaks(i,2)+nHoodSize(2)) = 0;
%     end
%     fprintf('Peaks after suppression: \n')
%     [x,y] = find(H <= peak & H > threshold);
%     peaks = [x,y]; % peaks after suppression 
%     
%     for i = 1:length(peaks)
%     intensity(i,1) = H(peaks(i,1),peaks(i,2));
%     end
%     fprintf('Peaks after sorting....\n')
%     sorted_peaks = sortrows([x,y,intensity],3,'descend');
%     if i <= numpeaks
%         peaks = sorted_peaks(1:i,1:2);
%     else
%     peaks = sorted_peaks(1:numpeaks,1:2);
%     end

end
