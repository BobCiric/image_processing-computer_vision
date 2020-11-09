function Hmap = harrisMap(image, win)
    [XY, Ix, Iy] = gradientPlot(image);

    g = fspecial('gaussian',win, 2);
    Ixx = conv2(Ix.^2, g);
    Iyy = conv2(Iy.^2, g);
    Ixy = conv2(Ix.*Iy, g);
    
    for i=2:size(Ixx,1)-1
        for j=2:size(Ixx,2)-1
     Ix2=Ixx(i-1:i+1,j-1:j+1); Ix2 = sum(Ix2(:));
     Iy2=Iyy(i-1:i+1,j-1:j+1); Iy2 = sum(Iy2(:));
     Ixy2=Ixy(i-1:i+1,j-1:j+1); Ixy2 = sum(Ixy2(:));
     M=[Ix2 Ixy2;
        Ixy2 Iy2];
     R(i,j)=det(M)-0.04*trace(M).^2; %(1) Build autocorrelation matrix for every singe pixel considering a window of size 3x3
        end
    end
R = R(win/2+1:end-win/2,win/2+1:end-win/2);
Hmap = R./max(R(:))*255;
    
end