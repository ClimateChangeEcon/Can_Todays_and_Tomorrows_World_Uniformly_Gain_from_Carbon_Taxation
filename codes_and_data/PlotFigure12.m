
regionsname=["USA","WEU","JSHK","CHI","IND","RUS","CND","EEU","SAP","BRA","MEX","SAF","MENA","SLA","SSA","SOV","GBR","ANZ"];

load BAU6x.mat;

tt=1:300;
h1=figure('Position',[1 1 1366/2.2 768*1])

for i=1:NRegions
subplot(6,3,i); h=plot(tt,1000*POP(1:300,1,i),'k-',tt,1000*POP(1:300,20,i),'b--',tt,1000*POP(1:300,40,i),'g:',tt,1000*POP(1:300,60,i),'r-.', 'linewidth',2);title(regionsname(i));grid on;
end
legend('$P_{:,t,1}$', '$P_{:,t,20}$','$P_{:,t,40}$','$P_{:,t,60}$','Interpreter','latex','Location','best');
