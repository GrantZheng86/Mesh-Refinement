function toReturn = meshQuality(fileName)
% This function measures the mesh qulity for STL file
% INPUT: fileName -> A string that is the file name
% OUTPUT: toReturn -> a double represent the mesh quality
    [F,V] = stlread(fileName);
    l = size(F,1);
    worstCase = 0;
    for i = 1:l
        currFace = F(i,:);
        vert1 = V(currFace(1), :);
        vert2 = V(currFace(2), :);
        vert3 = V(currFace(3), :);
        faceVert = [vert1; vert2; vert3];
        inR = inradius(faceVert);
        ciR = circumradius(faceVert);
        ratio = ciR / inR;
        if ratio > worstCase
            worstCase = ratio;
        end
    end
    
    toReturn = worstCase;
    

end