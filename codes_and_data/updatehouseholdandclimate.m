Utility_BAU_steady=zeros(1,NRegions);
     Eland=zeros(size(Oil));  
     FORCEX=zeros(size(Oil)); 
for t=1:Tlast-1
     Eland(t)=0.709*exp(-0.023*(t-1));
     FORCEX(t)=0.5+1/85*(1-0.5)*min(t,85);
     auxxx=PHIM*[MAT(t); MU(t); ML(t)]+[(Oil(t)+Gas(t)+Coal(t))*(1/3.666)+Eland(t);0;0];
     MAT(t+1)= auxxx(1);
     ML(t+1)= auxxx(3);
     MU(t+1)= auxxx(2);
     FORC(t)= fco22x * ((log((MAT(t)/mateq))/log(2)))+FORCEX(t); 
     auxxx=PHIT*[TATM(t);TOCEAN(t)]+[ksi1*FORC(t);0];
     TATM(t+1)= auxxx(1);
     TOCEAN(t+1) = auxxx(2);
end



temstep=0:0.1:7.6;
Tempgrid=zeros(18,length(temstep));
i=0;
for temstep=0:0.1:7.6
    i=i+1;
%Taux=readtable('temp_region_0.95.csv');

Taux=readtable(cat(2,'temp_region_W_',num2str(temstep),'.csv'));

Taux=table2array(Taux(2:19,3));

Tempgrid(1,i)=Taux(17);
Tempgrid(2,i)=Taux(18);
Tempgrid(3,i)=Taux(8);
Tempgrid(4,i)=Taux(4);
Tempgrid(5,i)=Taux(7);
Tempgrid(6,i)=Taux(11);
Tempgrid(7,i)=Taux(3);
Tempgrid(8,i)=Taux(5);
Tempgrid(9,i)=Taux(13);
Tempgrid(10,i)=Taux(2);
Tempgrid(11,i)=Taux(10);
Tempgrid(12,i)=Taux(12);
Tempgrid(13,i)=Taux(9);
Tempgrid(14,i)=Taux(14);
Tempgrid(15,i)=Taux(16);
Tempgrid(16,i)=Taux(15);
Tempgrid(17,i)=Taux(6);
Tempgrid(18,i)=Taux(1);
end
temstep=0:0.1:7.6; 
Treg=zeros(Tlast,NRegions);
Tregdeviation=zeros(Tlast,NRegions);
DT=zeros(size(Damages));
D0=zeros(1,18);
for i=1:NRegions
    Treg(:,i)=spline(temstep',Tempgrid(i,:)',TATM);
    DT(:,i)=0.02+0.98*((sign(Treg(:,i)-Tempprime)+1)/2.*exp(-kplus*(Treg(:,i)-Tempprime).^2)+(sign(-Treg(:,i)+Tempprime)+1)/2.*exp(-kminus*(Treg(:,i)-Tempprime).^2));
    D0(i)=0.02+0.98*((sign(Tempgrid(i,1)'-Tempprime)+1)/2.*exp(-kplus*(Tempgrid(i,1)'-Tempprime).^2)+(sign(-Tempgrid(i,1)'+Tempprime)+1)/2.*exp(-kminus*(Tempgrid(i,1)'-Tempprime).^2));
    Damages(:,i)=1-DT(:,i)/D0(i);
end


% if globaliterate==1
%     Aprevius=A;
%     t=0:Tlast-1;t=t'; 
%     A=0.9*Aprevius+0.1*(1-Damages).*Ainit;
%     errA=max(abs(Aprevius-A)./Ainit)
% else
%     if err0<0.15
    Aprevius=A;
    t=0:Tlast-1;t=t'; 
    A=0.9*Aprevius+0.1*(1-Damages).*Ainit;
    errA=max(abs(Aprevius-A)./Ainit)
%     end
% end


    %%%%%%%%%%%%find steady state with new technology 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Baux=B(Tlast,:); 
Aaux=A(Tlast,:);
OT=OutputTrend(Tlast);
ST=STrend(Tlast);
Laux=L(Tlast,:);
    err=10*epsilonsteady;
x=[r_steady pe_steady Ky_steady Ks_steady Ly_steady Ls_steady S_steady w_steady z_steady Y_steady S_steady]';
options = optimoptions('fmincon','Algorithm','interior-point', 'MaxFunEvals', 3000000,'Display','off','StepTolerance',1e-20,'MaxIter', 3000000);%,'StepTolerance',1e-20);
options = optimoptions(options,'GradObj','on','GradConstr','on','Hessian','user-supplied','HessFcn',@hessianfcnsteady);

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
Cons_steady(1,1,j)=w_steady(j)*sum(EP.*TDiscount_steady.*POP(Tlast,:,j))/sum(UDiscount_steady.*POP(Tlast,:,j));
end
%Assets_steady(2)=(EP(1)*w_steady-Cons_steady(1));

for i=2:Gen_Number
   Cons_steady(1,i,:)=Cons_steady(1,i-1,:)*((1+r_steady)/(1+rho))^(1/sigma);
   for j=1:NRegions
   Assets_steady(1,i,j)=(1+r_steady)*Assets_steady(1,i-1,j)+POP(Tlast,i-1,j)*EP(i-1)*w_steady(j)*exp(gY_ss*(i-2))-POP(Tlast,i-1,j)*Cons_steady(1,i-1,j);
   end
end
for j=1:NRegions
Utility_BAU_steady(j)=UD*((((Cons_steady(1,:,j)').^(1-sigma)-1))/(1-sigma).*POP(Tlast,:,j)');
end
for i=2:Gen_Number
   Cons_steady(1,i,:)=Cons_steady(1,i,:)/exp(gY_ss*(i-1)); 
   Assets_steady(1,i,:)=Assets_steady(1,i,:)/exp(gY_ss*(i-1));
end
%K_supply_ss=sum(sum(POP(Tlast,:,:).*Assets_steady(1,:,:)))-sum(Q_steady);
 K_supply_ss=sum(sum(Assets_steady(1,:,:)))-sum(Q_steady);
auxvar=K_steady_guess;
K_steady_guess=0.9*K_steady_guess+0.1*K_supply_ss;
err=abs(K_steady_guess-auxvar);
end

K_steady=K_steady_guess;
K(Tlast)=K_steady;
r(Tlast+1:Tlast+Gen_Number-1,1)=zeros(size(r(Tlast+1:Tlast+Gen_Number-1,1)))+r_steady;
w(Tlast,:)=w_steady;
Cons(Tlast,:,:)=Cons_steady;
for j=Tlast+1:Tlast+Gen_Number-1
    w(j,:)=w(j-1,:)*exp(gY_ss);
    Cons(j,:,:)=Cons(j-1,:,:)*exp(gY_ss);
end
    %%%%%%%%%%%%finish of finding steady state with new technology
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Q(Tlast,:)=Q_steady;
VOil(Tlast)=0;
VCoal(Tlast)=0;
VGas(Tlast)=0;
for t=Tlast-1:-1:1
    Q(t,:)=z(t,:).*H/(1+r(t))+Q(t+1,:)/(1+r(t));
    VOil(t)=(po(t)-(Oilcostparameter1+Oilcostparameter2*(OilR-OilReserves(t))+Oilcostparameter3*(OilR-OilReserves(t)).^2+Oilcostparameter4*(OilR-OilReserves(t)).^3+1./OilReserves(t)))*Oil(t)/(1+r(t))+VOil(t+1)/(1+r(t));
    VGas(t)=(pg(t)-(Gascostparameter1+Gascostparameter2*(GasR-GasReserves(t))+Gascostparameter3*(GasR-GasReserves(t)).^2+Gascostparameter4*(GasR-GasReserves(t)).^3+1./GasReserves(t)))*Gas(t)/(1+r(t))+VGas(t+1)/(1+r(t));
    VCoal(t)=(pc(t)-(Coalcostparameter1+Coalcostparameter2*(CoalR-CoalReserves(t))+Coalcostparameter3*(CoalR-CoalReserves(t)).^2+Coalcostparameter4*(CoalR-CoalReserves(t)).^3+1./CoalReserves(t)))*Coal(t)/(1+r(t))+VCoal(t+1)/(1+r(t));
    transfersperregion(t,:)=(OR(t,:)/OiltoBTU+CR(t,:)/GastoBTU+GR(t,:)/CoaltoBTU).*taxR(t,:);
    %tax(t)*Oil(t)/Gen_Number+tax(t)*Coal(t)/Gen_Number+tax(t)*Gas(t)/Gen_Number;
end
%%%POP time generation region
for t=1:Tlast
    for ii=1:Gen_Number
        for jj=1:NRegions
        transfers(t,ii,jj)=transfersperregion(t,jj)/sum(POP(t,:,jj));%Трансферт в регионе jj для ii когорты есть весь трансферт, делить на численность населения
        end
    end
end
%%%%%%Calculate consumption and capital supply
for t=1:Tlast
    TDiscount(t,1)=1;
    UDiscount(t,1)=1;
    for i=2:Gen_Number
    TDiscount(t,i)=TDiscount(t,i-1)/(1+r(t+i-1));
    UDiscount(t,i)=UDiscount(t,i-1)*((1+r(t+i-1))/(1+rho))^(1/sigma)/(1+r(t+i-1));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%
for jj=1:NRegions
for t=1:Tlast
    %Cons_steady(1,1,j)=w_steady(j)*sum(EP.*TDiscount_steady.*POP(Tlast,:,j))/sum(UDiscount_steady.*POP(Tlast,:,j));
    Cons(t,1,jj)=sum(w(t:t+Gen_Number-1,jj)'.*diag(POP(t:t+Gen_Number-1,:,jj))'.*EP.*TDiscount(t,:))/sum(UDiscount(t,:).*diag(POP(t:t+Gen_Number-1,:,jj))')+sum(diag(transfers(t:t+Gen_Number-1,:,jj))'.*diag(POP(t:t+Gen_Number-1,:,jj))'.*TDiscount(t,:))/sum(UDiscount(t,:).*diag(POP(t:t+Gen_Number-1,:,jj))');
end


Assets(1,:,jj)=Shares_steady(1,:,jj)*(K(1)+sum(Q(1,:))+VOil(1)+VCoal(1)+VGas(1)); %%%%%%%%%%%%%%%%
Cons(1,Gen_Number,jj)=(1+r(1))*Assets(1,Gen_Number,jj)./POP(1,Gen_Number,jj)+transfers(1,Gen_Number,jj);
for i=2:Gen_Number-1
    Cons(1,i,jj)=((1+r(1))*Assets(1,i,jj)+sum(w(1:1+Gen_Number-i,jj)'.*diag(POP(1:1+Gen_Number-i,i:Gen_Number,jj))'.*EP(i:Gen_Number).*TDiscount(1,1:Gen_Number-i+1)))/sum(UDiscount(1,1:Gen_Number-i+1).*diag(POP(1:1+Gen_Number-i,i:Gen_Number,jj))')+sum(diag(transfers(1:Gen_Number-i+1,i:Gen_Number,jj))'.*diag(POP(1:1+Gen_Number-i,i:Gen_Number,jj))'.*TDiscount(1,1:Gen_Number-i+1))/sum(UDiscount(1,1:Gen_Number-i+1).*diag(POP(1:1+Gen_Number-i,i:Gen_Number,jj))');
end

for t=1:Tlast-1
    for i=1:Gen_Number-1
    Cons(t+1,i+1,jj)= Cons(t,i,jj)*((1+r(t+1))/(1+rho))^(1/sigma);   
    Assets(t+1,i+1,jj)=(1+r(t))*Assets(t,i,jj)+(EP(i)*w(t,jj)-Cons(t,i,jj)+transfers(t,i,jj))*POP(t,i,jj);
    end
end

end
Kprevious=K;
%%%%%%%
for t=1:Tlast-1
    K_supply(t+1)=sum(sum(Assets(t+1,:,:)))-sum(Q(t+1,:))-VOil(t+1)-VCoal(t+1)-VGas(t+1);
    K(t+1)=0.985*K(t+1)+0.015*K_supply(t+1);
end
err0=max(abs((K(2:Tlast-1)-K_supply(2:Tlast-1))./OutputTrend(2:Tlast-1)));
targets=[err0 kplus]



for t=Tlast:-1:TlastConopt+1
    Kaux=K(t); 
    Baux=B(t,:); 
    Aaux=A(t,:);
    OT=OutputTrend(t);
    ST=STrend(t);
    Laux=L(t,:);
    %t
    [x,FVAL,EXITFLAG,OUTPUT] = fmincon(@fun,x,[],[],[],[],[],[],@nontradablesolvefminconsteady, options);
lenx=length(x);
r(t) =x(1);
Xmatrix=reshape(x(2:lenx),NRegions,10)';
pe(t,:) =Xmatrix(1,:);
Ky(t,:) =Xmatrix(2,:);
Ks(t,:) =Xmatrix(3,:);
Ly(t,:) =Xmatrix(4,:);
Ls(t,:) =Xmatrix(5,:);
S(t,:) =Xmatrix(6,:);
w(t,:) =Xmatrix(7,:);
z(t,:) =Xmatrix(8,:);
Y(t,:) =Xmatrix(9,:);
E(t,:) =Xmatrix(10,:);
end
for t=TlastConopt+1:Tlast
CoalReserves(t)=CoalReserves(t-1);
OilReserves(t)=OilReserves(t-1);
GasReserves(t)=GasReserves(t-1);
end 



    
