function [q,Q,w,g] = generateGIGtableB(argmax,a)
%skalovaci konst. hustoty
C=sqrt(a^6)/16/besselk(6,sqrt(2*a));

%pro x >0
g = @(x) C*(x+argmax).^5.*exp(-1./(x+argmax)-a/2.*(x+argmax)); 
%pocatecni x, specialni, pokus-omylem zjistena hodnota aby to vychazelo
q(256) = 1.90661;
%g(0)
Q(256) = g(q(256)); 

%pouze kvuli vypoctu P_to_tail
f1 = @(x) C*x.^5.*exp(-1./x-a/2.*x);

%dummy promena k vypoctu tail
dummy_tail= 0:0.01: (argmax+q(256));
%krok v integraci ve vypoctu GIG tailu
dx = 0.01;

P_to_tail = cumsum(f1(dummy_tail))*dx;
tail = 1-P_to_tail(end); 

%Area of each rectangular = w
w = Q(256)*q(256) + tail;

for i = 1: 255
    %kazdy rectangle ma stejny obsah
    Q(256-i) = w/q(257-i) + Q(257-i); 
    to_solve = @(x) g(x) - Q(256-i);
    %predpis pro hledani inverze
    q(256-i) = fzero(to_solve,[0 q(256)]);
    
end
%Round-off error (after sanity test!)
q(1) = 0; 
%kvuli Fallback algorithm
q(257) = w/Q(256); 
end
