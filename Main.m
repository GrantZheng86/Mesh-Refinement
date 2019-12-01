clc
clear variables
close all

%% reading the STL file and remove duplicated vertices
[F, V] = stlread('Circle2d_norepeat.stl'); 
[F,V] = removeDuplicateVertices(F,V);