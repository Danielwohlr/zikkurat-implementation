function [TailRealization] = fallback(q)
    %% Vypocet CCDF
    a = 14.2655;

    %skalovaci konst. hustoty
    C=sqrt(a^6)/16/besselk(6,sqrt(2*a)); 

    %Predpis GIG hustoty s predepsanymi parametry
    f1 = @(x) C*x.^5.*exp(-1./x-a/2.*x);
    cdfx= 0:0.0001: 3.1;

    %krok v integraci GIGu
    DX = 0.0001;

    %A = ccdf
    mojeccdf = 1- cumsum(f1(cdfx))*DX; 

    %s alias q(257) a.k.a zacatek tailu
    %s = 1.90661;
    
    %% Nalezeni realizace
    %hledam takov� x, �e ccdf(x) = Rand*ccdf(s)

    n=rand*(mojeccdf(19066));
    [val,idx]=min(abs(mojeccdf-n));
    TailRealization=idx*DX;

end