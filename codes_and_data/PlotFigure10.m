subplot(5,2,1);
for t=1:300
        if t>1
        Selast(t)=2+0.1*(t-1);
    else
        Selast(t)=2;
        end
end
plot(Selast,'b--','linewidth',2);hold on;
for t=1:300
        if t>50
        Selast(t)=2+0.1*(t-50);
    else
        Selast(t)=2;
        end
end
plot(Selast,'g-.','linewidth',2);
for t=1:300
        if t>100
        Selast(t)=2+0.1*(t-100);
    else
        Selast(t)=2;
        end
end
plot(Selast,'r:','linewidth',2);grid on;title('Clean-dirty energy elasticity');


subplot(5,2,2);load UWI6x;plot(tax(1:100)*1000,'k-','linewidth',2);hold on;
load UWI6xinfcoal;plot(tax(1:100)*1000,'linewidth',2,'Color',[0 0 0]+0.5);
load UWI6xinfcoal2level0;plot(tax(1:100)*1000,'b--','linewidth',2);
load UWI6xinfcoal2level50;plot(tax(1:100)*1000,'g-.','linewidth',2);
load UWI6xinfcoal2level100;plot(tax(1:100)*1000,'r:','linewidth',2);grid on; title('Optimal global carbon tax');ylabel('$ per ton of CO2');

subplot(5,2,3);load BAU6x;plot(1000*OiltoBTU*Oil(1:300),'k-','linewidth',2);hold on;
load BAU6xinfcoal;plot(1000*OiltoBTU*Oil(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load BAU6xinfcoal2level0;plot(1000*OiltoBTU*Oil(1:300),'b--','linewidth',2);
load BAU6xinfcoal2level50;plot(1000*OiltoBTU*Oil(1:300),'g-.','linewidth',2);
load BAU6xinfcoal2level100;plot(1000*OiltoBTU*Oil(1:300),'r:','linewidth',2);grid on; title('BAU oil usage');ylabel('quad BTU');ylim([0 310]);

subplot(5,2,4);load UWI6x;plot(1000*OiltoBTU*Oil(1:300),'k-','linewidth',2);hold on;
load UWI6xinfcoal;plot(1000*OiltoBTU*Oil(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load UWI6xinfcoal2level0;plot(1000*OiltoBTU*Oil(1:300),'b--','linewidth',2);
load UWI6xinfcoal2level50;plot(1000*OiltoBTU*Oil(1:300),'g-.','linewidth',2);
load UWI6xinfcoal2level100;plot(1000*OiltoBTU*Oil(1:300),'r:','linewidth',2);grid on; title('UWI oil usage');ylabel('quad BTU');ylim([0 310]);

subplot(5,2,5);load BAU6x;plot(1000*GastoBTU*Gas(1:300),'k-','linewidth',2);hold on;
load BAU6xinfcoal;plot(1000*GastoBTU*Gas(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load BAU6xinfcoal2level0;plot(1000*GastoBTU*Gas(1:300),'b--','linewidth',2);
load BAU6xinfcoal2level50;plot(1000*GastoBTU*Gas(1:300),'g-.','linewidth',2);
load BAU6xinfcoal2level100;plot(1000*GastoBTU*Gas(1:300),'r:','linewidth',2);grid on; title('BAU Gas usage');ylabel('quad BTU');ylim([0 240]);

subplot(5,2,6);load UWI6x;plot(1000*GastoBTU*Gas(1:300),'k-','linewidth',2);hold on;
load UWI6xinfcoal;plot(1000*GastoBTU*Gas(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load UWI6xinfcoal2level0;plot(1000*GastoBTU*Gas(1:300),'b--','linewidth',2);
load UWI6xinfcoal2level50;plot(1000*GastoBTU*Gas(1:300),'g-.','linewidth',2);
load UWI6xinfcoal2level100;plot(1000*GastoBTU*Gas(1:300),'r:','linewidth',2);grid on; title('UWI Gas usage');ylabel('quad BTU'); ylim([0 240]);

subplot(5,2,7);load BAU6x;plot(1000*CoaltoBTU*Coal(1:300),'k-','linewidth',2);hold on;
load BAU6xinfcoal;plot(1000*CoaltoBTU*Coal(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load BAU6xinfcoal2level0;plot(1000*CoaltoBTU*Coal(1:300),'b--','linewidth',2);
load BAU6xinfcoal2level50;plot(1000*CoaltoBTU*Coal(1:300),'g-.','linewidth',2);
load BAU6xinfcoal2level100;plot(1000*CoaltoBTU*Coal(1:300),'r:','linewidth',2);grid on; title('BAU Coal usage');ylabel('quad BTU');ylim([0 1500]);

subplot(5,2,8);load UWI6x;plot(1000*CoaltoBTU*Coal(1:300),'k-','linewidth',2);hold on;
load UWI6xinfcoal;plot(1000*CoaltoBTU*Coal(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load UWI6xinfcoal2level0;plot(1000*CoaltoBTU*Coal(1:300),'b--','linewidth',2);
load UWI6xinfcoal2level50;plot(1000*CoaltoBTU*Coal(1:300),'g-.','linewidth',2);
load UWI6xinfcoal2level100;plot(1000*CoaltoBTU*Coal(1:300),'r:','linewidth',2);grid on; title('UWI Coal usage');ylabel('quad BTU');ylim([0 1500]);

subplot(5,2,9);load BAU6x; GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'k-','linewidth',2);hold on;
load BAU6xinfcoal;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load BAU6xinfcoal2level0;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'b--','linewidth',2);
load BAU6xinfcoal2level50;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'g-.','linewidth',2);
load BAU6xinfcoal2level100;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'r:','linewidth',2);grid on; title('BAU global damages');ylabel('percent of GDP');ylim([0 30]);

subplot(5,2,10);load UWI6x; GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'k-','linewidth',2);hold on;
load UWI6xinfcoal;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'linewidth',2,'Color',[0 0 0]+0.5);
load UWI6xinfcoal2level0;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'b--','linewidth',2);
load UWI6xinfcoal2level50;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'g-.','linewidth',2);
load UWI6xinfcoal2level100;GlobalDamages=sum(Damages.*Y,2)./sum(Y,2);plot(100*GlobalDamages(1:300),'r:','linewidth',2);grid on; title('UWI global damages');ylabel('percent of GDP');ylim([0 30]);

legend('Baseline: finite coal, infinite substitution','Infinite coal, infinite substitution','Infinite coal, high substitution','Infinite coal, medium substitution', 'Infinite coal, low substitution','Orientation','vertical','Location','best');


