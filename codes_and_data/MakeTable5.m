datafortable=zeros(20,4);
load BAU1x;
datafortable(1:5,1)=max(Damages(:,1:5))*100;
datafortable(6:7,1)=min(Damages(:,6:7))*100;
datafortable(8:18,1)=max(Damages(:,8:18))*100;
datafortable(19,1)=max(sum(Damages.*Y,2)./sum(Y,2))*100;
datafortable(20,1)=max(TATM);

load BAU2x;
datafortable(1:5,2)=max(Damages(:,1:5))*100;
datafortable(6:7,2)=min(Damages(:,6:7))*100;
datafortable(8:18,2)=max(Damages(:,8:18))*100;
datafortable(19,2)=max(sum(Damages.*Y,2)./sum(Y,2))*100;
datafortable(20,2)=max(TATM);

load BAU4x;
datafortable(1:5,3)=max(Damages(:,1:5))*100;
datafortable(6:7,3)=min(Damages(:,6:7))*100;
datafortable(8:18,3)=max(Damages(:,8:18))*100;
datafortable(19,3)=max(sum(Damages.*Y,2)./sum(Y,2))*100;
datafortable(20,3)=max(TATM);

load BAU6x;
datafortable(1:5,4)=max(Damages(:,1:5))*100;
datafortable(6:7,4)=min(Damages(:,6:7))*100;
datafortable(8:18,4)=max(Damages(:,8:18))*100;
datafortable(19,4)=max(sum(Damages.*Y,2)./sum(Y,2))*100;
datafortable(20,4)=max(TATM);

datafortable
