function [candidate] = realizationsA(numgen,r,R,argmax,f)
%numgen je pocet cisel ktere chci generovat
%r, R jsou tabulky
%Pro ziggurat mam funkci f na intervalu (0,argmax)
candidate=[];
%generating layers
I = randi(128,numgen,1);

    for j = 1:numgen
                
        candidate(j) = rand*r(I(j)+1);

        if candidate(j) <r(I(j))
            %ve skutecnosti chci argmax - candidate
            candidate(j) = argmax - candidate(j);
        else
            dummy = R(I(j)+1) + rand*(R(I(j))-R(I(j)+1));
            if dummy < f(candidate(j))
                candidate(j) = argmax -candidate(j);
            else
                candidate(j)= nan;
            end
        end
    end
candidate(find(isnan(candidate)))=[];
end