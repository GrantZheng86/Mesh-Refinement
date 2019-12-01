function [F_n, V_n] = removeDuplicateVertices(F,V)
    
    % unique vertices in the vertix list
    uniqV = uniqueVertices(V);
    l = length(F);
    l_u = length(uniqV);
    tempF = F;
    
    % loop through all faces
    for i = 1:l
        currFace = F(i,:);
        
        % loop through 3 edges
        for j = 1:3
            currVert = currFace(j);
            for k = 1:l_u
                if (isRepeat(V(currVert,:), uniqV(k,:)) ~= 0)
                    tempF(i,j) = k;
                end
            end
        end
    end
    V_n = uniqV;
    F_n = tempF;
end
