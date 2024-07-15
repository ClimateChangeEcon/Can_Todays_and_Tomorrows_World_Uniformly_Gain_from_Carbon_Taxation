
function [c, ceq, gc, gceq]=nontradablesolvefminconsteady(x)
c=[];
global depr alpha teta beta phi Laux H ED0aux
global Kaux  Baux Aaux OT ST NRegions


lenx=length(x);
r =x(1);
Xmatrix=reshape(x(2:lenx),NRegions,10)';
pe =Xmatrix(1,:);
Ky =Xmatrix(2,:);
Ks =Xmatrix(3,:);
Ly =Xmatrix(4,:);
Ls =Xmatrix(5,:);
S =Xmatrix(6,:);
w =Xmatrix(7,:);
z =Xmatrix(8,:);
Y =Xmatrix(9,:);
E =Xmatrix(10,:);




ceq=zeros(1+NRegions*10,1);
ceq(1)=(sum(Ky+Ks)-Kaux)./OT;
cmatrix1=Ly+Ls-Laux;
cmatrix2=(S-Baux.*Ks.^teta.*Ls.^phi.*(H).^(1-teta-phi))./ST;
cmatrix3=(pe.*teta.*S-(depr+r).*Ks)./OT;
cmatrix4=(pe.*phi.*S-w.*Ls)./OT;
cmatrix5=(pe.*(1-teta-phi).*S-z.*H)./OT;
cmatrix6=(Y-Aaux.*Ky.^alpha.*Ly.^beta.*E.^(1-alpha-beta))./OT;
cmatrix7=(alpha.*Y-(depr+r).*Ky)./OT;
cmatrix8=(beta.*Y-w.*Ly)./OT;
cmatrix9=((1-alpha-beta).*Y-pe.*E)./OT;
cmatrix10=(S+ED0aux-E)./ST;
ceq(2:1+NRegions*10)=[cmatrix1 cmatrix2 cmatrix3 cmatrix4 cmatrix5 cmatrix6 cmatrix7 cmatrix8 cmatrix9 cmatrix10]';
if nargout > 2
    gc = [];
    gradientnontradablesolvefminconsteady;
end
%ceq(12)=Oilcostparameter4*Oil/OilReservesaux^(Oilcostparameter4+1)-OilLM+OilLMp1/(1+rp1)+Oilcostparameter2*Oilcostparameter3*(OilR-OilReservesaux)^(Oilcostparameter3-1)/OilR^Oilcostparameter3*Oil;
%ceq(13)=pe-(taxaux+Oilcostparameter1+Oilcostparameter2*(1-OilReservesaux/OilR).^Oilcostparameter3+1./OilReservesaux.^Oilcostparameter4+OilLM)+Oilmiu;




