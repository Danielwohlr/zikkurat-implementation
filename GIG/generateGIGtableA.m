
%r jsou x souradnice, R jsou y souradnice, v je obsah obdelnika
%f je predpis pro funkci na intervalu (0,argmax)

function [r,R,v,f] = generateGIGtableA(argmax,a,C)

r(129) = argmax;
R(128) = 0.003565; %Pokus omylem zjistena hodnota pro n =128
v = r(129)*R(128);
f = @(x) C*(argmax-x).^5.*exp(-1./(argmax-x)-a/2.*(argmax-x));
for i=1:127
    to_solve = @(x) f(x) - R(129-i);
    r(129-i) = fzero(to_solve,[0 argmax]);
    R(128-i) = v/r(129-i) + R(129-i);
end

%Round-off error, tj R(1) = f1(argmax)
R(1) = 1.2279; 

%kvuli if/else kompaktnosti zapisu
R(129) = 0; 
end