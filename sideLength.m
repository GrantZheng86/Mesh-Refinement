function [a,b,c] = sideLength(faceVertices)
% This function calculates side length of the triangle given vertices
% information
% INPUT: faceVertices -> a 3x3 matrix containing vertices information
% OUTPUT: [a,b,c] -> a vector containing 3 side lengthes
    
    diff1 = faceVertices(1,:) - faceVertices(2,:);
    a = norm(diff1);
    diff2 = faceVertices(1,:) - faceVertices(3,:);
    b = norm(diff2);
    diff3 = faceVertices(2,:) - faceVertices(3,:);
    c = norm(diff3);
    
        
end