% ps1
close all; clear; clc
%% 1-a
img = imread(fullfile('input', 'ps1-input0.png'));  % already grayscale
img_edges = edge(img,'Sobel');
imshow(img_edges)
% Image = getframe(gcf);
% imwrite(Image.cdata,'output/ps1-1-a-1.png');
%% TODO: Compute edge image img_edges
imwrite(img_edges, fullfile('output', 'ps1-1-a-1.png'));  % save as output/ps1-1-a-1.png

%% 2-a
[H,theta,rho] = hough(img_edges);
[H, theta, rho] = hough_lines_acc(img_edges);  % defined in hough_lines_acc.m
%% TODO: Plot/show accumulator array H, save as output/ps1-2-a-1.png
imagesc(H);title('ps1-2-a-1. Accumulator array H')
imwrite(H,fullfile('output','ps1-2-a-1.png'));
close
%% 2-b
peaks = hough_peaks(H, 10);  % defined in hough_peaks.m
%% TODO: Highlight peak locations on accumulator array, save as output/ps1-2-b-1.png
figure; imagesc(H);
hold on
plot(peaks(:,2),peaks(:,1),'r*','MarkerSize',10); title('ps1-2-b-1. Hough Space with peaks identified.')
hold off
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-2-b-1.png']);
close
%% TODO: Rest of your code here
%2-c
hough_lines_draw(img, 'ps1-2-c-1.png', peaks, rho, theta)
close
%2-d
%bin size for the accumulator is 725X180 row bei    ng the size of the rho
%ranging from negative diagnal of the canvas to the diagnal of the canvas
%Column size being 180 because of the angle ranges from -90 to 89; the
%threshold to detect the peaks from the hough space is half max because
%there are only 6 lines in the accumulator; neighborhood size is 1 pixel
%because the accumulator is not too big

%% 3-a
img_noise = imread(fullfile('input', 'ps1-input0-noise.png'));
imshow(img_noise);title('Noise Image');
img_noise_smooth = imgaussfilt(img_noise,4);
imshow(img_noise_smooth); title('ps1-3-a-1. Smoothed Image')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-3-a-1.png'])
close

%% 3-b
noise_edge = edge(img_noise,'Sobel');
imshow(noise_edge); title('ps1-3-b-1. Noisy Image Edge');
Image = getframe(gcf); imwrite(Image.cdata,['output',filesep,'ps1-3-b-1.png'])
close
smooth_edge = edge(img_noise_smooth,'Canny');
imshow(smooth_edge); title('ps1-3-b-2. Smoothed Image Edge');
Image = getframe(gcf); imwrite(Image.cdata,['output',filesep,'ps1-3-b-2.png'])
close

%% 3-c
[H_smoothed, theta_smoothed, rho_smoothed] = hough_lines_acc(smooth_edge);  % defined in hough_lines_acc.m
peaks = hough_peaks(H_smoothed, 'Threshold', max(H_smoothed(:))*0.44,'numpeaks',10, 'NHoodSize',[15,3]);  % defined in hough_peaks.m

figure; imagesc(H_smoothed);
hold on
plot(peaks(:,2),peaks(:,1),'r*','MarkerSize',10);title('ps1-3-c-1. Smoothed noisy edge image Hough space with identified peaks')
hold off
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-3-c-1.png'])
close

outfile = 'ps1-3-c-2.png';
hough_lines_draw(img_noise, outfile, peaks, rho, theta)
close
% to get the best result I was trying different edge operators and canny
% operator with low threshold turned out to be the best. Additionaly, I had to change the smoothing
% sigma to get the best outcome.

%% 4-a
img = imread(['input',filesep,'ps1-input1.png']);
monochrome = img(:,:,3);
monoSmooth = imgaussfilt(monochrome,5);
imshow(monoSmooth)
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-4-a-1.png']);
close

%% 4-b 
monoSmoothEdge = edge(monoSmooth,'Sobel');
imshow(monoSmoothEdge)
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-b-1.png']);

%% 4-c 
[myH, mytheta, myrho] = hough_lines_acc(monoSmoothEdge);
[H, theta, rho] = hough(monoSmoothEdge);
peaks = houghpeaks(H,10);
mypeaks = hough_peaks(H, 10);  % defined in hough_peaks.m
figure; imagesc(H);
hold on
plot(peaks(:,2),peaks(:,1),'r*','MarkerSize',10); title('ps1-4-c-1. Hough Space with peaks identified.')
hold off
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-4-c-1.png']);
close

hough_lines_draw(monochrome, 'ps1-4-c-2.png', peaks, rho, theta)
close

%% 5-a
img = imread(['input',filesep,'ps1-input1.png']);
monochrome = img(:,:,3);
monoSmooth = imgaussfilt(monochrome,1.3);
imshow(monoSmooth)
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-5-a-1.png']);
close

edgeImage = edge(monoSmooth,'sobel');
imshow(edgeImage); title('Edge Image: ps1-5-a-2');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-5-a-2.png']);
close 

radius = 20; 
%hough accumulator with circles
H = hough_circles_acc(edgeImage, radius);

centers = hough_peaks(H, 'Threshold', max(H(:))*0.2,'numpeaks',6, 'NHoodSize',[20,20]);
figure; imagesc(H);
hold on
plot(centers(:,2),centers(:,1),'r*','MarkerSize',10);
hold off
close

imshow(monochrome)
hold on
for i = 1:length(centers)
    row = centers(i,1);
    col = centers(i,2);
   viscircles([col,row],radius); echo off
   title('ps1-5-a-3')
end
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps1-5-a-3.png']);

%% 5-b
monochrome = img(:,:,3); %the monochrome image
monoSmooth = imgaussfilt(monochrome,3); %smoothed image with guassian kernel
edgeImage = edge(monoSmooth,'canny'); %edge image with smoothed image
imshow(edgeImage)

radius_range =[20,50]; %radius range for the circle detection below
[centers, radii] = find_circles(edgeImage, radius_range); % the function spits out the approximated centers and the radius of the detected circle

imshow(monochrome)
hold on
for i = 1:length(radii) %plotting the obtained circle information (approximated)
    row = centers{i}(:,1); %circle center y location
    col = centers{i}(:,2); %circle center x location
   viscircles([col,row],repmat(radii(i),[size(col)])); echo off %plotting the circle
   title('ps1-5-b-1')
end
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'pas-5-b-1.png'])

%To find the circles with different radii, i first get the edge images from
%the smoothed images. Then i applied the hough transform that was
%implemented above to find the locations of the circles with different
%radii. To get the best result, i had to tweak the smoothing sigma, edge
%operators and threshold and suppression parameters in the hough transform.

%% 6-a
img = imread(['input',filesep,'ps1-input2.png']);
img = img(:,:,3);
img_smooth = imgaussfilt(img,6);
edgeImage = edge(img_smooth,'canny'); %edge image with smoothed image
[H, theta, rho] = hough_lines_acc(edgeImage);
peaks = hough_peaks(H, 10);  % defined in hough_peaks.m
hough_lines_draw(img, 'ps1-6-a-1.png', peaks, rho, theta)

%% 6-b
%We found more lines than the pen boundaries because the other edges have
%significant gradient change as well and therefore it is being recognized
%by the MATLAB edge detection operator. And hough transform method
%identified the intersection and slope of the line

%% 6-c 
[H, theta, rho] = hough_lines_acc(edgeImage);
peaks = hough_peaks(H, 'Threshold', max(H(:))*0.5,'numpeaks',1, 'NHoodSize',[10,20]);

hough_lines_draw(img, 'ps1-6-a-1.png', peaks, rho, theta)




