clear; close all; clc;
%PS0e
%Output: Store the two images as ps0-1-a-1.png and ps0-1-a-2.png inside the output folder
%Image color matrix R G B
%1. Input images
A = imread("img1.jpeg");
B = imread("img2.jpg");
A = im2double(A);
B = im2double(B);
swap_A(:,:,1) = A(:,:,3);
swap_A(:,:,2) = A(:,:,2);
swap_A(:,:,3) = A(:,:,1);
swap_A = im2uint8(swap_A);

%2. Color planes
%2.a
figure(1); imagesc(A); title("Original image")
figure(2); imagesc(swap_A); title("Swapped color image");
Image = getframe(gcf);
imwrite(Image.cdata, 'ps0-2-a-1.png');

%2.b
img1_green = A(:,:,2); 
figure(3); imagesc(img1_green); title("Green channel image");
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-2-b-1.png');

%2.c
img1_red = A(:,:,1); 
figure(4); imagesc(img1_red); title("Red channel image");
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-2-c-1.png');
%2.d

%3. Replacement of pixels
figure(5)
g_2 = B(:,:,2);
g_2(135:235,68:168) = img1_green(50:150,50:150);
img2(:,:,1) = B(:,:,1);
img2(:,:,2) = g_2;
img2(:,:,3) = B(:,:,3);
imshow(img2); title("Monochrome image insertion");
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-3-a-1.png');

%4. Arithmetic and Geometri operations
%4.a
img1_green_min = min(min(img1_green)); %0
img1_green_max = max(max(img1_green)); %255
img1_green_mean = mean(mean(img1_green)); %189.1
img1_green_std = std(std(im2double(img1_green))); %0.0862
%The green channel of image 1 essentially is just a two dimentional
%matrix therefore using the matlabt functions min; max; mean and std will
%give me the disired result

%4.b
figure(6)
histogram(img1_green);title('Green channel image histogram');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-4-b-1.png');
%Image green channel histogram is essentially the image intensity
%distribution. In my green channel image i could tell right away from my
%histogram that i have a lot of pixels are of intensity 255

%4.c
figure(7)
img1_green_new = 10 * (img1_green - img1_green_mean)/img1_green_std + img1_green_mean;
imshow(img1_green_new); title('Arithmetic operation: ps0-4-c-1')
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-4-c-1.png')

%4.d
figure(8)
histogram(img1_green_new); title('Green channel image histogram after arithmetic operation');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-4-d-1.png');
%in part b the histogram have more than just two intensity and therefore we
%are able to observe different shades of gray. However, in part d, there
%are only two intensity and of course we are only able to see two shades of
%gray.

%4.e.
figure(9)
shift_img = imtranslate(img1_green,[-2,0]); 
imshow(shift_img);title('Shifted image')
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-4-e-1.png');

%4.f.
figure(10)
subtraction = img1_green - shift_img;
imshow(subtraction); title('Subtracted image');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-4-f-1.png')
%The negative value just means that it has the same intensity as the value
%0 (black)

%5.Noise
%5.a
figure(11)
sigma = 0.05;
noise = randn(size(img1_green)) * sigma;
noisy_img_green = img1_green + noise;
% noisy_img(:,:,1) = A(:,:,1);
% noisy_img(:,:,2) = noisy_img_green;
% noisy_img(:,:,3) = A(:,:,3);
imshow(noisy_img_green); title('Noisy Image green channel with sigma = 0.05');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-a-1.png');
%the sigma value that i used was 0.
%5.b.
figure(12)
histogram(noisy_img_green); title('Histogram of the noisy image green channel');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-b-1.png');
%The intensity of the image is a lot more spread out and there are more
%intenstity in the noisy image comapre to that of the original one; Also i
%see a gaussian curve in the noisy image histogram whereas there isn't one
%in the histrogram of the original image.

%5.c
figure(13)
%subplot(1,2,1);
imshow(A(:,:,3)+noise); title('Noisy blue channel image');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-c-1.png')
%subplot(1,2,2);imshow(A); title('Original image');

%5.d
%i like the noisy green channel a bit better because i could discriminate
%the colors of the images a lot better than the noisy blue channel; also it
%seems the noise look the same.

%5.e
figure(14)
filtered = medfilt2(noisy_img_green);
imshow(filtered);title('Filtered image')
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-e-1.png');
figure(15)
histogram(filtered); title('Filtered image histogram');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-e-2.png');
%The image after being filtered seems to be blurry than the noisy picture
%however i don't see noisy grains in the picture. The intensity of the
%histogram seems to reduce a bit and look a bit more alike to the histogram
%of the origial piciture than that of the noisy one.

%5.f
figure(15)
filtered = imgaussfilt(noisy_img_green);
imshow(filtered);title('Gaussian filtered image')
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-f-1.png');
figure(17)
histogram(filtered); title('Gaussian filtered image histogram');
Image = getframe(gcf);
imwrite(Image.cdata,'ps0-5-f-2.png');
%After gaussian filter the grains (noise) on the image definitely look a
%lot less distinguishable. However the image doesn't seem to be blurry. The
%histogram look relatively similar to the noisy one. I like the gaussian
%filter better because it reduce the grains of the noisy picture but
%doesn't blur out the image as much as the median filter.



