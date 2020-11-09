%% ps3 Jinghang Li jil202@pitt.edu 
clear
clc
%%
norm2d = importdata(fullfile('input', 'pts2d-norm-pic_a.txt'));
norm3d = importdata(fullfile('input', 'pts3d-norm.txt'));
norm3d = [norm3d,repmat(1,20,1)];
pts2d_a = importdata(fullfile('input', 'pts2d-pic_a.txt'));
pts3d_a = importdata(fullfile('input', 'pts3d.txt'));
pts2d_b = importdata(fullfile('input', 'pts2d-pic_b.txt'));

%% 1.a
M = [-0.4583, 0.2947, 0.0139, -0.0040; 0.0509, 0.0546, 0.5410, 0.0524; -0.1090, -0.1784, 0.0443, -0.5968];
X = norm3d(:,1);
Y = norm3d(:,2);
Z = norm3d(:,3);

[rows, cols] = size(norm3d);
for i = 1:rows
        pts2d = M * norm3d(i,:)'; 
        pts2d = (pts2d./(pts2d(end)))';
        pts2dAfterNorm(i,1:length(pts2d)) = pts2d;
end

%% 1.a
A = [];
for i = 1:rows
   A(2*i-1,:) = [norm3d(i,1), norm3d(i,2),norm3d(i,3), norm3d(i,4),0,0,0,0, -norm2d(i,1)*norm3d(i,1), -norm2d(i,1)*norm3d(i,2), -norm2d(i,1)*norm3d(i,3),-norm2d(i,1)*norm3d(i,4)];%eq1
   A(2*i,:) = [0,0,0,0,norm3d(i,1), norm3d(i,2),norm3d(i,3), norm3d(i,4), -norm2d(i,2)*norm3d(i,1), -norm2d(i,2)*norm3d(i,2), -norm2d(i,2)*norm3d(i,3),-norm2d(i,2)*norm3d(i,4)];%eq2 
end

newA = A' * A;
[V,D] = eig(newA);
newM = reshape(V(:,1),4,3)' % recovered matrix M
[rows, cols] = size(norm3d);

pts2d1 = newM * norm3d(1,:)'; 
pts2d1 = (pts2d1./(pts2d1(end)))'; %first <u, v> projection
pts2d1 = pts2d1(1:2);
fprintf(f'<U, V> {pts2d1}')
pts2d2 = newM * norm3d(end,:)'; 
pts2d2 = (pts2d2./(pts2d2(end)))'; %second <u, v> projection
pts2d2 = pts2d2(1:2)

residual1 = sum((pts2d1(1:2) - norm2d(1,:)).^2)^0.5 %residual between projected and the actual given location
residual2 = sum((pts2d2(1:2) - norm2d(end,:)).^2)^0.5 %residual between projected and the actual given location

%% 1.b
twoDPoints = importdata(fullfile('input', 'pts2d-pic_b.txt'));
threeDPoints = importdata(fullfile('input', 'pts3d.txt'));
threeDPoints = [threeDPoints,repmat(1,length(threeDPoints),1)];

%k=8
k=8;
fullInd = (1:1:20);
for i = 1:10
ind =  randperm(20,k); %randomly chose 8 points
M_1b = projectionM(twoDPoints(ind,:), threeDPoints(ind,:)); %M from those random 8 points
remain = fullInd(~ismember(fullInd,ind));
remain4PtInd = remain(1:4);

pts3 = threeDPoints(remain4PtInd,:);
pts2 = twoDPoints(remain4PtInd,:);

aveResidual_k8(i) = averageResidual(pts3,pts2, M_1b);
end
minK_8 = min(aveResidual_k8);

%k=12
k=12;
fullInd = (1:1:20);
for i = 1:10
ind =  randperm(20,k); %randomly chose 8 points
M_1b = projectionM(twoDPoints(ind,:), threeDPoints(ind,:)); %M from those random 8 points
remain = fullInd(~ismember(fullInd,ind));
remain4PtInd = remain(1:4);

pts3 = threeDPoints(remain4PtInd,:);
pts2 = twoDPoints(remain4PtInd,:);

aveResidual_k12(i) = averageResidual(pts3,pts2, M_1b);
end
minK_12 = min(aveResidual_k12);

%k=12
k=16;
fullInd = (1:1:20);
M_1b = {}
for i = 1:10
ind =  randperm(20,k); %randomly chose 8 points
M_1b{i} = projectionM(twoDPoints(ind,:), threeDPoints(ind,:)); %M from those random 8 points
remain = fullInd(~ismember(fullInd,ind));
remain4PtInd = remain(1:4);

pts3 = threeDPoints(remain4PtInd,:);
pts2 = twoDPoints(remain4PtInd,:);

aveResidual_k16(i) = averageResidual(pts3,pts2, M_1b{i});
end
minK_16 = min(aveResidual_k16);

residualResult_1b = [aveResidual_k8',aveResidual_k12', aveResidual_k16']
bestResidual = min(residualResult_1b)
[i,j] = find(residualResult_1b ==min(min(residualResult_1b)));
bestM = M_1b{i}
%% 1.c
Q = bestM(:,1:3);
b = bestM(:,end);
C = -inv(Q) * b

%% 2.a.
fM = fundementalM(pts2d_a, pts2d_b);
[V,D] = eig(fM'*fM);
newfM = reshape(V(:,1),3,3)'

%% 2.b.
[U,S,V] = svd(newfM);
Sprime=S;
Sprime(3,3) = 0;
reducedfM =  U * Sprime * V'
%% 2.c
%F = estimateFundamentalMatrix(pts2d_b,pts2d_a);

a = im2double(imread(fullfile('input', 'pic_a.jpg')));
pts2d_b1 = [pts2d_b,repmat(1,20,1)]';
lines = epiLine(reducedfM,pts2d_b1);
points = zeros(length(pts2d_b1),4);
points(:,1) = 0; points(:,3) = 1072;

for i = 1:length(pts2d_b1)
    points(i,2) = abs(lines(i,3)/lines(i,2));
    points(i,4) = abs((lines(i,1) * 1072 + lines(i,3))/lines(i,2));
end

imshow(a)
line(points(:,[1,3])',points(:,[2,4])');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps3-2-c-1.png']);
close

fM = fundementalM(pts2d_b, pts2d_a);
[V,D] = eig(fM'*fM);
newfM = reshape(V(:,1),3,3)';
[U,S,V] = svd(newfM);
Sprime=S;
Sprime(3,3) = 0;
reducedfM =  U * Sprime * V'
b = im2double(imread(fullfile('input', 'pic_b.jpg')));
pts2d_a1 = [pts2d_a,repmat(1,20,1)]';
lines_b = epiLine(reducedfM,pts2d_a1);
points = zeros(length(pts2d_a1),4);
points(:,1) = 0; points(:,3) = 1072;
for i = 1:length(pts2d_a1)
    points(i,2) = abs(lines_b(i,3)/lines_b(i,2));
    points(i,4) = abs((lines_b(i,1) * 1072 + lines_b(i,3))/lines_b(i,2));
end
imshow(b)
line(points(:,[1,3])',points(:,[2,4])');
Image = getframe(gcf);
imwrite(Image.cdata,['output',filesep,'ps3-2-c-2.png']);
close
