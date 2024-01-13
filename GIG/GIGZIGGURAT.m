clc
clear variables

%Kolik chci generovat cisel z GIG
dimgen = 1000000;

%candidate jsou realizace
%f1 je hustota GIG
[candidate,f1] = teloGIG(dimgen);

%% Zkouška
histogram( candidate ,'Normalization','pdf')
hold on
x1= 0:0.01:4;
plot(x1,f1(x1))
xlim([0 3])
ylim([0 1.4])

%% Pearsonùv test
% numbins = 100;
% prob=nan(numbins,1);
% exp=nan(numbins,1);
% edges=nan(numbins,1);
% 
% for j = 1:numbins
%     edges(j)=max(candidate)/numbins*(j-1);
% end
% edges(numbins+1)=max(candidate);
% 
% 
% for j = 1:numbins
%     prob(j) = integral(f1,edges(j),edges(j+1));
%     exp(j) = dimgen*prob(j);
% end
% 
% 
% [h,p,stats] = chi2gof(candidate,'Edges',edges,'Expected',exp)
