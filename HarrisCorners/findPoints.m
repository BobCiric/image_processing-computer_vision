function pts = findPoints(image,a,b,scale)
[XY, Ix, Iy] = gradientPlot(image);
angle = atan2(Iy,Ix); angle = angle(2:end-1,2:end-1);
pts = [b,a];
for i = 1:size(pts,1)
    pts(i,3) = scale;
    pts(i,4) = angle(a(i),b(i));
end
pts = pts';
end