%Mesh Quality Improvement Algorithm
%Implemented by Nathan Cooper, Theodore Lee, and Qiaojie (Grant) Zheng
function finalQuality = MeshQualityImprovement(filename)
    [Ftemp, Vtemp] = stlread(filename);
    [F, V] = removeDuplicateVertices(F,V);
    freeVerts = findFreeVertices(F,V);
end