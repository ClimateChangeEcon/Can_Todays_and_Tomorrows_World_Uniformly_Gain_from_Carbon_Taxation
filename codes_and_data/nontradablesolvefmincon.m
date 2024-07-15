
function [c, ceq, gc, gceq]=nontradablesolvefmincon(x)
c=[];
global depr alpha teta beta phi Laux H Oilcostparameter1 Oilcostparameter4 OilR  
global  Oilcostparameter2 Oilcostparameter3 
global Kaux  Baux Aaux OT ST OilReservesaux OilLMp1 rp1 taxaux taxauxR  NRegions
global Gascostparameter1 Gascostparameter2 Gascostparameter3 Gascostparameter4 GasR   GasReservesaux GasLMp1
global Coalcostparameter1 Coalcostparameter2 Coalcostparameter3 Coalcostparameter4 CoalR   CoalReservesaux CoalLMp1
global kappaO kappaG FFelast eqnormalisation
global CoaltoBTU OiltoBTU GastoBTU

lenx=length(x);
Oil=x(1); 
OilLM=x(2);
Oilmiu=x(3);
Gas=x(4); 
GasLM=x(5);
Gasmiu=x(6);
Coal=x(7); 
CoalLM=x(8);
Coalmiu=x(9);
r =x(10);
po =x(11);
pg =x(12);
pc =x(13);

Xmatrix=reshape(x(14:lenx),NRegions,15)';
Ky =Xmatrix(1,:);
Ks =Xmatrix(2,:);
Ly =Xmatrix(3,:);
Ls =Xmatrix(4,:);
S =Xmatrix(5,:);
w =Xmatrix(6,:);
z =Xmatrix(7,:);
Y =Xmatrix(8,:);
%E =Xmatrix(9,:);
pe =Xmatrix(9,:);
lamFF=Xmatrix(10,:);
FF=Xmatrix(11,:);
pFF=Xmatrix(12,:);
OR=Xmatrix(13,:);
GR=Xmatrix(14,:);
CR=Xmatrix(15,:);





ceq=zeros(13+NRegions*15,1);
ceq(1)=(sum(Ky+Ks)-Kaux)./OT;
%ceq(2)=(OilEf*Oil+CoalEf*Coal+GasEf*Gas+sum(S-E))./ST;
ceq(2)=(sum(OR)-OiltoBTU*Oil)*eqnormalisation;
ceq(3)=(Oilcostparameter2+2*Oilcostparameter3*(OilR-OilReservesaux)+3*Oilcostparameter4*(OilR-OilReservesaux)^2+1/OilReservesaux^2)*Oil-OilLM+OilLMp1/(1+rp1);
ceq(4)=po-(taxaux+Oilcostparameter1+Oilcostparameter2*(OilR-OilReservesaux)+Oilcostparameter3*(OilR-OilReservesaux).^2+Oilcostparameter4*(OilR-OilReservesaux).^3+1./OilReservesaux+OilLM)+Oilmiu;
ceq(5)=(Oilmiu+Oil-sqrt(Oilmiu^2+Oil^2))^2;
ceq(6)=(Gascostparameter2+2*Gascostparameter3*(GasR-GasReservesaux)+3*Gascostparameter4*(GasR-GasReservesaux)^2+1/GasReservesaux^2)*Gas-GasLM+GasLMp1/(1+rp1);
ceq(7)=pg-(taxaux+Gascostparameter1+Gascostparameter2*(GasR-GasReservesaux)+Gascostparameter3*(GasR-GasReservesaux).^2+Gascostparameter4*(GasR-GasReservesaux).^3+1./GasReservesaux+GasLM)+Gasmiu;
ceq(8)=(Gasmiu+Gas-sqrt(Gasmiu^2+Gas^2))^2;
ceq(9)=(Coalcostparameter2+2*Coalcostparameter3*(CoalR-CoalReservesaux)+3*Coalcostparameter4*(CoalR-CoalReservesaux)^2+1/CoalReservesaux^2)*Coal-CoalLM+CoalLMp1/(1+rp1);
ceq(10)=pc-(taxaux+Coalcostparameter1+Coalcostparameter2*(CoalR-CoalReservesaux)+Coalcostparameter3*(CoalR-CoalReservesaux).^2+Coalcostparameter4*(CoalR-CoalReservesaux).^3+1./CoalReservesaux+CoalLM)+Coalmiu;
ceq(11)=(Coalmiu+Coal-sqrt(Coalmiu^2+Coal^2))^2;
ceq(12)=(sum(GR)-GastoBTU*Gas)*eqnormalisation;
ceq(13)=(sum(CR)-CoaltoBTU*Coal)*eqnormalisation;




cmatrix1=Ly+Ls-Laux;
cmatrix2=(S-Baux.*Ks.^teta.*Ls.^phi.*(H).^(1-teta-phi))./ST;
cmatrix3=(pe.*teta.*S-(depr+r).*Ks)./OT;
cmatrix4=(pe.*phi.*S-w.*Ls)./OT;
cmatrix5=(pe.*(1-teta-phi).*S-z.*H)./OT;
cmatrix6=(Y-Aaux.*Ky.^alpha.*Ly.^beta.*(S+FF).^(1-alpha-beta))./OT;
cmatrix7=(alpha.*Y-(depr+r).*Ky)./OT;
cmatrix8=(beta.*Y-w.*Ly)./OT;
cmatrix9=((1-alpha-beta).*Y-pe.*(S+FF))./OT;
cmatrix10=(FF*eqnormalisation+lamFF-sqrt(lamFF.^2+(FF*eqnormalisation).^2)).^2;
cmatrix11=pe-pFF+lamFF;
cmatrix12=pFF-(kappaO.*((po+taxauxR)/OiltoBTU).^(1-FFelast)+kappaG.*((pg+taxauxR)/GastoBTU).^(1-FFelast)+(1-kappaO-kappaG).*((pc+taxauxR)/CoaltoBTU).^(1-FFelast)).^(1/(1-FFelast));
cmatrix13=(OR-kappaO.*FF.*(((po+taxauxR)/OiltoBTU)./pFF).^(-FFelast))*eqnormalisation;
cmatrix14=(GR-kappaG.*FF.*(((pg+taxauxR)/GastoBTU)./pFF).^(-FFelast))*eqnormalisation;
cmatrix15=(CR-(1-kappaO-kappaG).*FF.*(((pc+taxauxR)/CoaltoBTU)./pFF).^(-FFelast))*eqnormalisation;
ceq(14:13+NRegions*15)=[cmatrix1 cmatrix2 cmatrix3 cmatrix4 cmatrix5 cmatrix6 cmatrix7 cmatrix8 cmatrix9 cmatrix10 cmatrix11 cmatrix12 cmatrix13 cmatrix14 cmatrix15]';
%ceq(12)=Oilcostparameter4*Oil/OilReservesaux^(Oilcostparameter4+1)-OilLM+OilLMp1/(1+rp1)+Oilcostparameter2*Oilcostparameter3*(OilR-OilReservesaux)^(Oilcostparameter3-1)/OilR^Oilcostparameter3*Oil;
%ceq(13)=pe-(taxaux+Oilcostparameter1+Oilcostparameter2*(1-OilReservesaux/OilR).^Oilcostparameter3+1./OilReservesaux.^Oilcostparameter4+OilLM)+Oilmiu;
if nargout > 2
    gc = [];
    gradientnontradablesolvefmincon;
end



