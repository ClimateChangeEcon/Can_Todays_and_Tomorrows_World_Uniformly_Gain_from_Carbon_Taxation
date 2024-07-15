
%%%accuracy

epsilonR=0.001*OilR;
K_steady_guess=K0;
x=[returnperyear pe0 Ky0 Ks0 Ly0 Ls0 S0 w0 z0 Y0 ED0+S0]';
Cons_steady=zeros(1,Gen_Number,NRegions);
TDiscount_steady=zeros(1,Gen_Number);
UDiscount_steady=zeros(1,Gen_Number);
Assets_steady=zeros(1,Gen_Number,NRegions);

for Tsteady=1:Tlast
epsilonsteady=K0*exp(gY(1,1)*(Tsteady-1))*1e-5;
err=10*epsilonsteady;

Baux=B(Tsteady,:); 
Aaux=A(Tsteady,:);
OT=OutputTrend(Tsteady);
ST=STrend(Tsteady);
Laux=L(Tsteady,:);
ED0aux=0;%ED0;


options = optimoptions('fmincon','Algorithm','interior-point', 'MaxFunEvals', 3000000,'MaxIter', 3000000,'StepTolerance',1e-40,'Display','off');
options = optimoptions(options,'GradObj','on','GradConstr','on','Hessian','user-supplied','HessFcn',@hessianfcnsteady);
%K_steady_guess=0.5*K_steady_guess; 
while err>epsilonsteady
Kaux=K_steady_guess;  
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@fun,x,[],[],[],[],[],[],@nontradablesolvefminconsteady, options);
lenx=length(x);
r_steady =x(1);
Xmatrix=reshape(x(2:lenx),NRegions,10)';
pe_steady =Xmatrix(1,:);
Ky_steady =Xmatrix(2,:);
Ks_steady =Xmatrix(3,:);
Ly_steady =Xmatrix(4,:);
Ls_steady =Xmatrix(5,:);
S_steady =Xmatrix(6,:);
w_steady =Xmatrix(7,:);
z_steady =Xmatrix(8,:);
Y_steady =Xmatrix(9,:);
E_steady =Xmatrix(10,:);

Q_steady=1/(1+r_steady-exp(gY_ss))*z_steady.*H;


%%%%%New capital supply function in the case of existence of a lot of
%%%%%generations
TDiscount_steady(1)=1;
UDiscount_steady(1)=1;
for i=2:Gen_Number
   TDiscount_steady(i)=TDiscount_steady(i-1)/(1+r_steady)*exp(gY_ss);
   UDiscount_steady(i)=UDiscount_steady(i-1)*((1+r_steady)/(1+rho))^(1/sigma)/(1+r_steady);
end
for j=1:NRegions
Cons_steady(1,1,j)=w_steady(j)*sum(EP.*TDiscount_steady.*POP(Tsteady,:,j))/sum(UDiscount_steady.*POP(Tsteady,:,j));
end
%Assets_steady(2)=(EP(1)*w_steady-Cons_steady(1));
for i=2:Gen_Number
   Cons_steady(1,i,:)=Cons_steady(1,i-1,:)*((1+r_steady)/(1+rho))^(1/sigma);
   for j=1:NRegions
   Assets_steady(1,i,j)=(1+r_steady)*Assets_steady(1,i-1,j)+POP(Tsteady,i-1,j)*EP(i-1)*w_steady(j)*exp(gY_ss*(i-2))-POP(Tsteady,i-1,j)*Cons_steady(1,i-1,j);
   end
end
for i=2:Gen_Number
   Cons_steady(1,i,:)=Cons_steady(1,i,:)/exp(gY_ss*(i-1)); 
   Assets_steady(1,i,:)=Assets_steady(1,i,:)/exp(gY_ss*(i-1));
end
%K_supply_ss=sum(sum(POP(Tsteady,:,:).*Assets_steady(1,:,:)))-sum(Q_steady);
 K_supply_ss=sum(sum(Assets_steady(1,:,:)))-sum(Q_steady);
auxvar=K_steady_guess;
K_steady_guess=0.9*K_steady_guess+0.1*K_supply_ss;

if Tsteady>1
K(Tsteady)=K_steady_guess;
end

err=abs(K_steady_guess-auxvar);
end


end
K_steady=K_steady_guess;
r_steady_peryear=(1+r_steady)^(1/tstep)-1;