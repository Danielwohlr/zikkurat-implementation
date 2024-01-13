function [r,R,v,f] = generateTable(numlay)
%Generating Table for n = numlay layers
%vystup: r odpovida x, R odpovida y, v je obsah obdelniku,...
%f je hustota bez normalizacnich konstant
f = @(x) exp(-x.^2 / 2);


%Pocet obdelniku
n=numlay;
%muj guess... pro numlay mezi 50-5000 je spravna hodnota mezi 3 a 5
x_guess= 5; 

%najdu idealni r(numlay), ktere mi da spravny zikkurat
myfun = @(x) abs(bisekce(x)-f(0));
x = fminsearch(myfun,x_guess)

%% vytvorim prislusny zikkurat
r=nan(n,1);
R=nan(n,1);
r(n) = x;
%f(r(n))
R(n) = f( r(n));

%specific Gauss tail
tail = sqrt(pi/2)*erfc(r(n)/sqrt(2)); 
%obsah obdelniku
v = R(n)*r(n) + tail;

for i = 1: n-1
    %kazdy rectangle ma stejny obsah
    R(n-i) = v/r(n-i+1) + R(n-i+1); 
    %predpis pro hledani inverze
    r(n-i) = sqrt(-2*log(v/r(n-i+1) + R(n-i+1))) ; 
end

%round-off error
 r(1) = 0; 


%Kvuli Fallback algorithm
r(n+1) = v/R(n); 

%% Funkce na nalezeni r(numlay)
function bis = bisekce(x)
    r=nan(n,1);
    R=nan(n,1);
    r(n) = x;
    %f(r(n))
    R(n) = f( r(n));

    %specific Gauss tail
    tail = sqrt(pi/2)*erfc(r(n)/sqrt(2)); 
    %obsah obdelniku
    v = R(n)*r(n) + tail;

    for i = 1: n-1
        %kazdy rectangle ma stejny obsah
        R(n-i) = v/r(n-i+1) + R(n-i+1); 
        %predpis pro hledani inverze
        r(n-i) = sqrt(-2*log(v/r(n-i+1) + R(n-i+1))) ; 
    end
    bis = R(1);
end

end