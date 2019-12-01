function x_max = explore(F,V,Alpha,Vi)
    % This function returns a new location for the worst quality vertex
    % INPUT: Vertex -> a 1x3 vector containing vertex coordinates
    %                   [x1, y1, z1]
    % INPUT: Quality -> scalar containing the quality of the input vertex
    % INPUT: Alpha -> step size
    % OUTPUT: toReturn -> a 1x3 vector containing improved vertex coordinates
    Q = meshQuality(F,V);
    dir = [1 0 0; 0 1 0; -1 0 0; 0 -1 0; 0 0 0]*Alpha;
    % Normal directions in 3D space
    
    x_max = 0.5; %Initialized x_min
    for i = 1:length(dir) %For each normal direction...
        Vnew = V;

        Vnew(Vi,:) = V(Vi,:) + dir(i,:); %find a new vertex that minimizes cost function        

        q = meshQuality(F,Vnew); %get ratio to determine new quality

        if ( Q < q ) 
            Q = q;
            x_max = Vnew(Vi,:); % get the new vertex that minimizes quality
            %disp(j)
        end 
    end
    
    
    %disp(x_min)
end
