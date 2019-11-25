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

%% This section is used for boundary vertices detection
clc
clear variable 
close all

[F, V] = stlread('Circle2d.STL');
uniqV = uniqueVertices(V);
l = length(F);
l_u = length(uniqV);

for i = 1:l
    currFace = F(i,:);
    for j = 1:3
        currVert = currFace(j);
        for k = 1:l_u
            if (isRepeat(V(currVert,:), uniqV(k,:)) ~= 0)
                F(i,j) = k;
            end
        end
    end
end
V = uniqV;
TR = triangulation(F,V);
triplot(TR)
            
        

%% This section is used for testing repeating vertices
[F,V] = stlread('Circle2d.STL');
temp = uniqueVertices(V);

function toReturn = isRepeat(vert1, vert2)
% This function tests if the two vertices are the same
% INPUT: vert1 -> a 3x1 double array indicates the X,Y,Z location of vert1
%        vert2 -> a 3x1 double array indicates the X,Y,Z location of vert2
% OUPUT: toReturn -> a binary number that indicates if they are the same or
%                    not, 1 represent same, 0 represent not
    dif = zeros(3,1);
    for i = 1:3
        dif(i) = abs(vert1(i) - vert2(i));
    end
   
    if sum(dif) < 1e-2
        toReturn = 1;
    else 
        toReturn = 0;
    end
end

function toReturn = uniqueVertices(vList)
    [r, ~] = size(vList);
    toReturn(1,:) = vList(1,:);
    counter = 2;
    for i = 1:r
       sameCount = 0;
       [currListLength, ~] = size(toReturn);
       
       for j = 1:currListLength
           if isRepeat(vList(i,:), toReturn(j,:)) ~= 0
               sameCount = sameCount + 1;
           end
       end
       
       if sameCount == 0
           toReturn(counter, :) = vList(i, :);
           counter = counter + 1;
       end
    end
end
           
%% This section is used for edge detection      
