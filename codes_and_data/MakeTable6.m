clear all;
DataforTable6=string(zeros(35,4));


name1='BAU1x.mat';
name2='Policy1x.mat';
name3='UWI1x.mat';
name4='UWIF1x.mat';
name5='UWIL1x.mat';

results=string(zeros(35,1));

load(name1);
results(13)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(18)=string(100*max(GlobalDamages)); 
results(23)=string(100*max(max(Damages)));  
results(28)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name2);
results(1)=string(tax(1)*1000); 
results(5)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(9)=strcat(string(globalminlambda),"--",string(globalmaxlambda));
results(14)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(19)=string(100*max(GlobalDamages)); 
results(24)=string(100*max(max(Damages)));  
results(29)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name3);
results(2)=string(tax(1)*1000); 
results(6)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
results(10)=string((lambda-1)*100); 
results(15)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(20)=string(100*max(GlobalDamages)); 
results(25)=string(100*max(max(Damages)));  
results(30)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(33)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name4);
results(3)=string(tax(1)*1000); 
results(7)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(11)=strcat("0--",string(globalmaxlambda));
results(16)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(21)=string(100*max(GlobalDamages)); 
results(26)=string(100*max(max(Damages)));  
results(31)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(34)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name5);
results(4)=string(tax(1)*1000); 
results(8)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(12)=strcat(string(globalminlambda),"--",string(globalmaxlambda)); 
results(17)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(22)=string(100*max(GlobalDamages)); 
results(27)=string(100*max(max(Damages)));  
results(32)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(35)=string(globalmintransfer); 
DataforTable6(:,1)=results;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
name1='BAU2x.mat';
name2='Policy2x.mat';
name3='UWI2x.mat';
name4='UWIF2x.mat';
name5='UWIL2x.mat';

results=string(zeros(35,1));

load(name1);
results(13)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(18)=string(100*max(GlobalDamages)); 
results(23)=string(100*max(max(Damages)));  
results(28)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name2);
results(1)=string(tax(1)*1000); 
results(5)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(9)=strcat(string(globalminlambda),"--",string(globalmaxlambda));
results(14)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(19)=string(100*max(GlobalDamages)); 
results(24)=string(100*max(max(Damages)));  
results(29)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name3);
results(2)=string(tax(1)*1000); 
results(6)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
results(10)=string((lambda-1)*100); 
results(15)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(20)=string(100*max(GlobalDamages)); 
results(25)=string(100*max(max(Damages)));  
results(30)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(33)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name4);
results(3)=string(tax(1)*1000); 
results(7)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(11)=strcat("0--",string(globalmaxlambda));
results(16)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(21)=string(100*max(GlobalDamages)); 
results(26)=string(100*max(max(Damages)));  
results(31)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(34)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name5);
results(4)=string(tax(1)*1000); 
results(8)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(12)=strcat(string(globalminlambda),"--",string(globalmaxlambda)); 
results(17)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(22)=string(100*max(GlobalDamages)); 
results(27)=string(100*max(max(Damages)));  
results(32)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(35)=string(globalmintransfer); 
DataforTable6(:,2)=results;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
name1='BAU4x.mat';
name2='Policy4x.mat';
name3='UWI4x.mat';
name4='UWIF4x.mat';
name5='UWIL4x.mat';

results=string(zeros(35,1));

load(name1);
results(13)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(18)=string(100*max(GlobalDamages)); 
results(23)=string(100*max(max(Damages)));  
results(28)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name2);
results(1)=string(tax(1)*1000); 
results(5)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(9)=strcat(string(globalminlambda),"--",string(globalmaxlambda));
results(14)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(19)=string(100*max(GlobalDamages)); 
results(24)=string(100*max(max(Damages)));  
results(29)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name3);
results(2)=string(tax(1)*1000); 
results(6)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
results(10)=string((lambda-1)*100); 
results(15)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(20)=string(100*max(GlobalDamages)); 
results(25)=string(100*max(max(Damages)));  
results(30)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(33)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name4);
results(3)=string(tax(1)*1000); 
results(7)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(11)=strcat("0--",string(globalmaxlambda));
results(16)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(21)=string(100*max(GlobalDamages)); 
results(26)=string(100*max(max(Damages)));  
results(31)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(34)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name5);
results(4)=string(tax(1)*1000); 
results(8)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(12)=strcat(string(globalminlambda),"--",string(globalmaxlambda)); 
results(17)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(22)=string(100*max(GlobalDamages)); 
results(27)=string(100*max(max(Damages)));  
results(32)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(35)=string(globalmintransfer); 
DataforTable6(:,3)=results;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
name1='BAU6x.mat';
name2='Policy6x.mat';
name3='UWI6x.mat';
name4='UWIF6x.mat';
name5='UWIL6x.mat';

results=string(zeros(35,1));

load(name1);
results(13)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(18)=string(100*max(GlobalDamages)); 
results(23)=string(100*max(max(Damages)));  
results(28)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name2);
results(1)=string(tax(1)*1000); 
results(5)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(9)=strcat(string(globalminlambda),"--",string(globalmaxlambda));
results(14)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(19)=string(100*max(GlobalDamages)); 
results(24)=string(100*max(max(Damages)));  
results(29)=string(100*r(900)); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name3);
results(2)=string(tax(1)*1000); 
results(6)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
results(10)=string((lambda-1)*100); 
results(15)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(20)=string(100*max(GlobalDamages)); 
results(25)=string(100*max(max(Damages)));  
results(30)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(33)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%
load(name4);
results(3)=string(tax(1)*1000); 
results(7)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(11)=strcat("0--",string(globalmaxlambda));
results(16)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(21)=string(100*max(GlobalDamages)); 
results(26)=string(100*max(max(Damages)));  
results(31)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(34)=string(globalmintransfer); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(name5);
results(4)=string(tax(1)*1000); 
results(8)=string(((tax(50)/tax(1))^(1/49)-1)*100); 
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
minlambda(i)=min([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']) ;
maxlambda(i)=max([fliplr(LAMBDA_T1(1,2:Gen_Number,i)) (LAMBDA(1:300,1,i))']);
end
globalminlambda=min(minlambda);
globalmaxlambda=max(maxlambda);
results(12)=strcat(string(globalminlambda),"--",string(globalmaxlambda)); 
results(17)=string(max(TATM)); 
GlobalDamages=sum(Damages.*Y,2)./sum(Y,2); 
results(22)=string(100*max(GlobalDamages)); 
results(27)=string(100*max(max(Damages)));  
results(32)=string(100*r(900)); 
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
mintransfer(i)=min([fliplr(LSRAtransferO(1,2:Gen_Number,i)./PVCfirst(1,2:Gen_Number,i)) (LSRAtransferY(1:300,1,i)./PVC(1:300,i))']*100);
end
globalmintransfer=min(mintransfer);
results(35)=string(globalmintransfer); 
DataforTable6(:,4)=results;