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

[F, V] = stlread(''); 

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




%% This section is used for edge vertices detection
clc
clear variables
close all

[F,V] = stlread('Circle2d allzero.STL');
[F,V] = removeDuplicateVertices(F,V);
l = length(F);
counter = 1;

% Create a cell array for the edges
for i = 1:l
    currFace = F(i,:);
    edgeList{counter} = [currFace(1), currFace(2)];
    edgeList{counter + 1} = [currFace(2), currFace(3)];
    edgeList{counter + 2} = [currFace(1), currFace(3)];
    counter = counter + 3;    
end
totalEdges = counter - 1;
% Check for shared edges, if it is shared, push it to another cell array
counter = 1;
for i = 1:totalEdges
    repeat = -1;
    for j = 1:totalEdges
        if isSameEdge(edgeList{i}, edgeList{j}) == 1
            repeat = repeat + 1;
        end
    end
    
    if repeat == 0
        nonShareEdge(counter, :) = edgeList{i};
        counter = counter + 1;
    end
end
[r,c] = size(nonShareEdge);
nonShareEdge = reshape(nonShareEdge,[r * c, 1] );

TR = triangulation(F,V);
figure(1)
triplot(TR)

freeVertices = findFreeVertices(F,V);
x = V(freeVertices,1);
y = V(freeVertices,2);
figure(1)
hold on
plot(x,y,'ro')



%% This section is used for testing repeating vertices
[F,V] = stlread('Circle2d allzero.STL');
temp = uniqueVertices(V);

%% These is the section for functions


