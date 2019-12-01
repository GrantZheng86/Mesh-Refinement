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
   
    if sum(dif) < 1e-3
        toReturn = 1;
    else 
        toReturn = 0;
    end
end