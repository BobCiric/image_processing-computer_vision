function plotDegree(image,a,b,scale,num)
[XY, Ix, Iy] = gradientPlot(image);
angle = atan2(Iy,Ix); angle = angle(2:end-1,2:end-1);
pts = [b,a];
for i = 1:size(pts,1)
    pts(i,3) = scale;
    pts(i,4) = angle(a(i),b(i));
end
pts = pts';
perm = randperm(size(pts,2)) ;
sel = perm(1:num);

        imshow(image)
        hold on
        vl_plotframe(pts(:,sel))


end