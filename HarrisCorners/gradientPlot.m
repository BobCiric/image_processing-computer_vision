function [XY, Ix, Iy] = gradientPlot(image)
dx = [-1 0 1; -1 0 1; -1 0 1]; % image derivatives
dy = dx';
Ix = conv2(image,dx);
Iy = conv2(image,dy);

XY = [Ix, Iy];

end