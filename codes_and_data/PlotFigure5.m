figure;
load Policy6x.mat;

plot(tax(1:100)*1000,'b--','linewidth',2); hold on;
load UWI6x.mat;

plot(tax(1:100)*1000,'g-.','linewidth',2); hold on;
load UWIF6x.mat;

plot(tax(1:100)*1000,'linewidth',2,'Color',[0 0 0]+0.5); hold on; grid on; %title('6x case');
load UWIL6x.mat;

plot(tax(1:100)*1000,'r:','linewidth',2); hold on; grid on; 
legend('No transfers','UWI','UWIF',  'UWIL','Orientation','horizontal','Location','best');
