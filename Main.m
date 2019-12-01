clc
clear variables
close all

%% reading the STL file, remove duplicated vertices and find free vertices
[F, V] = stlread('Circle2d_norepeat.stl'); 
[F,V] = removeDuplicateVertices(F,V);
freeVerts = findFreeVertices(F,V);
freeV_l = length(freeVerts);

%% Pattern search
f_init = meshQuality(F,V);
f_curr = f_init;
f_des = 0.3;
count = 0;

alpha = 0.2;
tol = 1e-7;
gamma = 0.9;
delta = 1.5;
currVAll = V;

while (f_curr - f_init) < 0.95 * (f_des - f_init) && count < 5
    for i = 1:freeV_l
        currV = freeVerts(i);
        xi_new = explore(F,currVAll,alpha,currV); 
        
        

