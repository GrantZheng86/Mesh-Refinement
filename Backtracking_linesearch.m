f = meshQuality('OLYMPUS XZ-2.STL'); %Returns the worst quality of all the vertices
%This is our cost function

function ratio = getratio(x0,x1,x2)
    faceVert = [x0;x1;x2];
    inR = inradius(faceVert);
    ciR = circumradius(faceVert);
    ratio = inR/ciR;
end

function x_min = backtrack(x,alpha)
    %x is a free vertex, alpha is step size

    dir = [1 0 0; 0 1 0; 0 0 1; -1 0 0; 0 -1 0; 0 0 -1; 0 0 0];
    %Normal directions in 3D space
    
    x_min = 0; %Initialized x_min
    
    for i = 1:7 %For each normal direction...
        
        x_k = dir(i) + x; %find a new vertex that minimizes cost function        
        
        x_kratio = getratio(x_k(1),x_k(2),x_k(3)); %get ratio to determine new quality
        
        if ( x_kratio > getratio(x(1),x(2),x(3)) ) 
            x_min = x_k;
        end % get the new vertex the minimizes ratio
    end
    
end
