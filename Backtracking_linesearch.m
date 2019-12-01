function x_min = explore(Q,F,V,Alpha)
    % This function returns a new location for the worst quality vertex
    % INPUT: Vertex -> a 1x3 vector containing vertex coordinates
    %                   [x1, y1, z1]
    % INPUT: Quality -> scalar containing the quality of the input vertex
    % INPUT: Alpha -> step size
    % OUTPUT: toReturn -> a 1x3 vector containing improved vertex coordinates
    
    dir = [1 0 0; 0 1 0; 0 0 1; -1 0 0; 0 -1 0; 0 0 -1; 0 0 0]*Alpha;
    % Normal directions in 3D space
    
    x_min = 0; %Initialized x_min
    l = size(F,1);
    for j = 1:l
        for i = 1:7 %For each normal direction...
            Vnew = V;
            
            Vnew(j,:) = V(j,:) + dir(i,:); %find a new vertex that minimizes cost function        

            q = meshQuality(F,Vnew); %get ratio to determine new quality
        
            if ( Q > q ) 
                Q = q;
                x_min = Vnew(j,:) % get the new vertex that minimizes quality
                disp(j)
            end 
        end
    end
    
    disp(x_min)
end
