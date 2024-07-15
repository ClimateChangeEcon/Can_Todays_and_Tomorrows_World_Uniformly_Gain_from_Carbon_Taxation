
clear all;

tic;
global alpha teta beta phi L H Oilcostparameter1 Oilcostparameter4 depr gY_ss gS TlastConopt taxauxR ED0aux
global A B  Tlast K Ky Ks Ly Ls S r pe OilReserves Oil OilLM GasReserves Coal CoalLM CoalReserves Gas GasLM tax E OilR CoalR GasR Coalcostparameter1 Coalcostparameter4 Gascostparameter1 Gascostparameter4
global Oilcostparameter2 Oilcostparameter3 Coalcostparameter2 Coalcostparameter3 Gascostparameter2 Gascostparameter3 OilEf CoalEf GasEf MM NN
global Kaux  Baux Aaux OT ST OilReservesaux OilLMp1 rp1 taxaux GasReservesaux GasLMp1 CoalReservesaux CoalLMp1 Oilaux Gasaux Coalaux Laux NRegions kappaO kappaG FFelast
global CoaltoBTU OiltoBTU GastoBTU eqnormalisation

eqnormalisation=1000;
 %%%%%regional temperature and damages
Tempprime=11.6;
kplus=0.001;
kminus=0.001;
tstep=1;
%Maximum cumulative extraction fossil fuels (GtC) 
oillim=600;
gaslim=400;
coallim=2700;

OilR=(oillim)*3.666;
CoalR=(coallim)*3.666;
GasR=(gaslim)*3.666;
CoaltoBTU=0.010256;
OiltoBTU=0.013774;
GastoBTU=0.018832;




Tlast=1000;
TlastConopt=250;

NRegions=18;


kappaO=[0.711688815
0.75132464
0.767623081
0.486160806
0.635930094
0.46719265
0.700834191
0.467891859
0.715406212
0.895588369
0.751249021
0.535926649
0.681372535
0.772150867
0.840267379
0.380228684
0.709510958
0.694031181
]; 
kappaO=kappaO';
kappaG=[0.221112302
0.17958218
0.13408697
0.071490055
0.061615989
0.451761815
0.273933789
0.354216895
0.197711757
0.078980815
0.22546408
0.032996162
0.302398719
0.209995717
0.145954973
0.443150046
0.269076022
0.191415376
]; kappaG=kappaG';
FFelast=2;
Gen_Number=80;
%%% EP0 profile
EP0=zeros(1,Gen_Number);
EP0(1:40)=ones(size(EP0(1:40)));
for i=1:40
    EP0(i)=exp(4.47+0.033*i-0.00067*i^2)*exp(0.0198*i);
end


regionspopulation18part1; %get POP
POP=zeros(Tlast,Gen_Number,NRegions);
kk=0;
for i=1:NRegions
    POP(1:84,:,i)=POP18regions(1+84*kk:84+84*kk,21:100);
    kk=kk+1;
end
regionspopulation18part2;
kk=0;
for i=1:NRegions
    POP(85:484,:,i)=POP18regions(2:401,1+80*kk:80+80*kk);
    kk=kk+1;
end

for i=1:NRegions
    for kk=485:Tlast+Gen_Number
    POP(kk,:,i)=POP(kk-1,:,i);
    end
end
POP=POP/1e3;

EP=sum(POP(1,:,1))/(POP(1,:,1)*EP0')*EP0;
for i=1:NRegions
L(:,i)=POP(:,:,i)*EP';
end
%%%%Total land
H=ones(1,NRegions);
%2017 US $ market exchange rates
Y0peryear=[19.48924885	15.93667993	7.070795068	12.14349145	2.652242858	1.578624061	1.646867221	0.25665691	2.502119261	2.062831046	1.15773619	0.349554117	4.218117061	2.092250599	0.998809165	0.358814561	2.66622918	1.532726571];
%%"USA","WEU","JSHK","CHI","IND","RUS","CND","EEU","SAP","BRA","MEX","SAF","MENA","SLA","SSA","SOV","GBR","ANZ"
Y0=Y0peryear*tstep;
pc0=[
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
4.5085E-06
];
pc0=pc0'*1e6;
pg0=[
    5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
5.74355E-06
];pg0=pg0'*1e6;
po0=[
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
8.9045E-06
];
po0=po0'*1e6;
Coal0=[13.8375
9.1399
8.6528
88.42
16.6235
4.9319
0.689
1.5688
4.2254
0.6706
0.4796
3.9776
2.2719
0.6277
0.1727
2.6714
0.3842
1.7664
];
Coal0=Coal0'/1e3;
Gas0=[
    28.0551
14.6377
7.2734
8.8051
2.0867
16.9394
4.6091
1.9248
5.9248
1.2833
2.8612
0.1876
26.0848
4.5493
1.1273
4.13
2.9748
1.8187
];
Gas0=Gas0'/1e3;
Oil0=[
    37.5691
25.4788
17.3237
24.9121
8.9602
7.2883
4.906
1.0578
8.9194
6.0542
3.9664
1.2677
24.4531
6.9595
2.7001
1.4743
3.2635
2.7435
];
Oil0=Oil0'/1e3;
pe0=[
7.50035E-06
7.63547E-06
7.61308E-06
6.05478E-06
6.70107E-06
6.70697E-06
7.57597E-06
6.50726E-06
7.46068E-06
8.33549E-06
7.76472E-06
6.19021E-06
7.53184E-06
7.85937E-06
8.14118E-06
6.28804E-06
7.61743E-06
7.31652E-06
];
pe0=pe0'*1e6;

SshareinGDP0=[
0.007033594
0.008235905
0.003945113
0.008626681
0.007089298
0.015603891
0.022311117
0.03080248
0.003786814
0.018525059
0.004044879
0.004296176
0.003546007
0.012346601
0.006757088
0.010416556
0.004586349
0.003212111
];

SshareinGDP0=SshareinGDP0';
energyshare=SshareinGDP0+(po0.*Oil0+pg0.*Gas0+pc0.*Coal0)./Y0;
alpha=1/3*(1-energyshare);
%%%Labor share in final good production sector
beta=2/3*(1-energyshare);
%%%Capital share in clean energy production sector
teta=alpha*0.4./(alpha+beta);
%%%Labor share in clean energy production sector
phi=beta*0.4./(alpha+beta);
%%%Depriation
depr=0.1;
%Multivariate
gOutputperyear=[0.0156	0.023222703	0.034832459	0.040993	0.035503	0.014967	0.014755	0.016474	0.026508375	0.018292	0.009224	0.013606	0.016090378	0.008859155	0.008284826	0.02434	0.016038	0.014459543];

Oilcostparameter1=0.75*po0(1)*OiltoBTU;
Oilcostparameter2=(2-1)*Oilcostparameter1/0.5/OilR;
Oilcostparameter3=0;
Oilcostparameter4=0;

Gascostparameter1 =0.75*pg0(1)*GastoBTU;
Gascostparameter2=(2-1)*Gascostparameter1/0.5/GasR;
Gascostparameter3=0;
Gascostparameter4=0;

Coalcostparameter1 =0.95*pc0(1)*CoaltoBTU;
Coalcostparameter2=(1.5-1)*Coalcostparameter1/0.5/CoalR;
Coalcostparameter3=0;
Coalcostparameter4=0;

gY_ss=log(1+gOutputperyear(1,1))*tstep;
gOutputperyear=gOutputperyear+1;
gY=zeros(Tlast,NRegions);
for i=1:100
gY(i,:)=log(gOutputperyear)*tstep;
end
for i=101:Tlast
gY(i,:)=log(gOutputperyear(1))*tstep;
end

gBackstopPriceperyear=0.995; % growth of backstop price /0.995/

gP=log(gBackstopPriceperyear)*tstep*ones(Tlast,NRegions);
gB=((1-teta).*(1-alpha-teta.*(1-alpha-beta)).*gY-(1-alpha-teta.*(1-alpha-beta)).*gP)./((1-teta).*(1-alpha-beta)+beta);
gA=(1-alpha-teta.*(1-alpha-beta)).*gY-(1-alpha-beta).*gB;
gS=gB+teta.*(gA+(1-alpha-beta).*gB)./(1-alpha-teta.*(1-alpha-beta));
returnperyear=0.04;
Ky0=alpha.*Y0/(depr+returnperyear);
Ks0=SshareinGDP0.*Y0.*teta./(depr+returnperyear);

K0=sum(Ks0+Ky0); %trillion
S0=SshareinGDP0.*Y0./pe0;

Ly0=L(1,:).*(Ky0./(Ky0+Ks0));
Ls0=L(1,:).*(Ks0./(Ky0+Ks0));
ED0=(kappaO.^(1/FFelast).*Oil0.^(1-1/FFelast)+kappaG.^(1/FFelast).*Gas0.^(1-1/FFelast)+(1-kappaO-kappaG).^(1/FFelast).*Coal0.^(1-1/FFelast)).^(FFelast/(FFelast-1));
E0=ED0+S0;

A0=Y0./Ky0.^alpha./Ly0.^beta./E0.^(1-alpha-beta);
B0=S0./(Ks0.^teta.*Ls0.^phi.*(H).^(1-teta-phi));
w0=beta.*Y0./Ly0;
z0=(1-phi-teta).*pe0.*S0;

rho=(1+0.015)^tstep-1;
sigma=1.45;


MATFXtfirst    = 897.97;
MUtfirst    = 815.89;
MLtfirst     = 1808.98;
TATMtfirst   = 1.49;
TOCEANtfirst = 0.378;
mateq=607;  
mueq=600; 
mleq=1772; 
b12=0.072;
b23=0.0042; 

b21=b12*mateq/mueq;
b32=b23*mueq/mleq;


PHIM=[1-b12 b21 0; b12 1-b21-b23 b32; 0 b23 1-b32];



 c1=0.137; 
 c3=0.73; 
 c4=0.00689; 
t2xco2=3.25; 
fco22x=3.45; 


ksi1=c1;
ksi2=c1*fco22x/t2xco2; 
phi12=c4; 
phi21=c1*c3; 

PHIT=[1-phi21-ksi2 phi21; phi12 1-phi12];
        
        



%%%1 1/(1+rho) 1/(1+rho)^2 ...
UD=zeros(1,Gen_Number);
UD(1)=1;
for i=2:Gen_Number
   UD(i)=UD(i-1)/(1+rho);
end



t=0:Tlast-1;t=t';

A=A0.*exp(cumsum(gA)-gA(1,:));
B=B0.*exp(cumsum(gB)-gB(1,:));
%B(:,2)=1.1*B(:,2);
Ainit=A;
OutputTrend=exp(gY(1,1)*(t));
PbackTrend=exp(gP(1,1)*(t));
STrend=exp(gS(1,1)*(t));


%%%accuracy
epsilonsteady=K0*exp(gY(1,1)*(Tlast-1))*1e-5;

epsilonR=0.001*OilR;

K=zeros(Tlast,1);
workingonsteadystate;



%%%%%%%%%%%%%%%%%%%%Здесь мы смотрим какая доля активов принадлежит
%%%%%%%%%%%%%%%%%%%%поколениям
%Shares_steady=(Assets_steady)/sum(sum(Assets_steady));
%Shares_steady=abs(Assets_steady)/sum(sum(abs(Assets_steady)));
Initialassets;

epsilonK=0.0005*K0;%0.0005*K0;
%%%find transition path


t=1:Tlast;
%%%initialization of the variables

Ky=zeros(Tlast,NRegions);
Ks=zeros(Tlast,NRegions);
Ly=zeros(Tlast,NRegions);
Ls=zeros(Tlast,NRegions);
S=zeros(Tlast,NRegions);
r=zeros(Tlast+Gen_Number-1,1);
w=zeros(Tlast+Gen_Number-1,NRegions);
pe=zeros(Tlast,NRegions);
z=zeros(Tlast,NRegions);
Q=zeros(Tlast,NRegions);
E=zeros(Tlast,NRegions);
lamFF=zeros(Tlast,NRegions)+1e-10;
FF=zeros(Tlast,NRegions)+1e-10;
pFF=zeros(Tlast,NRegions)+1e-10;
OR=zeros(Tlast,NRegions)+1e-10;
GR=zeros(Tlast,NRegions)+1e-10;
CR=zeros(Tlast,NRegions)+1e-10;
K_supply=zeros(Tlast,1);
Y=zeros(Tlast,NRegions);
Oil=zeros(Tlast,1)+1e-10;
OilReserves=zeros(Tlast,1);
OilLM=zeros(Tlast,1);
Oilmiu=zeros(Tlast,1)+1e-10;
Gas=zeros(Tlast,1)+1e-10;
GasReserves=zeros(Tlast,1);
GasLM=zeros(Tlast,1);
Gasmiu=zeros(Tlast,1)+1e-10;
Coal=zeros(Tlast,1)+1e-10;
CoalReserves=zeros(Tlast,1);
CoalLM=zeros(Tlast,1);
po =zeros(Tlast,1)+1e-10;
pg =zeros(Tlast,1)+1e-10;
pc =zeros(Tlast,1)+1e-10;
Coalmiu=zeros(Tlast,1)+1e-10;
VOil=zeros(Tlast,1);
VGas=zeros(Tlast,1);
VCoal=zeros(Tlast,1);
Cons=zeros(Tlast+Gen_Number-1,Gen_Number,NRegions);

Assets=zeros(Tlast,Gen_Number,NRegions);
TDiscount=zeros(Tlast,Gen_Number);
transfers=zeros(Tlast+Gen_Number-1,Gen_Number,NRegions);
transfersperregion=zeros(Tlast,NRegions);
tax=zeros(Tlast,1);%+40/1000;
taxR=zeros(Tlast,NRegions);
%taxR(:,1)=40/1000;
%tax(1:5)=0;
disequilibrium=zeros(Tlast,1);

Damages=zeros(Tlast,NRegions);
     MAT= zeros(Tlast,1);
     ML= zeros(Tlast,1);
     MU= zeros(Tlast,1);
     TATM= zeros(Tlast,1);
     TOCEAN = zeros(Tlast,1);
     FORC= zeros(Tlast,1);
     MAT(1)= MATFXtfirst;
     ML(1)= MLtfirst ;
     MU(1)= MUtfirst;
     TATM(1)= TATMtfirst;
     TOCEAN(1) = TOCEANtfirst;

%%%%%%Initial guess for capital. We use it for iterative procedure
K(Tlast)=K_steady;
K(1)=K0;
%{
for t=2:Tlast-1
     K(t)=K_steady*exp(-gY_ss*(Tlast-t));
     %K(t)=K0*exp(gY_ss*(t-1));
end
%}
%%%%%%Initial guess for Reserves
for t=1:TlastConopt
CoalReserves(t)=CoalR-(CoalR-CoalR/5)/TlastConopt*t;
OilReserves(t)=OilR-(OilR-OilR/5)/TlastConopt*t;
GasReserves(t)=GasR-(GasR-GasR/5)/TlastConopt*t;
end
for t=2:TlastConopt
Coal(t)=CoalReserves(t-1)-CoalReserves(t);
Oil(t)=OilReserves(t-1)-OilReserves(t);
Gas(t)=GasReserves(t-1)-GasReserves(t);
end
t=1;
Coal(t)=CoalR-CoalReserves(t);
Oil(t)=OilR-OilReserves(t);
Gas(t)=GasR-GasReserves(t);

for t=TlastConopt+1:Tlast
CoalReserves(t)=CoalReserves(t-1);
OilReserves(t)=OilReserves(t-1);
GasReserves(t)=GasReserves(t-1);
end 
tic;
options = optimoptions('fmincon','Algorithm','interior-point', 'MaxFunEvals', 3000000,'MaxIter', 3000000,'StepTolerance',1e-40,'Display','off');
options = optimoptions(options,'GradObj','on','GradConstr','on','Hessian','user-supplied','HessFcn',@hessianfcnsteady);
for t=Tlast:-1:1%TlastConopt+1
    Kaux=K(t); 
    Baux=B(t,:); 
    Aaux=A(t,:);
    OT=OutputTrend(t);
    ST=STrend(t);
    Laux=L(t,:);
    t
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
toc;
Numberofdutyenergyiteration=50;
dutyenergyiterationflag=2;




 %options = optimoptions('fmincon','Algorithm','interior-point','StepTolerance',1e-25,'Display','off');
% options = optimoptions('fmincon','Algorithm','interior-point','Display','off', 'MaxFunctionEvaluations',30000);
 %options = optimoptions('fmincon','Algorithm','sqp','Display','off');

%for globaliterate=1:20
%load BAUlong OilReserves GasReserves CoalReserves;
%load zerodamages
err0=1000;
globaliterate=1;
while err0>epsilonK
    globaliterate

   
nontradableiterationsfmincon;

updatehouseholdandclimate;

globaliterate=globaliterate+1;
end

xxx=1:Tlast;
figure;
subplot(2,1,1);plot(xxx,OilReserves(1:Tlast),'r',xxx,GasReserves(1:Tlast),'b',xxx,CoalReserves(1:Tlast),'g'); title('Reserves');
legend('Oil', 'Gas', 'Coal');
subplot(2,1,2);plot(xxx,Oil(1:Tlast),'r',xxx,Gas(1:Tlast),'b',xxx,Coal(1:Tlast),'g'); title('Extraction');
legend('Oil', 'Gas', 'Coal');
Kyb=Ky;
Ksb=Ks;
Lyb=Ly;
Lsb=Ls;
Sb=S;
rb=r;
wb=w;
peb=pe;
zb=z;
Eb=E;
Oilb=Oil;
OilReservesb=OilReserves;
OilLMb=OilLM;
Oilmiub=Oilmiu;
Gasb=Gas;
GasReservesb=GasReserves;
GasLMb=GasLM;
Gasmiub=Gasmiu;
Coalb=Coal;
CoalReservesb=CoalReserves;
CoalLMb=CoalLM;
Coalmiub=Coalmiu;
MATb=MAT;
FORCb=FORC;
TATMb=TATM;
Damagesb=Damages;
taxb=tax;
VOilb=VOil;
VGasb=VGas;
VCoalb=VCoal;
Yb=Y;
Kb=K;
Qb=Q;
Consb=Cons;
ORb=OR;
CRb=CR;
GRb=GR;
Utilityb=zeros(Tlast,1,NRegions); % Welfare of generations who will live all life
Utility_T1b=zeros(1,Gen_Number,NRegions);
for j=1:NRegions
for i=1:Tlast
    Utilityb(i,1,j)=UD*(((diag(Consb(i:i+Gen_Number-1,:,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(i:i+Gen_Number-1,:,j)));
end
for i=1:Gen_Number
    Utility_T1b(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Consb(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
end
ConsOldb=Consb(1,Gen_Number,1);
end

toc;
save BAU1;
