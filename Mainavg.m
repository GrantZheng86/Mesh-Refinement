clc
clear variables
close all

%% reading the STL file, remove duplicated vertices and find free vertices
[F, V] = stlread('InnerOuterBoundaryMesh2d.stl'); 
[F,V] = removeDuplicateVertices(F,V);
freeVerts = findFreeVertices(F,V);
freeV_l = length(freeVerts);

%% Pattern search
f_init = meshQuality2(F,V);
f_curr = f_init;
f_des = 0.3;
count = 0;

alpha = .1;
tol = 1e-7;
gamma = 0.9;
delta = 1.5;
currVAll = V;
iterationLimit = 25;
while (f_curr - f_init) < 0.95 * (f_des - f_init) && count < 5 
    for i = 1:freeV_l
        currV = freeVerts(i);
        xi_new = explore(F,currVAll,alpha,currV); 
        iterations = 0;
        while ((~isValidMove(F, currVAll, currV, xi_new)) &&  iterations < iterationLimit)
            %get direction
            dir = xi_new - currVAll(currV,:);
            %multiply by backtracking linesearch parameter
            dir = dir*gamma;
            %reassign xi_new
            xi_new = currVAll(currV,:)+dir;
            iterations = iterations + 1;
        end
        newVall = currVAll;
        newVall(currV,:) = xi_new;
        if (meshQuality2(F,newVall) > meshQuality2(F, currVAll)) && iterations < iterationLimit
            currVAll = newVall;
            alpha = alpha*delta;
        end
    end
    f_new = meshQuality2(F, currVAll)
    if(f_new - f_curr < 1e-15)
        count = count + 1;
    end
    f_curr = f_new;
    

    TR = triangulation(F,currVAll);
    figure(1)
    triplot(TR)
end

TR = triangulation(F,currVAll);
TR2 = triangulation(F, V);
figure(1)
triplot(TR)
figure(2)
triplot(TR2)
