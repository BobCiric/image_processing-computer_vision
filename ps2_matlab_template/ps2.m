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
figure; imshow(abs(D_R_box)); title('ps2-1-a-2');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-1-a-2.png']);
close;

%% 2-a (SSD)
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);
figure; imshow(D_L/100); title('ps2-2-a-1')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-2-a-1.png'])
close

figure; imshow(-D_R/150); title('ps2-2-a-2')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-2-a-2.png'])
close

%% 3-a (SSD + noise)
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
sigma = 0.1;
noise = randn(size(L)) * sigma;
L = L + noise;
R = R + noise;
D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);

figure; imshow(D_L/100); title('ps2-3-a-1')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-3-a-1.png'])
close

figure; imshow(-D_R/100); title('ps2-3-a-2')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-3-a-2.png'])
close

%% 3-b (SSD + contrast)
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
R = 1.1 * R;
D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);

figure; imshow(D_L/150); title('ps2-3-b-1')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-3-b-1.png'])
close

figure; imshow(-1*D_R/150); title('ps2-3-b-2')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-3-b-2.png'])
close

%% 4-a  (NCORR)
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
D_L = disparity_ncorr(L, R);
imshow(D_L/100); title('ps2-4-a-1');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-4-a-1.png'])
close
D_R = disparity_ncorr(R, L);
imshow(-D_R/100); title('ps2-4-a-2');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-4-a-2.png'])
close

%% 4-b (NCORR + noise)
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
sigma = 0.1;
noise = randn(size(L)) * sigma;
L = L + noise;
R = R + noise;
D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);

imshow(D_L/100); title('ps2-4-b-1')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-4-b-1.png'])
close

imshow(-D_R/150); title('ps2-4-b-2')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-4-b-2.png'])
close
%% 4-b (NCORR + contrast)
L = im2double(imread(fullfile('input', 'pair1-L.png')));
R = im2double(imread(fullfile('input', 'pair1-R.png')));
L = rgb2gray(L);
R = rgb2gray(R);
R = 1.1 * R;

D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);

imshow(D_L/100); title('ps2-4-b-3')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-4-b-3.png'])
close

imshow(-D_R/150); title('ps2-4-b-4')
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps2-4-b-4.png'])
close




