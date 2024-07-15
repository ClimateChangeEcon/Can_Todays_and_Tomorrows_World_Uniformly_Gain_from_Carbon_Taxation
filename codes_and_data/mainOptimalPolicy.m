load BAU;
computeSCC;
SCCglob=sum(SCC,2)/1000;


errtax=1;
lambda_low=1.005;
lambda_high=1.007;
while errtax>0.01
%tax=0.9*SCCglob(1:Tlast)+0.1*tax(1:Tlast);
tax=SCCglob;
errlambda=1;
LSRA;

save optimalSCC.mat
lambda_low=lambda-0.0005;
lambda_high=lambda+0.00051;
computeSCC;
SCCglob=sum(SCC,2)/1000;
errtax=max(abs((SCCglob(1:TlastConopt)./tax(1:TlastConopt)-1)))
end

save optimalSCC.mat
