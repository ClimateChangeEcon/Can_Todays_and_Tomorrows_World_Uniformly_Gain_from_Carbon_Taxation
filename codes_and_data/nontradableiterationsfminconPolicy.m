for dutyenergyiteration=1:Numberofdutyenergyiteration
    dutyenergyiteration
%     subplot(1,3,1);plot(OilReserves(1:Tlast)); hold on;title('Oil');
%     subplot(1,3,2);plot(GasReserves(1:Tlast)); hold on;title('Gas');
%     subplot(1,3,3);plot(CoalReserves(1:Tlast)); hold on;title('Coal');

%for t=TlastConopt:-1:1
for t=1:TlastConopt
    
%t
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
%OilReserves=0.9*OilReserves+0.1*max(OilR-cumsum(Oil),0);
%GasReserves=0.9*GasReserves+0.1*max(GasR-cumsum(Gas),0);
%CoalReserves=0.9*CoalReserves+0.1*max(CoalR-cumsum(Coal),0);
OilReserves=0.9*OilReserves+0.1*max(OilR-cumsum(Oil),0);
GasReserves=0.9*GasReserves+0.1*max(GasR-cumsum(Gas),0);
CoalReserves=0.9*CoalReserves+0.1*max(CoalR-cumsum(Coal),0);
Numberofdutyenergyiteration=1;

end