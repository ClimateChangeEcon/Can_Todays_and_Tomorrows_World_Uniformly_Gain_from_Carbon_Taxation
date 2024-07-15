regionsname=["USA","WEU","JSHK","CHI","IND","RUS","CND","EEU","SAP","BRA","MEX","SAF","MENA","SLA","SSA","SOV","GBR","ANZ"];

h1=figure('Position',[1 1 1366/2.2 768*1])
load Policy6x.mat;
for j=1:NRegions
for i=1:Tlast
    Utility(i,1,j)=UD*(((diag(Cons(i:i+Gen_Number-1,:,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(i:i+Gen_Number-1,:,j)));
    LAMBDA(i,1,j)=(((Utility(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))./(Utilityb(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))).^(1/(1-sigma))-1)*100;
end
for i=1:Gen_Number
    Utility_T1(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Cons(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
    LAMBDA_T1(1,i,j)=(((Utility_T1(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j))))^(1/(1-sigma))-1)*100;
end

end

for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))'],'b--','linewidth',2);title(regionsname(i));grid on; hold on;
end


load UWI6x.mat;
for j=1:NRegions
for i=1:Tlast
    Utility(i,1,j)=UD*(((diag(Cons(i:i+Gen_Number-1,:,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(i:i+Gen_Number-1,:,j)));
    LAMBDA(i,1,j)=(((Utility(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))./(Utilityb(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))).^(1/(1-sigma))-1)*100;
end
for i=1:Gen_Number
    Utility_T1(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Cons(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
    LAMBDA_T1(1,i,j)=(((Utility_T1(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j))))^(1/(1-sigma))-1)*100;
end

end

for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))'],'g-.','linewidth',2);title(regionsname(i));grid on; hold on;
end

load UWIF6x.mat;
for j=1:NRegions
for i=1:Tlast
    Utility(i,1,j)=UD*(((diag(Cons(i:i+Gen_Number-1,:,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(i:i+Gen_Number-1,:,j)));
    LAMBDA(i,1,j)=(((Utility(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))./(Utilityb(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))).^(1/(1-sigma))-1)*100;
end
for i=1:Gen_Number
    Utility_T1(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Cons(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
    LAMBDA_T1(1,i,j)=(((Utility_T1(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j))))^(1/(1-sigma))-1)*100;
end

end

for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))'],'linewidth',2,'Color',[0 0 0]+0.5);title(regionsname(i));grid on; hold on;
end


load UWIL6x.mat;
for j=1:NRegions
for i=1:Tlast
    Utility(i,1,j)=UD*(((diag(Cons(i:i+Gen_Number-1,:,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(i:i+Gen_Number-1,:,j)));
    LAMBDA(i,1,j)=(((Utility(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))./(Utilityb(i,1,j)*(1-sigma)+UD*diag(POP(i:i+Gen_Number-1,:,j)))).^(1/(1-sigma))-1)*100;
end
for i=1:Gen_Number
    Utility_T1(1,i,j)=UD(1:Gen_Number-i+1)*(((diag(Cons(1:Gen_Number-i+1,i:Gen_Number,j)).^(1-sigma)-1))/(1-sigma).*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)));
    LAMBDA_T1(1,i,j)=(((Utility_T1(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j)))/(Utility_T1b(1,i,j)*(1-sigma)+UD(1:Gen_Number-i+1)*diag(POP(1:Gen_Number-i+1,i:Gen_Number,j))))^(1/(1-sigma))-1)*100;
end

end

for i=1:NRegions
subplot(6,3,i); h=plot(-78:300,[fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))'],'r:','linewidth',2);title(regionsname(i));grid on; hold on;
end

legend('No transfers','UWI','UWIF', 'UWIL','Orientation','horizontal','Location','best');

