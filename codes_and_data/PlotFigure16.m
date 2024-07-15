regionsname=["USA","WEU","JSHK","CHI","IND","RUS","CND","EEU","SAP","BRA","MEX","SAF","MENA","SLA","SSA","SOV","GBR","ANZ"]

h1=figure('Position',[1 1 1366/2.2 768*1])
load BAU6x;
tt=1:300;
for i=1:NRegions
subplot(6,3,i); h=plot(tt,CR(1:300,i)*1000,'k-','linewidth',2);grid on;title(regionsname(i));hold on; %ylim([-5 15]);grid on; 
end
load Policy6x;
tt=1:300;
for i=1:NRegions
subplot(6,3,i); h=plot(tt,CR(1:300,i)*1000,'b--','linewidth',2);grid on;title(regionsname(i));hold on; %ylim([-5 15]);grid on;
end
load UWI6x;
tt=1:300;
for i=1:NRegions
subplot(6,3,i); h=plot(tt,CR(1:300,i)*1000,'g-.','linewidth',2);grid on;title(regionsname(i)); hold on;%ylim([-5 15]);grid on;
end

load UWIL6x;
tt=1:300;
for i=1:NRegions
subplot(6,3,i); h=plot(tt,CR(1:300,i)*1000,'linewidth',2,'Color',[0 0 0]+0.5);grid on;title(regionsname(i)); hold on;%ylim([-5 15]);grid on;
end
load UWIF6x;
tt=1:300;
for i=1:NRegions
subplot(6,3,i); h=plot(tt,CR(1:300,i)*1000,'r:','linewidth',2);grid on;title(regionsname(i));hold on; %ylim([-5 15]);grid on;
end
legend('BAU','No transfers','UWI', 'UWIF', 'UWIL','Orientation','horizontal','Location','best');