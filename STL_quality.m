clc
clear variables
close all
% **** JUST A TEST FILE, DO NOT USE FOR FINAL PROJECT *****************
% **** QUALITY ASSESSMENT HAS ALREADY BEEN INTEGRATED INTO A FUNCTION ****
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a test file for the mesh quality assessment using the camera STL
% file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read faces and vertices of the STL file, F is for faces, and  V is for
% vertices
%% This Section is testing code for validity checking: The element is 
% described by vertix (0,0), (-2, 0), and (-1,1)
x = 0;
y = 0;

x1 = -1;
y1 = 1;

x2 = -2;
y2 = 0;

J_0 = [x1-x x2-x; y1-y y2-y];
det(J_0)

% Change x and y to to somewhere outside
x = -2;
y = 1;
J_1 = [x1-x x2-x; y1-y y2-y];
det(J_1)

% Change x and y to be somewhere inside
x = -0.5;
y = 0.5;
J_2 = [x1-x x2-x; y1-y y2-y];
det(J_2)
%%
[F, V] = stlread('OLYMPUS XZ-2.STL'); 

% number of faces
l = size(F, 1);

% initialize the records
worstCase = 0;
for i = 1:l
    % Current faces and vertices
    currFace = F(i,:);
    vert1 = V(currFace(1), :);
    vert2 = V(currFace(2), :);
    vert3 = V(currFace(3), :);
    faceVert = [vert1; vert2; vert3];
    
    % inradius and circumradius calculation
    inR = inradius(faceVert);
    
    ciR = circumradius(faceVert);
    ratio = ciR / inR;
    if ratio > worstCase
        worstCase = ratio;
        record = i;
    end
end

worstCase_usingMethod = meshQuality('OLYMPUS XZ-2.STL'); 
