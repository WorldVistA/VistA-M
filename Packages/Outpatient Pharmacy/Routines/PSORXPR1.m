PSORXPR1 ;BHAM ISC/SAB -  CONTINUATION OF VIEW PRESCRIPTION ; 10/01/92
 ;;7.0;OUTPATIENT PHARMACY;**258**;DEC 1997;Build 4
RF D HEAD F N=0:0 S N=$O(^PSRX(DA,1,N)) Q:'N  S P1=^(N,0) D  Q:$D(DIRUT)
 .D CON:$Y>20 Q:$D(DIRUT)  D:FFX HEAD W !,N,?3 S DTT=$P(P1,"^",8)\1 D DAT W DAT,?12
 .S DTT=$P(P1,"^") D DAT W DAT,?22,$P(P1,"^",4),?36
 .S PSDIV=$S($D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^",6),1:"UNKNOWN"),X=$P(P1,"^",2),X=$F("MWIBD",X)-1 W:X $P("M^W^INP","^",X),?40,$P(P1,"^",6),?52,$E($S($D(^VA(200,+$P(P1,"^",5),0)):$P(^(0),"^"),1:""),1,16),?70,PSDIV
 .W !," DISPENSED: "_$S($P(P1,"^",19):$E($P(P1,"^",19),4,5)_"/"_$E($P(P1,"^",19),6,7)_"/"_$E($P(P1,"^",19),2,3),1:"")
 .W ?$X+10,$S($P(P1,"^",16):" RETURNED TO STOCK: "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:" RELEASED: "_$S($P(P1,"^",18):$E($P(P1,"^",18),4,5)_"/"_$E($P(P1,"^",18),6,7)_"/"_$E($P(P1,"^",18),2,3),1:""))
 .W:$P(P1,"^",3)'="" !?5,"REMARKS: ",$P(P1,"^",3),!
 Q
PAR I $O(^PSRX(DA,"P",0)) D CON:$Y>20 Q:$D(DIRUT)  D PARL S N=0 F  S N=$O(^PSRX(DA,"P",N)) Q:'N  S P1=^(N,0) D  Q:$D(DIRUT)
 .D CON:$Y>20 Q:$D(DIRUT)  D:FFX PAR W !,N,?3 S DTT=$P(P1,"^",8)\1 D DAT W DAT,?14
 .S DTT=$P(P1,"^") D DAT W DAT,?27,$P(P1,"^",4),?32
 .S PSDIV=$S($D(^PS(59,+$P(P1,"^",9),0)):$P(^(0),"^",6),1:"UNKNOWN"),X=$P(P1,"^",2),X=$F("MWIBD",X)-1 W:X $P("MAIL^WINDOW^INPATIENT","^",X)
 .W ?40,$P(P1,"^",6),?52,$E($S($D(^VA(200,+$P(P1,"^",5),0)):$P(^(0),"^"),1:""),1,16),?70,PSDIV
 .W ?$X+10,$S($P(P1,"^",16):" RETURNED TO STOCK: "_$E($P(P1,"^",16),4,5)_"/"_$E($P(P1,"^",16),6,7)_"/"_$E($P(P1,"^",16),2,3),1:" RELEASED: "_$S($P(P1,"^",19):$E($P(P1,"^",19),4,5)_"/"_$E($P(P1,"^",19),6,7)_"/"_$E($P(P1,"^",19),2,3),1:""))
 .W:$P(P1,"^",3)'="" !?5,"REMARKS: ",$P(P1,"^",3)
 Q
HLD ;prints hold info
 S DTT=$P(^PSRX(DA,"H"),"^",3) D DAT S HLDR=$P(^DD(52,99,0),"^",3),HLDR=$S($P(^PSRX(DA,"H"),"^")'>8:$P(HLDR,";",$P(^PSRX(DA,"H"),"^")),1:$P(HLDR,";",9)),HLDR=$P(HLDR,":",2)
 W !!,"HOLD REASON: "_HLDR,?60,"HOLD DATE: "_DAT W:$P(^PSRX(DA,"H"),"^",2)]"" !,"HOLD COMMENTS: "_$P(^PSRX(DA,"H"),"^",2)
 K DAT,DTT,HLDR
 Q
HEAD I FFX W @IOF
 W !,"#",?3,"LOG DATE",?12,"REF DATE",?22,"QTY",?35,"ROUT",?40,"LOT #",?52,"PHARMACIST",?70,"DIVISION",! F I=1:1:79 W "="
 S FFX=0 W ! Q
DAT S DAT="",DTT=DTT\1 Q:DTT'?7N  S DAT=$E(DTT,4,5)_"/"_$E(DTT,6,7)_"/"_$E(DTT,2,3)
 Q
PARL I FFX W @IOF
 W !,"PARTIAL FILLS:",!,"#",?3,"LOG DATE",?14,"DATE",?27,"QTY",?32,"ROUTING",?40,"LOT #",?55,"PHARMACIST",?70,"DIVISION",! F I=1:1:79 W "="
 S FFX=0 W ! Q
CON K DTOUT,DIRUT,DUOUT,DIR S DIR(0)="E" D ^DIR S FFX=1 Q
