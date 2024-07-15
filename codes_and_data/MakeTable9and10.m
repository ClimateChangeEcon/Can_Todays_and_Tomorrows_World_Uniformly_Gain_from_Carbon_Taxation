clear all;
datafortable9=zeros(32,10);
datafortable10=zeros(32,11);
rowindex=-4;
load BAU1x;rowindex=rowindex+4;
computeSCC;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

load UWI1x;rowindex=rowindex+4;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];


load BAU2x;rowindex=rowindex+4;
computeSCC;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

load UWI2x;rowindex=rowindex+4;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

load BAU4x;rowindex=rowindex+4;
computeSCC;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

load UWI4x;rowindex=rowindex+4;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

load BAU6x;rowindex=rowindex+4;
computeSCC;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

load UWI6x;rowindex=rowindex+4;
datafortable9(1+rowindex,1)=2.017;
datafortable9(2+rowindex,1)=2.025;
datafortable9(3+rowindex,1)=2.050;
datafortable9(4+rowindex,1)=2.100;

datafortable9(1+rowindex,2:10)=SCC(1,1:9);
datafortable9(2+rowindex,2:10)=SCC(9,1:9);
datafortable9(3+rowindex,2:10)=SCC(34,1:9);
datafortable9(4+rowindex,2:10)=SCC(84,1:9);

datafortable10(1+rowindex,1)=2.017;
datafortable10(2+rowindex,1)=2.025;
datafortable10(3+rowindex,1)=2.050;
datafortable10(4+rowindex,1)=2.100;

datafortable10(1+rowindex,2:11)=[SCC(1,10:18) sum(SCC(1,:))];
datafortable10(2+rowindex,2:11)=[SCC(9,10:18) sum(SCC(9,:))];
datafortable10(3+rowindex,2:11)=[SCC(34,10:18) sum(SCC(34,:))];
datafortable10(4+rowindex,2:11)=[SCC(84,10:18) sum(SCC(84,:))];

