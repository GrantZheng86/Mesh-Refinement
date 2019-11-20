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
