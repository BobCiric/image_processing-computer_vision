function aveResidual = averageResidual(threeDPts, twoDPts, M)
    for i = 1:length(threeDPts)
       pts2d = M * threeDPts(i,:)';
       pts2d = (pts2d./(pts2d(end)))';
       residual(i) = sum((pts2d(1:2) - twoDPts(i,:)).^2)^0.5;
    end
    aveResidual = sum(residual)/length(residual);
end