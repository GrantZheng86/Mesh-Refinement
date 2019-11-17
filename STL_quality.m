clc
clear variables
close all

[F, V] = stlread('OLYMPUS XZ-2.STL');
l = size(F, 1);
worstCase = 0;
record = 0;
for i = 1:l
    currFace = F(i,:);
    vert1 = V(currFace(1), :);
    vert2 = V(currFace(2), :);
    vert3 = V(currFace(3), :);
    faceVert = [vert1; vert2; vert3];
    if i == 43025
        temp = 1;
    end
    inR = inradius(faceVert);
    
    ciR = circumradius(faceVert);
    ratio = ciR / inR;
    if ratio > worstCase
        worstCase = ratio;
        record = i;
    end
end

function toReturn = inradius(faceVertices)
    [a,b,c] = sideLength(faceVertices);
    s = 0.5 * (a + b + c);
    K = (sqrt(s * (s - a)*(s - b)*(s - c)))/s;
    toReturn = K;
end

function toReturn = circumradius(faceVertices)
    [a,b,c] = sideLength(faceVertices);
    s = 0.5 * (a + b + c);
    toReturn = (a * b * c) / (4 * sqrt(s * (a + b - s)*(a+c-s)*(b+c-s)));
end

function [a,b,c] = sideLength(faceVertices)
    
    
    diff1 = faceVertices(1,:) - faceVertices(2,:);
    a = norm(diff1);
    diff2 = faceVertices(1,:) - faceVertices(3,:);
    b = norm(diff2);
    diff3 = faceVertices(2,:) - faceVertices(3,:);
    c = norm(diff3);
    
        
end