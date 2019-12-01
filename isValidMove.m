function toReturn = isValidMove(F,V,Vi,Vnew)
    l = length(F);
    VnewAll=V;
    VnewAll(Vi,:)=Vnew;
    for i = 1:l
        if (F(i,1) == Vi || F(i,2) == Vi || F(i,3) == Vi)
            if(F(i,1) == Vi)
                V1original = V(F(i,1),:);
                V2original = V(F(i,2),:);
                V3original = V(F(i,3),:);
                V1new = VnewAll(F(i,1),:);
                V2new = VnewAll(F(i,2),:);
                V3new = VnewAll(F(i,3),:);
            elseif(F(i,2) ==  Vi) 
                V2original = V(F(i,1),:);
                V1original = V(F(i,2),:);
                V3original = V(F(i,3),:);
                V2new = VnewAll(F(i,1),:);
                V1new = VnewAll(F(i,2),:);
                V3new = VnewAll(F(i,3),:);
            else
                V3original = V(F(i,1),:);
                V2original = V(F(i,2),:);
                V1original = V(F(i,3),:);
                V3new = VnewAll(F(i,1),:);
                V2new = VnewAll(F(i,2),:);
                V1new = VnewAll(F(i,3),:);
            end
            J_original = [V3original(1)-V1original(1) V2original(1)-V1original(1);V3original(2)-V1original(2) V2original(2)-V1original(2)];
            J_new = [V3new(1)-V1new(1) V2new(1)-V1new(1);V3new(2)-V1new(2) V2new(2)-V1new(2)];
            valid=det(J_original)*det(J_new);
            if(valid < 0)
                toReturn = false;
                return;
            end
        end
    end
    toReturn = true;
    return;
end

