clc
clear variables

%pocet generovanych cisel
dimgen = 1000000;
%number of layers of Zikkurat
numlay=666;

candidate = Zikkurat(dimgen,numlay);



% Graficke znazorneni cdf
 g = -3:0.01:3;
 histogram(candidate,'Normalization','pdf')
 hold on
 plot(g,normpdf(g))

%% Testy hypotez
%[h,p,k,c] = lillietest(candidate) 
%[h,p,ksstat,cv] = kstest(candidate)
%pd = makedist('Normal');
%[h,p,stats] = chi2gof(candidate,'CDF',pd)

