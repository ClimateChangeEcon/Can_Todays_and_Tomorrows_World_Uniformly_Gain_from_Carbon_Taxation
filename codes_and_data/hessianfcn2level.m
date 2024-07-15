function Hout = hessianfcn2level(x,lambda)
lengthx=length(x);
Hout=sparse(lengthx,lengthx);
global depr alpha teta beta phi Laux H Oilcostparameter1 Oilcostparameter4 OilR  
global  Oilcostparameter2 Oilcostparameter3 
global Kaux  Baux Aaux OT ST OilReservesaux OilLMp1 rp1 taxaux taxauxR  NRegions
global Gascostparameter1 Gascostparameter2 Gascostparameter3 Gascostparameter4 GasR   GasReservesaux GasLMp1
global Coalcostparameter1 Coalcostparameter2 Coalcostparameter3 Coalcostparameter4 CoalR   CoalReservesaux CoalLMp1
global kappaO kappaG FFelast kappaS Selast
global CoaltoBTU OiltoBTU GastoBTU eqnormalisation
hessiannontradablesolvefmincon2level;
Hout=lambda.eqnonlin(1)*heq(:,1:lengthx);
for j=2:lengthx
    Hout=Hout+lambda.eqnonlin(j)*heq(:,1+lengthx*(j-1):lengthx*j);
end



