function toReturn = circumradius(faceVertices)
    % This function calculates the circumradius of a triangle
    % INPUT: faceVertices -> a 3x3 matrix containing vertices information
    % OUTPUT: toReturn -> a double that is the circumradius
    
    [a,b,c] = sideLength(faceVertices);
    s = 0.5 * (a + b + c);
    toReturn = (a * b * c) / (4 * sqrt(s * (a + b - s)*(a+c-s)*(b+c-s)));
end