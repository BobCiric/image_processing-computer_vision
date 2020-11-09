function newM = projectionM(twoDPts, threeDPts)

    A = [];
    for i = 1:length(twoDPts)
        A(2*i-1,:) = [threeDPts(i,1), threeDPts(i,2),threeDPts(i,3), threeDPts(i,4),0,0,0,0, -twoDPts(i,1)*threeDPts(i,1), -twoDPts(i,1)*threeDPts(i,2), -twoDPts(i,1)*threeDPts(i,3),-twoDPts(i,1)*threeDPts(i,4)];%eq1
        A(2*i,:) = [0,0,0,0,threeDPts(i,1), threeDPts(i,2),threeDPts(i,3), threeDPts(i,4), -twoDPts(i,2)*threeDPts(i,1), -twoDPts(i,2)*threeDPts(i,2), -twoDPts(i,2)*threeDPts(i,3),-twoDPts(i,2)*threeDPts(i,4)];%eq2 
    end
    
    newA = A' * A;
    [V,D] = eig(newA);
    newM = reshape(V(:,1),4,3)';
end