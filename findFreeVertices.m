function toReturn = findFreeVertices(F,V)
    [F,V] = removeDuplicateVertices(F,V);
    l = length(F);
    counter = 1;

% Create a cell array for the edges
    for i = 1:l
        currFace = F(i,:);
        edgeList{counter} = [currFace(1), currFace(2)];
        edgeList{counter + 1} = [currFace(2), currFace(3)];
        edgeList{counter + 2} = [currFace(1), currFace(3)];
        counter = counter + 3;    
    end
    totalEdges = counter - 1;
    % Check for shared edges, if it is shared, push it to another cell array
    counter = 1;
    for i = 1:totalEdges
        repeat = -1;
        for j = 1:totalEdges
            if isSameEdge(edgeList{i}, edgeList{j}) == 1
                repeat = repeat + 1;
            end
        end
    
        if repeat == 0
            nonShareEdge(counter, :) = edgeList{i};
            counter = counter + 1;
        end
    end
    [r,c] = size(nonShareEdge);
    nonShareEdge = reshape(nonShareEdge,[r * c, 1] );
    freeVertices = unique(nonShareEdge);
    
    vertixIndex = 1:length(V);
    toReturn = setdiff(vertixIndex, freeVertices);
end