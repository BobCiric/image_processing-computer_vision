% Test code:

%% Load images
left = im2double(imread(fullfile('input', 'pair0-L.png')));
right = im2double(imread(fullfile('input', 'pair0-R.png')));
figure, imshow(left);
figure, imshow(right);

%% Convert to grayscale, double, [0, 1] range for easier computation
%left_gray = double(rgb2gray(left)) / 255.0;
%right_gray = double(rgb2gray(right)) / 255.0;
left_gray = left;
right_gray = right;

%% Define image patch location (topleft [row col]) and size
patch_loc = [50 50];
patch_size = [50 50];

%% Extract patch (from left image)
patch_left = left_gray(patch_loc(1):(patch_loc(1) + patch_size(1) - 1), patch_loc(2):(patch_loc(2) + patch_size(2) - 1));
figure, imshow(patch_left);

%% Extract strip (from right image)
strip_right = right_gray(patch_loc(1):(patch_loc(1) + patch_size(1) - 1), :);
figure, imshow(strip_right);

%% Now look for the patch in the strip and report the best position (column index of topleft corner)
best_x = find_best_match(patch_left, strip_right);
disp(best_x);
patch_right = right_gray(patch_loc(1):(patch_loc(1) + patch_size(1) - 1), best_x:(best_x + patch_size(2) - 1));
figure, imshow(patch_right);
