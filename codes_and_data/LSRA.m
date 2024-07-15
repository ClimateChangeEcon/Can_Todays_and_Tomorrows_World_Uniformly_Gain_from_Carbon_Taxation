TaxCap=0.9;
epsilonK=0.0005*K0;%0.0005*K0;
LSRAtransferY=zeros(Tlast,1,NRegions); %%Transfer to young generations at time t
LSRAtransferO=zeros(1,Gen_Number,NRegions); %%Transfer to old generations at time 1/// assume that LSRAtransferO(1,1)=0
totaltransferfromLSRA=zeros(Tlast,Gen_Number,NRegions);
Debt=zeros(Tlast,1);
Hsquare=zeros(Tlast,1);

PVC=zeros(size(Utilityb));
PVCfirst=zeros(size(Utility_T1b));
for j=1:NRegions
for i=1:Tlast
   PVC(i,1,j)=TDiscount(i,:)*(((diag(Consb(i:i+Gen_Number-1,:,j)))).*diag(POP(i:i+Gen_Number-1,:,j)));
end
for i=1:Gen_Number
    PVCfirst(1,i,j)=TDiscount(1,1:Gen_Number-i+1)*(((diag(Consb(1:Gen_Number-i+1,i:Gen_Number,j)))).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
end
end


%%%%%%%%%%%%begin iteration on lambda
%lambda_low=1.0089;
%lambda_high=1.0115;
errlambda=1;

while errlambda>0.001
%    errlambda=0.000000000001;
%    figure
    lambda=(lambda_low+lambda_high)/2
    Tlambda=ones(Tlast,1,NRegions)*lambda;
    T1lambda=ones(1,Gen_Number,NRegions)*lambda;
    Utility_T1LSRA=zeros(1,Gen_Number,NRegions);
    Utility_LSRA=zeros(Tlast,1,NRegions);
    Utility_LSRA_steady=zeros(size(Utility_BAU_steady));
    %Utility_LSRA=Utilityb+log(lambda)*sum(UDiscount);
    for j=1:NRegions
        for i=1:Tlast
        Utility_LSRA(i,1,j)=(Tlambda(i,1,j).^(1-sigma).*(Utilityb(i,1,j).*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))-UD*diag(POP(i:i+Gen_Number-1,:,j)))/(1-sigma);
        end
    Utility_LSRA_steady(j)=(lambda^(1-sigma)*(Utility_BAU_steady(j)*(1-sigma)+UD*diag(POP(Tlast:Tlast+Gen_Number-1,:,j)))-UD*diag(POP(Tlast:Tlast+Gen_Number-1,:,j)))/(1-sigma);
    for i=1:Gen_Number    
        Utility_T1LSRA(1,i,j)=(T1lambda(1,i,j)^(1-sigma)*(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))-UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(1-sigma);
    end
    end
    err0=1000;   
   
%for Kiter=1:10
%    Kiter
while err0>epsilonK
    %%%%%%%%%%%%find steady state with new technology 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
r(Tlast+1:Tlast+Gen_Number-1,1)=zeros(size(r(Tlast+1:Tlast+Gen_Number-1,1)))+r(Tlast);
 for j=Tlast+1:Tlast+Gen_Number-1
    w(j,:)=w(j-1,:)*exp(gY_ss);
    Cons(j,:,:)=Cons(j-1,:,:)*exp(gY_ss);
end
Q(Tlast,:)=1/(1+r(Tlast)-exp(gY_ss))*z(Tlast,:).*H; 
VOil(Tlast)=0;
VCoal(Tlast)=0;
VGas(Tlast)=0;
for t=Tlast-1:-1:1
    Q(t,:)=z(t,:).*H/(1+r(t))+Q(t+1,:)/(1+r(t));
    VOil(t)=(po(t)-(Oilcostparameter1+Oilcostparameter2*(OilR-OilReserves(t))+Oilcostparameter3*(OilR-OilReserves(t)).^2+Oilcostparameter4*(OilR-OilReserves(t)).^3+1./OilReserves(t)))*Oil(t)/(1+r(t))+VOil(t+1)/(1+r(t));
    VGas(t)=(pg(t)-(Gascostparameter1+Gascostparameter2*(GasR-GasReserves(t))+Gascostparameter3*(GasR-GasReserves(t)).^2+Gascostparameter4*(GasR-GasReserves(t)).^3+1./GasReserves(t)))*Gas(t)/(1+r(t))+VGas(t+1)/(1+r(t));
    VCoal(t)=(pc(t)-(Coalcostparameter1+Coalcostparameter2*(CoalR-CoalReserves(t))+Coalcostparameter3*(CoalR-CoalReserves(t)).^2+Coalcostparameter4*(CoalR-CoalReserves(t)).^3+1./CoalReserves(t)))*Coal(t)/(1+r(t))+VCoal(t+1)/(1+r(t));
    transfersperregion(t,:)=(OR(t,:)/OiltoBTU+CR(t,:)/GastoBTU+GR(t,:)/CoaltoBTU).*taxR(t,:);
end
for t=1:Tlast
    for ii=1:Gen_Number
        for jj=1:NRegions
        transfers(t,ii,jj)=transfersperregion(t,jj)/sum(POP(t,:,jj));
        end
    end
end

%%%%%%Calculate consumption and capital supply
for t=1:Tlast
    TDiscount(t,1)=1;
    UDiscount(t,1)=1;
    NewDiscountforUtility(t,1)=1;

    for i=2:Gen_Number
    TDiscount(t,i)=TDiscount(t,i-1)/(1+r(t+i-1));
    UDiscount(t,i)=UDiscount(t,i-1)*((1+r(t+i-1))/(1+rho))^(1/sigma)/(1+r(t+i-1));
    NewDiscountforUtility(t,i)=NewDiscountforUtility(t,i-1)/(1+rho)*((1+r(t+i-1))/(1+rho))^(1/sigma-1);
    end
end

PIH=zeros(Tlast,1,NRegions);
PIHT1=zeros(1,1,NRegions);
for j=1:NRegions
Assets(1,:,j)=Shares_steady(1,:,j)*(K(1)+sum(Q(1,:))+VOil(1)+VCoal(1)+VGas(1)); %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%Begin hear to specify utility and LSRA transfers
%            PIH_steady(1,1,j)=Cons_steady(1,1,j)*(UDiscount_steady*diag(POP(Tlast:Tlast+Gen_Number-1,:,j)));
%             Cons_steady(1,1,j)=((Utility_LSRA_steady(j)*(1-sigma)+UD*diag(POP(Tlast:Tlast+Gen_Number-1,:,j)))/(NewDiscountforUtility_steady*diag(POP(Tlast:Tlast+Gen_Number-1,:,j))))^(1/(1-sigma));
%            LSRAtransferY_steady(1,1,j)=PIH_steady(1,1,j)-w_steady(j)*((EP.*TDiscount_steady)*diag(POP(Tlast:Tlast+Gen_Number-1,:,j)));


for t=1:Tlast
    Cons(t,1,j)=((Utility_LSRA(t,1,j)*(1-sigma)+UD*diag(POP(t:t+Gen_Number-1,:,j)))/(NewDiscountforUtility(t,:)*diag(POP(t:t+Gen_Number-1,:,j)))).^(1/(1-sigma));
    PIH(t,1,j)=Cons(t,1,j)*UDiscount(t,:)*diag(POP(t:t+Gen_Number-1,:,j));
    LSRAtransferY(t,1,j)=PIH(t,1,j)-w(t:t+Gen_Number-1,j)'.*EP.*TDiscount(t,:)*diag(POP(t:t+Gen_Number-1,:,j))-sum(diag(transfers(t:t+Gen_Number-1,:,j))'.*diag(POP(t:t+Gen_Number-1,:,j))'.*TDiscount(t,:));
    if LSRAtransferY(t,1,j)<-TaxCap*PVC(t,1,j)
       LSRAtransferY(t,1,j)=-TaxCap*PVC(t,1,j);
       Cons(t,1,j)=LSRAtransferY(t,1,j)/sum(UDiscount(t,:).*diag(POP(t:t+Gen_Number-1,:,j))')+sum(w(t:t+Gen_Number-1,j)'.*diag(POP(t:t+Gen_Number-1,:,j))'.*EP.*TDiscount(t,:))/sum(UDiscount(t,:).*diag(POP(t:t+Gen_Number-1,:,j))')+sum(diag(transfers(t:t+Gen_Number-1,:,j))'.*diag(POP(t:t+Gen_Number-1,:,j))'.*TDiscount(t,:))/sum(UDiscount(t,:).*diag(POP(t:t+Gen_Number-1,:,j))');
       PIH(t,1,j)=Cons(t,1,j)*UDiscount(t,:)*diag(POP(t:t+Gen_Number-1,:,j));
    end

end %%%done!!!!
%    Utility_T1p(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Consp(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
%    LAMBDA_T1p(1,i,j)=(((Utility_T1p(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j))))^(1/(1-sigma))-1)*100;

for i=2:Gen_Number
    Cons(1,i,j)=((Utility_T1LSRA(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(NewDiscountforUtility(1,1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))).^(1/(1-sigma));
    PIHT1(1,i,j)=Cons(1,i,j)*UDiscount(1,1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j));
    LSRAtransferO(1,i,j)=PIHT1(1,i,j)-(1+r(1))*Assets(1,i,j)-sum(w(1:1+Gen_Number-i,j)'.*diag(POP(1:1+Gen_Number-i,i:Gen_Number,j))'.*EP(i:Gen_Number).*TDiscount(1,1:Gen_Number-i+1))-sum(diag(transfers(1:Gen_Number-i+1,i:Gen_Number,j))'.*diag(POP(1:1+Gen_Number-i,i:Gen_Number,j))'.*TDiscount(1,1:Gen_Number-i+1));
end
end
                Debt(Tlast)=sum(LSRAtransferY(Tlast,1,:))/(exp(gY_ss)-1-r(Tlast));
                for t=Tlast-1:-1:2
                    Debt(t)=(Debt(t+1)-sum(LSRAtransferY(t,1,:)))/(1+r(t));
                end
                
Debt0=Debt(2)-sum(LSRAtransferY(1,1,:))-sum(sum(LSRAtransferO(1,2:Gen_Number-1,:)))-sum(LSRAtransferO(1,Gen_Number,2:NRegions))-LSRAtransferO(1,Gen_Number,1);
%Cons(1,Gen_Number,1)=(1+r(1))*Assets(1,Gen_Number,1)/POP(1,Gen_Number,1)+LSRAtransferO(1,Gen_Number,1)/POP(1,Gen_Number,1)+transfers(1,Gen_Number,1);
totaltransferfromLSRA(1,2:Gen_Number,:)=LSRAtransferO(1,2:Gen_Number,:);
totaltransferfromLSRA(1:Tlast,1,:)=LSRAtransferY(1:Tlast,1,:);
for j=1:NRegions
    for i=1:Gen_Number-1
Cons(2:Tlast,i+1,j)= Cons(1:Tlast-1,i,j).*((1+r(2:Tlast))/(1+rho)).^(1/sigma);
Assets(2:Tlast,i+1,j)=(1+r(1:Tlast-1)).*Assets(1:Tlast-1,i,j)+(EP(i)*w(1:Tlast-1,j)-Cons(1:Tlast-1,i,j)+transfers(1:Tlast-1,i,j)).*POP(1:Tlast-1,i,j)+totaltransferfromLSRA(1:Tlast-1,i,j);
    end
end



%%%%%%%
for t=1:Tlast-1
    K_supply(t+1)=sum(sum(Assets(t+1,:,:)))-sum(Q(t+1,:))-VOil(t+1)-VCoal(t+1)-VGas(t+1)-Debt(t+1);
    K(t+1)=0.9*K(t+1)+0.1*K_supply(t+1);
end
%plot(log(K));hold on;
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
     
 %%%%%regional temperature and damages


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

   Aprevius=A;
    t=0:Tlast-1;t=t'; 
    A=0.9*Aprevius+0.1*(1-Damages).*Ainit;
    errA=max(abs(Aprevius-A)./Ainit)

%iteration=iteration+1
x=[r(Tlast) pe(Tlast,:) Ky(Tlast,:) Ks(Tlast,:) Ly(Tlast,:) Ls(Tlast,:) S(Tlast,:) w(Tlast,:) z(Tlast,:) Y(Tlast,:) S(Tlast,:)]';
options = optimoptions('fmincon','Algorithm','interior-point', 'MaxFunEvals', 3000000,'Display','off','StepTolerance',1e-20,'MaxIter', 3000000);%,'StepTolerance',1e-20);
options = optimoptions(options,'GradObj','on','GradConstr','on','Hessian','user-supplied','HessFcn',@hessianfcnsteady);
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

%for t=TlastConopt:-1:1
for t=1:1:TlastConopt
%   t
    Kaux=K(t); 
    Baux=B(t,:); 
    Aaux=A(t,:);
    OT=OutputTrend(t);
    ST=STrend(t);
    Laux=L(t,:);
OilReservesaux=OilReserves(t);
OilLMp1=OilLM(t+1); 
GasReservesaux=GasReserves(t);
GasLMp1=GasLM(t+1);
CoalReservesaux=CoalReserves(t);
CoalLMp1=CoalLM(t+1);
rp1=r(t+1); 
taxaux=tax(t);
taxauxR=taxR(t,:);
GasReservesaux =GasReserves(t);
GasLMp1=GasLM(t+1); 
CoalReservesaux=CoalReserves(t);
CoalLMp1=CoalLM(t+1);
Laux=L(t,:);


% x=[Oil(t+1) OilLM(t+1) Oilmiu(t+1) Gas(t+1) GasLM(t+1) Gasmiu(t+1) Coal(t+1) CoalLM(t+1) Coalmiu(t+1) r(t+1) po(t+1) pg(t+1) pc(t+1) Ky(t+1,:) Ks(t+1,:) Ly(t+1,:) Ls(t+1,:) S(t+1,:) w(t+1,:) z(t+1,:) Y(t+1,:) pe(t+1,:) lamFF(t+1,:) FF(t+1,:) pFF(t+1,:) OR(t+1,:) GR(t+1,:) CR(t+1,:)]';
if t<2
    x=[Oil(t) OilLM(t) Oilmiu(t) Gas(t) GasLM(t) Gasmiu(t) Coal(t) CoalLM(t) Coalmiu(t) r(t) po(t) pg(t) pc(t) Ky(t,:) Ks(t,:) Ly(t,:) Ls(t,:) S(t,:) w(t,:) z(t,:) Y(t,:) pe(t,:) lamFF(t,:) FF(t,:) pFF(t,:) OR(t,:) GR(t,:) CR(t,:)]';
else 
     x=[Oil(t-1) OilLM(t-1) Oilmiu(t-1) Gas(t-1) GasLM(t-1) Gasmiu(t-1) Coal(t-1) CoalLM(t-1) Coalmiu(t-1) r(t-1) po(t-1) pg(t-1) pc(t-1) Ky(t-1,:) Ks(t-1,:) Ly(t-1,:) Ls(t-1,:) S(t-1,:) w(t-1,:) z(t-1,:) Y(t-1,:) pe(t-1,:) lamFF(t-1,:) FF(t-1,:) pFF(t-1,:) OR(t-1,:) GR(t-1,:) CR(t-1,:)]';
end
options = optimoptions('fmincon','Algorithm','interior-point', 'MaxFunEvals', 10000,'MaxIter', 10000,'StepTolerance',1e-10,'Display','off');%, 'MaxFunEvals', 3000000,'MaxIter', 3000000);%,'StepTolerance',1e-10);%,'Display','off');%,'StepTolerance',1e-20);
options = optimoptions(options,'GradObj','on','GradConstr','on','Hessian','user-supplied','HessFcn',@hessianfcn);
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@fun,x,[],[],[],[],[],[],@nontradablesolvefmincon, options);
lenx=length(x);
Oil(t)=x(1); 
OilLM(t)=x(2);
Oilmiu(t)=x(3);
Gas(t)=x(4); 
GasLM(t)=x(5);
Gasmiu(t)=x(6);
Coal(t)=x(7); 
CoalLM(t)=x(8);
Coalmiu(t)=x(9);
r(t) =x(10);
po(t) =x(11);
pg(t) =x(12);
pc(t) =x(13);

Xmatrix=reshape(x(14:lenx),NRegions,15)';
Ky(t,:) =Xmatrix(1,:);
Ks(t,:) =Xmatrix(2,:);
Ly(t,:) =Xmatrix(3,:);
Ls(t,:) =Xmatrix(4,:);
S(t,:) =Xmatrix(5,:);
w(t,:) =Xmatrix(6,:);
z(t,:) =Xmatrix(7,:);
Y(t,:) =Xmatrix(8,:);
%E =Xmatrix(9,:);
pe(t,:) =Xmatrix(9,:);
lamFF(t,:)=Xmatrix(10,:);
FF(t,:)=Xmatrix(11,:);
pFF(t,:)=Xmatrix(12,:);
OR(t,:)=Xmatrix(13,:);
GR(t,:)=Xmatrix(14,:);
CR(t,:)=Xmatrix(15,:);
end
OilReserves=0.9*OilReserves+0.1*max(OilR-cumsum(Oil),0);
GasReserves=0.9*GasReserves+0.1*max(GasR-cumsum(Gas),0);
CoalReserves=0.9*CoalReserves+0.1*max(CoalR-cumsum(Coal),0);

err0=max(abs((K(2:Tlast-1)-K_supply(2:Tlast-1))./OutputTrend(2:Tlast-1)))
end

        if Debt0>0
        lambda_low=lambda;
        else
            lambda_high=lambda; %                , Debt            ,       
        end
       % errlambda=abs((Cons(1,Gen_Number,1)-ConsOldb*T1lambda(1,Gen_Number,1))*POP(1,Gen_Number,1));
       errlambda=abs(Debt0/sum(Yb(1,:)));
end


    

 %{   
%errKLSRA=max(abs((K(2:Tlast-1)-KatstartLSRA(2:Tlast-1))./OutputTrend(2:Tlast-1)))    
KyLSRA=Ky;
KsLSRA=Ks;
LyLSRA=Ly;
LsLSRA=Ls;
SLSRA=S;
rLSRA=r;
wLSRA=w;
peLSRA=pe;
zLSRA=z;
ELSRA=E;
OilLSRA=Oil;
OilReservesLSRA=OilReserves;
OilLMLSRA=OilLM;
OilmiuLSRA=Oilmiu;
GasLSRA=Gas;
GasReservesLSRA=GasReserves;
GasLMLSRA=GasLM;
GasmiuLSRA=Gasmiu;
CoalLSRA=Coal;
CoalReservesLSRA=CoalReserves;
CoalLMLSRA=CoalLM;
CoalmiuLSRA=Coalmiu;
MATLSRA=3.666*MAT;
FORCLSRA=FORC;
TATMLSRA=TATM;
DamagesLSRA=Damages;
taxLSRA=tax;
VOilLSRA=VOil;
VGasLSRA=VGas;
VCoalLSRA=VCoal;
YLSRA=Y;
KLSRA=K;
QLSRA=Q;
ConsLSRA=Cons;
UtilityLSRA=zeros(Tlast,1); % Welfare of generations who will live all life
Utility_T1LSRA=zeros(1,Gen_Number);
LAMBDA_T1LSRA=zeros(1,Gen_Number);
for i=1:Tlast
    UtilityLSRA(i)=UD*((diag(ConsLSRA(i:i+Gen_Number-1,:)).^(1-sigma)-1))/(1-sigma);
end
for i=1:Gen_Number
    Utility_T1LSRA(i)=UD(1:Gen_Number-i+1)*((diag(ConsLSRA(1:Gen_Number-i+1,i:Gen_Number)).^(1-sigma)-1))/(1-sigma);
    LAMBDA_T1LSRA(i)=(((Utility_T1LSRA(i)*(1-sigma)+sum(UD(1:Gen_Number-i+1)))/(Utility_T1b(i)*(1-sigma)+sum(UD(1:Gen_Number-i+1))))^(1/(1-sigma))-1)*100;
end
ConsOldLSRA=Consp(1,Gen_Number);

LAMBDALSRA=(((UtilityLSRA*(1-sigma)+sum(UD))./(Utilityb*(1-sigma)+sum(UD))).^(1/(1-sigma))-1)*100;
%}