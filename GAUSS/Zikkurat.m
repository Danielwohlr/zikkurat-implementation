function [candidate] = Zikkurat(numgen,numlay)
%numgen je pocet generovanych cisel
%candidate jsou realizace

%Nagenerovani obdelniku, potrebnych hodnot,...
%popis promennych je ve funkci generateTable
[r,R,~,f] = generateTable(numlay);


%candidate je realizace z hustoty
candidate = nan(numgen,1);

%nagenerovani potrebnych random uniform pro for cyklus
U = rand(numgen,2);

%Layer 1 je nahore, layer numlay je dole
%choose random layer from 1 to numlay
I = randi(numlay,numgen,1);

for j= 1:numgen
    

    %Transformuji U na (-1,1) kvuli symetrii hustoty kolem 0
    candidate(j) = (2*U(j,1)-1)*r(I(j)+1);

    %Q: Lezi candidate v obdelniku?
    %pro layer 1 se nikdy prvni if neuskutecni
    if abs(candidate(j)) < r(I(j)) 
        candidate(j);
    
    %Pokud jsem v base strip A ZAROVEN nelezim v obdelniku
    elseif I(j) == numlay 
        candidate(j) = fallback(r,numlay);
    
    %Pokud nelezim v obdelniku a nejsem v layer numlay
    else 
        dummy = R(I(j)+1) +U(j,2)*(R(I(j)) - R(I(j)+1));
        if dummy < f(candidate(j))
            candidate(j);
        else
        %zamitaci pravidlo
        candidate(j)=nan;
        end
     
    end

end


%zamitaci pravidlo cast 2
candidate(find(isnan(candidate)))=[];

%Q: Mam pozadovany pocet cisel?
if length(candidate) == numgen
    return
else 
    %Volam stejnou funkci, ale s jinym poctem candidatu
    candidate = [candidate;Zikkurat(numgen-length(candidate),numlay)];
end

end