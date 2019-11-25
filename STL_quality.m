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
counter = 1;
for ii = 1:l_f
    currFace = F(ii,:);
    edge = zeros(3,2);
    edge(1,:) = [currFace(1), currFace(2)];
    edge(2,:) = [currFace(2), currFace(3)];
    edge(3,:) = [currFace(1), currFace(3)];
    
    % initialization Stage
    if isempty(edgeList) == 1
        for jj = 1:3
            edgeList{jj}.vertices = edge(jj, :);
            edgeList{jj}.face(1) = ii;
            edgeList{jj}.faceCount = 1;
            edgeList{jj}.AKA = 'none';    % AKA is reserved for repeating edges
            counter = counter + 1;
        end
        
    else 
        for jj = 1:3
            currEdge = edge(jj, :);
            edgeFaceInfo = findRepeatEdge(currEdge, edgeList,V);
            if(edgeFaceInfo ~= 0)
                edgeList{edgeFaceInfo}.face(2) = ii;
                edgeList{edgeFaceInfo}.faceCount = 2;
            else
                edgeList{counter}.vertices = edge(jj, :);
                edgeList{counter}.face(1) = ii;
                edgeList{counter}.faceCount = 1;
                counter = counter + 1;
            end
        end
                
                
    end
    
    
    
    
end

function edgeNum = findRepeatEdge(currEdge, edgeList,V)
    % this function intends to find repeated edge in the list and return
    % the index for the face
    % INPUT: currEdge -> the currentEdge, a 1x2 array containing vertices
    %        edgeList -> a cell array of edge struct data
    % OUTPUT: edgeNum -> returns the index of the repeating edge that is
    %                    already in the edgeList
    
    l = length(edgeList);
   
    edgeNum = 0;
   for ii = 1:l
       testEdge = edgeList{ii}.vertices;
       isSame = testRepeatEdge(currEdge, testEdge,V);
       if (isSame ~= 0)
           edgeNum = ii;
       end
       
   end
end

function toReturn = testRepeatEdge(edge1, edge2, V)
% This function tests for repeating edges, if the two edges are identical
% The function will return 1, 0 elsewise
% INPUT: edge1 -> a 2x1 int array that contains vertix index;
%        edge2 -> same structure as edge1
%        V -> The matrix of doubles that contains vertix X,Y,Z information
% OUTPUT: toReturn -> a binary indicator to tell whether edge1 and edge 2
%                     are the same. 1 for same and 0 otherwise. 
    vert1 = edge1(1);
    vert2 = edge1(2);
    vert3 = edge2(1);
    vert4 = edge2(2);
    
    if testRepeatVert(vert1, vert3,V) == 1 && testRepeatVert(vert2, vert4, V) == 1
        toReturn = 1;
    elseif testRepeatVert(vert1, vert4,V) == 1 && testRepeatVert(vert2, vert3, V) == 1
        toReturn = 1;
    else
        toReturn = 0;
    end
       
end
function toReturn = testRepeatVert(vert1, vert2, V)
    vert1 = V(vert1,:);
    vert2 = V(vert2,:);
    
    toReturn = 1;
    for ii = 1:3
        if abs(vert1(ii) - vert2(ii)) < 1e-2
            toReturn = and(1, toReturn);
        else
            toReturn = 0;
            return
        end
    end
end
    
