
Damagesinit=Damages;
SCC=zeros(Tlast,NRegions);
periodlast=TlastConopt+1;
for period=1:periodlast
     Eimp=zeros(size(Oil));
     if period<periodlast
         Eimp(period)=1;
     else
         Eimp(period)=1;
     end
     Eland=zeros(size(Oil));  
     FORCEX=zeros(size(Oil)); 
for t=1:Tlast-1
     Eland(t)=0.709*exp(-0.023*(t-1));
     FORCEX(t)=0.5+1/85*(1-0.5)*min(t,85);
     auxxx=PHIM*[MAT(t); MU(t); ML(t)]+[(Oil(t)+Gas(t)+Coal(t))*(1/3.666)+Eland(t)+Eimp(t)*(1/3.666);0;0];
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

MarginalDamages=Damages-Damagesinit;
for iterSCC=Tlast-1:-1:period
    SCC(iterSCC,:)=MarginalDamages(iterSCC,:).*Y(iterSCC,:)*10^3+SCC(iterSCC+1,:)/(1+r(iterSCC+1));
end
period
sum(SCC(period,:),2)
Eimp(period)
end