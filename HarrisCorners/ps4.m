%% ECE 1390 Computer Vision HW4 
% Jinghang Li
% Pitt ID: 4126435

clear; clc; close all;
%% 1.a
simA = im2double(imread(fullfile('input', 'simA.jpg')));
simB = im2double(imread(fullfile('input', 'simB.jpg')));
transA = im2double(imread(fullfile('input', 'transA.jpg')));
transB = im2double(imread(fullfile('input', 'transB.jpg')));

simABlur = imgaussfilt(simA,1);
transABlur = imgaussfilt(transA,1);
simBBlur = imgaussfilt(simB,1);
transBBlur = imgaussfilt(transB,1);

[XY, Ix, Iy] = gradientPlot(simABlur);
imshow(50*XY./max(XY(:)))
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,'ps4-1-a-1.png']);
close()

[XY, Ix, Iy] = gradientPlot(transABlur);
imshow(50*XY./max(XY(:)))
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,'ps4-1-a-2.png']);
close()

%% chessboard
% board = im2double(imread(fullfile('input','check.bmp')));
% [XY, Ix, Iy] = gradientPlot(board);
%% 2.a.
win = 10; % gaussian kernal size

R = harrisMap(transABlur, win);
imshow(R); title('transA Blur Image. PS4-1-B-1', 'fontsize', 20)
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,'ps4-1-b-1.png'])
close()

R = harrisMap(transBBlur, win);
imshow(R); title('transB Blur Image. PS4-1-B-2', 'fontsize', 20)
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,'ps4-1-b-2.png'])
close()

R = harrisMap(simABlur, win);
imshow(R); title('SimA Blur Image. PS4-1-B-3', 'fontsize', 20)
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,'ps4-1-b-3.png'])
close()

R = harrisMap(transBBlur, win);
imshow(R); title('SimA Blur Image. PS4-1-B-4', 'fontsize', 20)
Image = getframe(gcf);
imwrite(Image.cdata, ['output',filesep,'ps4-1-b-4.png'])
close()

%% 1.c.
threshold = 5;
suppressionWin = 10;
gaussianWin = 10;

image = transABlur;
[a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin);
figure; imshow(image); title('TransA Harris Corner; ps4-1-c-1','fontsize',15)
hold on
for i = 1:length(a)
    plot(b(i),a(i), 'r+')
end
hold off
Image = getframe(gcf);
imwrite(Image.cdata, ['output', filesep, 'ps4-1-c-1.png'])
close()

image = transBBlur;
[a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin);
figure; imshow(image); title('TransB Harris Corner; ps4-1-c-2','fontsize',15)
hold on
for i = 1:length(a)
    plot(b(i),a(i), 'r+')
end
hold off
Image = getframe(gcf);
imwrite(Image.cdata, ['output', filesep, 'ps4-1-c-2.png'])
close()

image = simABlur;
[a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin);
figure; imshow(image); title('simA Harris Corner; ps4-1-c-3','fontsize',15)
hold on
for i = 1:length(a)
    plot(b(i),a(i), 'r+')
end
hold off
Image = getframe(gcf);
imwrite(Image.cdata, ['output', filesep, 'ps4-1-c-3.png'])
close()

image = simBBlur;
[a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin);
figure; imshow(image); title('simB Harris Corner; ps4-1-c-4','fontsize',15)
hold on
for i = 1:length(a)
    plot(b(i),a(i), 'r+')
end
hold off
Image = getframe(gcf);
imwrite(Image.cdata, ['output', filesep, 'ps4-1-c-4.png'])
close()

%text response: it seems i could find more points with a rotated angle than
%straight angel. I seems to find more points close up than far away; (not
%really a surprise) 

%% 2.a.
scale = 7;
image = [transABlur, transBBlur];
imshow(image)
[a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin);
plotDegree(image,a,b,scale,200); title('TransA&B point pairs; ps4-2-a-1','fontsize',15)
Image = getframe(gcf);
imwrite(Image.cdata, ['output', filesep, 'ps4-2-a-1.png'])
close()


image = [simABlur, simBBlur];
imshow(image)
[a,b] = harrisCorners(image,suppressionWin,threshold,gaussianWin);
plotDegree(image,a,b,scale,200); title('simA&B point pairs; ps4-2-a-2','fontsize',15)
Image = getframe(gcf);
imwrite(Image.cdata, ['output', filesep, 'ps4-2-a-2.png'])
close()

%% 2.b.
%transA - transB pair
scale = 1;
image1 = transABlur;
image1 = single(image1);
image2 = transBBlur;
image2 = single(image2);
[a,b] = harrisCorners(image1,suppressionWin,threshold,gaussianWin);
pts1 = findPoints(image1, a, b, scale);
[F_out1, D_out1] = vl_sift(image1, 'frames', pts1);

[a,b] = harrisCorners(image2,suppressionWin,threshold,gaussianWin);
pts2 = findPoints(image2, a, b, scale);
[F_out2, D_out2] = vl_sift(image2, 'frames', pts2);

M = vl_ubcmatch(D_out1, D_out2);

for i = 1:length(M)
    ka1(i,:) = F_out1(:,M(1,i))';
    kb1(i,:) = F_out2(:,M(2,i))';
end

image = [image1,image2];
imshow(image)
hold on
for i =1:length(ka1)
    plot(ka1(i,1),ka1(i,2),'r*', 'markerSize',5)
    plot(kb1(i,1)+size(image1,2), kb1(i,2),'g+','markerSize',5)
    x = [ka1(i,1), kb1(i,1)+size(image1,2)];
    y = [ka1(i,2), kb1(i,2)];
    u(i,1) = x(2) - x(1);
    v(i,1) = y(2) - y(1);
    line(x,y,'lineWidth',2)
end
hold off
title('(transA - transB putative-pair image;; ps4-2-b-1)','fontsize',15)
Image = getframe(gcf);
imwrite(Image.cdata,['output', filesep, 'ps4-2-b-1.png'])
close()

%hist(dist1) threshold should be 0.1 

%simA - simB pair
image1 = simABlur;
image1 = single(image1);
image2 = simBBlur;
image2 = single(image2);
[a,b] = harrisCorners(image1,suppressionWin,threshold,gaussianWin);
pts1 = findPoints(image1, a, b, scale);
[F_out1, D_out1] = vl_sift(image1, 'frames', pts1);

[a,b] = harrisCorners(image2,suppressionWin,threshold,gaussianWin);
pts2 = findPoints(image2, a, b, scale);
[F_out2, D_out2] = vl_sift(image2, 'frames', pts2);

M = vl_ubcmatch(D_out1, D_out2);

for i = 1:length(M)
    ka11(i,:) = F_out1(:,M(1,i))';
    kb11(i,:) = F_out2(:,M(2,i))';
end

image = [image1,image2];
imshow(image)
hold on
for i =1:length(ka11)
    plot(ka11(i,1),ka11(i,2),'r*', 'markerSize',5)
    plot(kb11(i,1)+size(image1,2), kb11(i,2),'g+','markerSize',5)
    x = [ka11(i,1), kb11(i,1)+size(image1,2)];
    y = [ka11(i,2), kb11(i,2)];
    line(x,y,'lineWidth',2)
   
end
hold off
title('(simA - simB putative-pair image;; ps4-2-b-2)','fontsize',15)
Image = getframe(gcf);
imwrite(Image.cdata,['output', filesep, 'ps4-2-b-2.png'])
close()

%% 3.a.
translationMatrix = [u,v]; translationMatrix(:,3) = 0;
tol = 15;
counter = 1;
for i = 1:length(translationMatrix)
    for j = 1:length(translationMatrix)
        if u(j) < u(i) + tol && u(j) > u(i) - tol && v(j) < v(i) + tol && v(j) > v(i) - tol
            translationMatrix(i,3) = translationMatrix(i,3) + 1;
            store(i,counter) = j;
            counter = counter + 1;
        end
    end
end
%max(translationMatrix(:,3))
anchor = find(translationMatrix(:,3) == max(translationMatrix(:,3)));

val = (store(anchor,:)~=0)';
ind = store(anchor,:)' .* val;
index = ind(ind~=0);

pta = ka1(index,:);
ptb = kb1(index,:);
xa = pta(:,1); ya = pta(:,2);
xb = ptb(:,1); yb = ptb(:,2);


image1 = transABlur;
image1 = single(image1);
image2 = transBBlur;
image2 = single(image2);
image = [image1,image2];
imshow(image)
hold on
for i =1:length(xa)
    plot(xa, ya,'r*', 'markerSize',5)
    plot(xb+size(image1,2), yb,'g+','markerSize',5)
    x = [xa(i), xb(i)+size(image1,2)];
    y = [ya(i), yb(i)];
    line(x,y)
end
hold off
title('(transA - transB putative-pair image; ps4-3-a-1)','fontsize',15)
Image = getframe(gcf);
imwrite(Image.cdata,['output', filesep, 'ps4-3-a-1.png'])
close()

%tranlation vector is [510   -88]
tranVector = translationMatrix(anchor,1:2);
%percentage is below about 30%
percentMatch = size(pta,1)/size(translationMatrix,1) * 100;

%% 3.b.
%ptL = [ka11(:,1:2)';ones(size(ka11,1),1)'];
%simA - simB pair
image1 = simABlur;
image1 = single(image1);
image2 = simBBlur;
image2 = single(image2);
image = [image1,image2];
ptL = ka11(:,1:2)';
ptR = kb11(:,1:2)';
Tmatrix = {};
for i = 1:length(ptL)
    try
tform = estimateGeometricTransform(ptL(:,i:i+1)',ptR(:,i:i+1)','similarity');
Tmatrix{i,1} = tform.T; 
    catch
        Tmatrix{i,1} = NaN * ones(3,3);
    end
end


for i = 1:length(Tmatrix)
    for j = 1:length(Tmatrix)
   ssd(i,j) = sum(sum(sqrt((Tmatrix{i}-Tmatrix{j}).^2)));
    end
end

tol = 800;
wantedIndex = {};
for col = 1:size(ssd,1)
    screening(col,1) = sum(ssd(:,col) < tol);
    wantedIndex{col} = find((ssd(:,col) < tol) == 1);
end

[I,V] = find(screening == max(screening));
T = Tmatrix{I};
wantedIndex = wantedIndex{I};
leftPair = ptL(:,wantedIndex)';
rightPair = ptR(:,wantedIndex)';
leftCord = leftPair;
rightCord = [rightPair(:,1) + (size(image1,2)),rightPair(:,2)];

imshow(image); hold on
for i =1:length(rightCord)
    plot(leftCord(i,1),leftCord(i,2),'r+','markerSize',5)
    plot(rightCord(i,1),rightCord(i,2),'g+', 'markerSize',5)
    x = [leftCord(i), rightCord(i)];
    y = [leftCord(i,2), rightCord(i,2)];
    line(x,y,'lineWidth',2)
end
title('(simA - simB putative-pair image; ps4-3-b-1)','fontsize',15)
Image = getframe(gcf);
imwrite(Image.cdata,['output', filesep, 'ps4-3-b-1.png'])
close()
%transformation vector is T
T
%percentage is below about 44%
percentMatch = size(wantedIndex,1)/size(ka11,1) * 100;

