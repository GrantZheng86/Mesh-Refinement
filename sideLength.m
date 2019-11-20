function [a,b,c] = sideLength(faceVertices)
% This function calculates side length of the triangle given vertices
% information
% INPUT: faceVertices -> a 3x3 matrix containing vertices information
%                       [x1, y1, z1;
%                        x2, y2, z2;
%                        x3, y3, z3];
% OUTPUT: [a,b,c] -> a vector containing 3 side lengthes
    
    diff1 = faceVertices(1,:) - faceVertices(2,:);
    a = norm(diff1);
    diff2 = faceVertices(1,:) - faceVertices(3,:);
    b = norm(diff2);
    diff3 = faceVertices(2,:) - faceVertices(3,:);
    c = norm(diff3);
    
        
end