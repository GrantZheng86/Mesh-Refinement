function toReturn = meshQuality2(F,V)
% This function measures the mesh qulity for STL file
% INPUT: F -> List of Face Vertex Indices
% INPUT: V -> List of Vertex Coordinates
% OUTPUT: toReturn -> a double represent the mesh quality
    l = size(F,1);
    sumquality = 0;
    for i = 1:l
        currFace = F(i,:);
        vert1 = V(currFace(1), :);
        vert2 = V(currFace(2), :);
        vert3 = V(currFace(3), :);
        faceVert = [vert1; vert2; vert3];
        inR = inradius(faceVert);
        ciR = circumradius(faceVert);
        ratio = inR / ciR;
        sumquality = sumquality+ratio;
    end
    
    toReturn = sumquality/l;
    
    

end