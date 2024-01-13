function [Tailrealization] = fallback(r,numlay)
%Fallback algorithm for the tail
%Pokud se trefim do spodního layeru mimo obdélník
%tak se uskuteèní fallback, tedy pravidlo, jestli
%jsem pod køivkou nebo nad
%vystup je realizace z tail


while true == 1
    %viz Marsaglia
    candidate = -log(rand)/r(numlay); 
    %specialne pro Normal
    dummy = -log(rand); 
    if 2*dummy > candidate^2
        Tailrealization = candidate +r(numlay);
    break
    
    end
end
%Hustota je symetricka kolem 0, vybiram doleva/doprava
if rand < 0.5
    Tailrealization = -1*Tailrealization;
end

end