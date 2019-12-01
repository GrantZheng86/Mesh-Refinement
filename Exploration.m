
f = @(ratio) max(ratio); %Returns the worst quality of all the vertices
%This is our cost function

circ = stlread('circle_nonrepeat.stl');

F = circ.faces();
V = circ.vertices();
Q = meshQuality(F,V);
explore(Q,F,V,1);

% function x_min = explore(Q,F,V,Alpha)
%     % This function returns a new location for the worst quality vertex
%     % INPUT: Vertex -> a 1x3 vector containing vertex coordinates
%     %                   [x1, y1, z1]
%     % INPUT: Quality -> scalar containing the quality of the input vertex
%     % INPUT: Alpha -> step size
%     % OUTPUT: toReturn -> a 1x3 vector containing improved vertex coordinates
%     
%     dir = [1 0 0; 0 1 0; 0 0 1; -1 0 0; 0 -1 0; 0 0 -1; 0 0 0]*Alpha;
%     % Normal directions in 3D space
%     
%     x_min = 0; %Initialized x_min
%     
%     for j = 1:1
%         for i = 1:7 %For each normal direction...
%             Vnew = V;
%             
%             Vnew(j,:) = V(j,:) + dir(i,:); %find a new vertex that minimizes cost function        
% 
%             q = meshQuality(F,Vnew); %get ratio to determine new quality
%         
%             if ( Q > q ) 
%                 Q = q;
%                 x_min = Vnew(j,:) % get the new vertex that minimizes quality
%                 disp(j)
%             end 
%         end
%     end
%     
%     %disp(x_min)
% end

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

function toReturn = circumradius(faceVertices)
    % This function calculates the circumradius of a triangle
    % INPUT: faceVertices -> a 3x3 matrix containing vertices information
%                       [x1, y1, z1;
%                        x2, y2, z2;
%                        x3, y3, z3];
    % OUTPUT: toReturn -> a double that is the circumradius
    
    [a,b,c] = sideLength(faceVertices);
    s = 0.5 * (a + b + c);
    toReturn = (a * b * c) / (4 * sqrt(s * (a + b - s)*(a+c-s)*(b+c-s)));
end

function toReturn = inradius(faceVertices)
    % This function calculates the inradius of a triangle
    % INPUT: faceVertices -> a 3x3 matrix containing vertices information
%                       [x1, y1, z1;
%                        x2, y2, z2;
%                        x3, y3, z3];
    % OUTPUT: toReturn -> a double that is the inradius
    
    [a,b,c] = sideLength(faceVertices);
    s = 0.5 * (a + b + c);
    K = (sqrt(s * (s - a)*(s - b)*(s - c)))/s;
    toReturn = K;
end

function toReturn = meshQuality(F,V)
% This function measures the mesh qulity for STL file
% INPUT: F -> List of Face Vertex Indices
% INPUT: V -> List of Vertex Coordinates
% OUTPUT: toReturn -> a double represent the mesh quality
%    [F,V] = stlread(fileName);
    l = size(F,1);
    worstCase = 1;
    for i = 1:l
        currFace = F(i,:);
        vert1 = V(currFace(1), :);
        vert2 = V(currFace(2), :);
        vert3 = V(currFace(3), :);
        faceVert = [vert1; vert2; vert3];
        inR = inradius(faceVert);
        ciR = circumradius(faceVert);
        ratio = inR / ciR;
        if ratio < worstCase
            worstCase = ratio;
        end
    end
    
    toReturn = worstCase;

end
