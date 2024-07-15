regionsname=["USA","WEU","JSHK","CHI","IND","RUS","CND","EEU","SAP","BRA","MEX","SAF","MENA","SLA","SSA","SOV","GBR","ANZ"];



h1=figure('Position',[1 1 1366/2.2 768*1])
load UWI6x.mat;
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

for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100,'g-.','linewidth',2);title(regionsname(i));xlim([-78 300]);grid on; hold on;
end


load UWIF6x.mat;
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
for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100,'linewidth',2,'Color',[0 0 0]+0.5);title(regionsname(i));xlim([-78 300]);grid on; hold on;
end

load UWIL6x.mat;
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
for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100,'r:','linewidth',2);title(regionsname(i));xlim([-78 300]);grid on; hold on;
end

legend('UWI','UWIF' ,'UWIL','Orientation','horizontal','Location','best');