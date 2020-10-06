% ps2
clear
clc
%% 1-a
% Read images
L = im2double(imread(fullfile('input', 'pair0-L.png')));
R = im2double(imread(fullfile('input', 'pair0-R.png')));
% Compute disparity
D_L_box = disparity_ssd(L, R);
D_R_box = disparity_ssd(R, L);

% TODO: Save output images (D_L as output/ps2-1-a-1.png and D_R as output/ps2-1-a-2.png)
% Note: They may need to be scaled/shifted before saving to show results properly
% TODO: Rest of your code here
figure; imshow(D_L_box); title('ps2-1-a-1');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-1-a-1.png']);
close;
figure; imshow(D_R_box); title('ps2-1-a-2');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-1-a-2.png']);
close;

%% 2-a
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);
newDL = D_L/max(max(D_R));
figure; imshow(abs(newDL))
figure; imshow(abs(D_R/max(max(D_R))))
