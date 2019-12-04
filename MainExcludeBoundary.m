clc
clear variables
close all

%% reading the STL file, remove duplicated vertices and find free vertices
[F, V] = stlread('InnerOuterBoundaryMesh2d.stl'); 
[F,V] = removeDuplicateVertices(F,V);
freeVerts = findFreeVertices(F,V);
freeV_l = length(freeVerts);
%V = disturbFreeVerts(V, freeVerts, 3);

%% Pattern search
f_init = meshQuality3(F,V, freeVerts);
f_curr = f_init;
f_des = 0.5;
count = 0;

alpha = .01;
tol = 1e-7;
gamma = 0.9;
delta = 1.01;
currVAll = V;

while (f_curr - f_init) < 0.95 * (f_des - f_init) && count < 5
    for i = 1:freeV_l
        currV = freeVerts(i);
        xi_new = explore2(F,currVAll,alpha,currV, freeVerts); 
        while (~isValidMove(F, currVAll, currV, xi_new))
            %get direction
            dir = xi_new - currVAll(currV,:);
            %multiply by backtracking linesearch parameter
            dir = dir*gamma;
            %reassign xi_new
            xi_new = currVAll(currV,:)+dir;
        end
        newVall = currVAll;
        newVall(currV,:) = xi_new;
        if (meshQuality3(F,newVall, freeVerts) > meshQuality3(F, currVAll, freeVerts))
            currVAll = newVall;
            alpha = alpha*delta;
        end
    end
    f_new = meshQuality3(F, currVAll, freeVerts)
    if(f_new - f_curr < 1e-10)
        count = count + 1
        display("Count Increase Difference: "+(f_new-f_curr))
    end
    f_curr = f_new;
    TR = triangulation(F,currVAll);

    figure(1)
    triplot(TR, "Color", "red", "LineWidth", 2)
    xlabel("Initial Quality: "+f_init+" Final Quality: "+f_curr)
end

hold on
TR2 = triangulation(F, V);
triplot(TR2, "LineStyle", ":", "LineWidth", 2)
%title("Worst Case (Excluding Boundary) Objective Function Grid Results")
legend({"Optimized Mesh","Original Mesh"})
hold off