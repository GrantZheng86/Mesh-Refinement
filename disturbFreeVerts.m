function newV = disturbFreeVerts(V,freeV,maxdelta)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    Vtemp = V;
for i=1:length(freeV)
    displace = [(rand()-.5)*2 (rand()-.5)*2 (rand()-.5)*2];
    displace = maxdelta*displace;
    Vtemp(freeV(i),:) = V(freeV(i),:)+displace;
end
newV = Vtemp;
end

