function toReturn = uniqueVertices(vList)
    % vList is a nx3 matrix containing position information for vertices
    [r, ~] = size(vList);
    toReturn(1,:) = vList(1,:);
    counter = 2;
    
    % loop through all vertices
    for i = 1:r
       sameCount = 0;
       [currListLength, ~] = size(toReturn); % get the size of the unique vertices
       
       for j = 1:currListLength              % loop through all current unique vertices
           if isRepeat(vList(i,:), toReturn(j,:)) ~= 0
               sameCount = sameCount + 1;
           end
       end
       
       if sameCount == 0                    % if the current vertix does not have a repeat, push it to the return matrix
           toReturn(counter, :) = vList(i, :);
           counter = counter + 1;
       end
       
    end
end
           
