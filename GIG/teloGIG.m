function [candidate,f1] = teloGIG(dimgen)
% tato funkce mi nejdriv predpocita ruzne konstanty, volam
%v ni generovani tabulek A a B, dale volanim realizuji generovani
%v kridle A a pote ve for-cyklu generuji v kridle B 
%vysledek pak spojim do jedne array s nazvem candidate


%GIG s parametry p = 6, b = 2, a = 14.2655, \mu_1 = 1,
%argmax je kde GIG nabyva maxima
argmax = 0.8634; 
%parametr hustoty
a = 14.2655;
%skalovaci konst. hustoty
C=sqrt(a^6)/16/besselk(6,sqrt(2*a)); 
%Predpis GIG hustoty s predepsanymi parametry
f1 = @(x) C*x.^5.*exp(-1./x-a/2.*x);

%% Zjisteni cdf_GIG(argmax)
%odkud kam chci integrovat GIG
cdfx= 0:0.01: argmax;
%krok v integraci GIGu
DX = 0.01;
%A(end) = cdf_GIG(argmax) = 0.3912
A = cumsum(f1(cdfx))*DX; 

%% nagenerovani tabulek
[r,R,~,f] = generateGIGtableA(argmax,a,C);
[q,Q,~,g] = generateGIGtableB(argmax,a);

%dimgen cisel z U(0,1)
ABDecision = rand(dimgen,1); 

%kolik cisel budu tahat z A, a kolik z B
TUK = find(ABDecision < A(end));

%% Generovani cisel z leveho kridla
[candidate] = realizationsA(length(TUK),r,R,argmax,f);



%% Generovani cisel z praveho kridla
candidate1 = nan(dimgen-length(TUK),1)';
U = rand(dimgen-length(TUK),2);
I = randi(256,dimgen-length(TUK),1);

for j = 1: dimgen-length(TUK)
    
    candidate1(j) = U(j,1)*q(I(j)+1);

    if candidate1(j) < q(I(j))
        candidate1(j) = argmax + candidate1(j);
    elseif I(j) ==256
        candidate1(j) = argmax + fallback(q);
    else
        dummy = Q(I(j)+1) +U(j,2)*(Q(I(j))-Q(I(j)+1));
        if dummy < g(candidate1(j))
            candidate1(j) = argmax+ candidate1(j);
        else
            candidate1(j)= nan;
        end
    end
end

%Sloucim leve a prave kridlo
candidate = [candidate candidate1];
%Vymazu zamitnute candidaty
candidate(find(isnan(candidate) ))=[];

%Q: Mám požadovany pocet generovanych cisel?
if length(candidate) == dimgen
    return
else
    candidate = [candidate teloGIG(dimgen-length(candidate))];
end

end