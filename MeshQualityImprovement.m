%Mesh Quality Improvement Algorithm
%Implemented by Nathan Cooper, Theodore Lee, and Qiaojie (Grant) Zheng
function finalQuality = MQI(filename)
    [Ftemp, Vtemp] = stlread(filename);
    [F, V] = removeDuplicateVertices(F,V);
    
end