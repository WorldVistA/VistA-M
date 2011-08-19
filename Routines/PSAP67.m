PSAP67 ;BIR/DB - New Prime Vendor field checker ;9/19/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**67**; 10/1/07;Build 15
DISP ;
 W !?9,"PV-Drug-Description  : ",$S($P(PSADATA,"^",28)'="":$P(PSADATA,"^",28),1:"Unknown")
 W ?65,"PV-DUOU  : ",$S($P(PSADATA,"^",31)'="":$P(PSADATA,"^",31),1:"")
 W !?9,"PV-Drug-Generic Name : ",$S($P(PSADATA,"^",29)'="":$P(PSADATA,"^",29),1:"Unknown")
 W ?65,"PV-UNITS : ",$S($P(PSADATA,"^",30)'="":$P(PSADATA,"^",30),1:"")
 Q
DISP2 ;
 S PSAP67=$G(^PSD(58.811,PSAORD,1,PSAINV,3,PSALN,0))
 W !,"PV-Drug-Description  : ",$S($P(PSAP67,"^",1)'="":$P(PSAP67,"^",1),1:"Unknown")
 W ?55,"PV-DUOU  : ",$S($P(PSAP67,"^",4)'="":$P(PSAP67,"^",4),1:"Unknown")
 W !,"PV-Drug-Generic Name : ",$S($P(PSAP67,"^",2)'="":$P(PSAP67,"^",2),1:"Unknown")
 W ?55,"PV-UNITS : ",$S($P(PSAP67,"^",3)'="":$P(PSAP67,"^",3),1:"Unknown"),!
 K PSAP67 Q
