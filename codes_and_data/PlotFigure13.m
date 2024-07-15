load Damages.mat;
plot(100*DamagesDICE(1:1000), 'k', 'linewidth',3);hold on;
plot(100*GlobalDamages(1:1000), 'k--','linewidth',3);grid on;
legend('DICE','Krusell-Smith')