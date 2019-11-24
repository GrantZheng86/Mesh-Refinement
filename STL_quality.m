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
%% This section is used for testing mesh quality asssessment
clc
clear variables
close all

[F, V] = stlread('OLYMPUS XZ-2.STL'); 

% number of faces
l = size(F, 1);

% initialize the records
worstCase = 1;
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
    ratio = inR / ciR;
        if ratio < worstCase
            worstCase = ratio;
        end
end

worstCase_usingMethod = meshQuality(F, V); 

%% This section is used to edge detection (2D)
clc
clear variables
close all

[F, V] = stlread('Circle2d.STL');
l_f = length(F);
edgeList = {};  % Initialize edge list cell array
for ii = 1:l_f
    currFace = F(ii,:);
    edge = zeros(3,2);
    edge(1,:) = [currFace(1), currFace(2)];
    edge(2,:) = [currFace(2), currFace(3)];
    edge(3,:) = [currFace(1), currFace(3)];
    
    if isempty(edgeList) == 1
        for jj = 1:3
            edgeList{jj}.vertices = edge(jj, :);
            edgeList{jj}.face = ii;
            edgeList{jj}.faceCount = 1;
        end
    end
end
            
        
    
