function toReturn = inradius(faceVertices)
    % This function calculates the inradius of a triangle
    % INPUT: faceVertices -> a 3x3 matrix containing vertices information
    % OUTPUT: toReturn -> a double that is the inradius
    
    [a,b,c] = sideLength(faceVertices);
    s = 0.5 * (a + b + c);
    K = (sqrt(s * (s - a)*(s - b)*(s - c)))/s;
    toReturn = K;
end