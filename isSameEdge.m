function toReturn = isSameEdge(edge1, edge2)

if (edge1(1) == edge2(1) && edge1(2) == edge2(2))
    toReturn = 1;
elseif edge1(1) == edge2(2) && edge1(2) == edge2(1)
    toReturn = 1;
else
    toReturn = 0;
end
end


