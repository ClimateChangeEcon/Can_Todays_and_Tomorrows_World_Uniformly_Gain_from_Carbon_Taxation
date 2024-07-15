Tempprime=11.6;
kplus=0.001;
kminus=0.001;
i=0;
for Treg=0:0.1:40
    i=i+1;
    D1(i)=0.02+0.98*((sign(Treg-Tempprime)+1)/2.*exp(-kplus*(Treg-Tempprime).^2)+(sign(-Treg+Tempprime)+1)/2.*exp(-kminus*(Treg-Tempprime).^2));
    D2(i)=0.02+0.98*((sign(Treg-Tempprime)+1)/2.*exp(-2*kplus*(Treg-Tempprime).^2)+(sign(-Treg+Tempprime)+1)/2.*exp(-kminus*(Treg-Tempprime).^2));
    D4(i)=0.02+0.98*((sign(Treg-Tempprime)+1)/2.*exp(-4*kplus*(Treg-Tempprime).^2)+(sign(-Treg+Tempprime)+1)/2.*exp(-kminus*(Treg-Tempprime).^2));
    D6(i)=0.02+0.98*((sign(Treg-Tempprime)+1)/2.*exp(-6*kplus*(Treg-Tempprime).^2)+(sign(-Treg+Tempprime)+1)/2.*exp(-kminus*(Treg-Tempprime).^2));

end
Treg=0:0.1:40;
plot(Treg,D1,'k-',Treg,D2,'g--',Treg,D4,'b:',Treg,D6,'r-.', 'linewidth',3); grid on;
legend('1x', '2x','4x','6x','Orientation','vertical','Location','best'); xlabel('Regional temperature');ylabel('Regional productivity');