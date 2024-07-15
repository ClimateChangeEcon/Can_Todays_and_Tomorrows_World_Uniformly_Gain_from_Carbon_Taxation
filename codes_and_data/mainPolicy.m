clear all;
load BAU.mat;

computeSCC;
SCCglobBAU=sum(SCC,2)/1000;

LSRAtransferY=zeros(Tlast,1,NRegions); %%Transfer to young generations at time t
LSRAtransferO=zeros(1,Gen_Number,NRegions); %%Transfer to old generations at time 1/// assume that LSRAtransferO(1,1)=0
totaltransferfromLSRA=zeros(Tlast,Gen_Number,NRegions);
tax=SCCglobBAU;


err0=1000;
while err0>epsilonK
    err0
     globaliterate= globaliterate+1

nontradableiterationsfminconPolicy;    
updatehouseholdandclimatePolicy;   
end


Kyp=Ky;
Ksp=Ks;
Lyp=Ly;
Lsp=Ls;
Sp=S;
rp=r;
wp=w;
pep=pe;
zp=z;
Ep=E;
Oilp=Oil;
OilReservesp=OilReserves;
OilLMp=OilLM;
Oilmiup=Oilmiu;
Gasp=Gas;
GasReservesp=GasReserves;
GasLMp=GasLM;
Gasmiup=Gasmiu;
Coalp=Coal;
CoalReservesp=CoalReserves;
CoalLMp=CoalLM;
Coalmiup=Coalmiu;
MATp=MAT;
FORCp=FORC;
TATMp=TATM;
Damagesp=Damages;
taxp=tax;
VOilp=VOil;
VGasp=VGas;
VCoalp=VCoal;
Yp=Y;
Kp=K;
Qp=Q;
Consp=Cons;
Utilityp=zeros(Tlast,1,NRegions); % Welfare of generations who will live all life
Utility_T1p=zeros(1,Gen_Number,NRegions);
LAMBDA=zeros(size(Utilityp));
LAMBDA_T1p=zeros(size(Utility_T1p));

for j=1:NRegions
for i=1:Tlast
    Utilityp(i,1,j)=UD*(((diag(Consp(i:i+Gen_Number-1,:,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(i:i+Gen_Number-1,:,j)));
    LAMBDA(i,1,j)=(((Utilityp(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))./(Utilityb(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))).^(1/(1-sigma))-1)*100;
end
for i=1:Gen_Number
    Utility_T1p(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Consp(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
    LAMBDA_T1p(1,i,j)=(((Utility_T1p(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j))))^(1/(1-sigma))-1)*100;
end

end
ConsOldp=Consp(1,Gen_Number,1);
ORp=OR;
CRp=CR;
GRp=GR;


save Policy.mat;