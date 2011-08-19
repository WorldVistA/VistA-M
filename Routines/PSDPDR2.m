PSDPDR2 ;BIR/BJW-Narc Disp/Rec Report (VA FORM 10-2321) (cont'd) ; 09 FEB 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;entry to print
 S COPY=$S(PSDCPY="V":2,1:1) D COPY
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,ALL,ANS,C,CNT,COPY,COMM,DA,DIC,DIE,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,EXP,EXPD,FLAG,LN,LOOP,LOT,MFG,NAOU,NODE,NUM
 K OK,ORD,ORDN,PG,POP,PSD,PSDA,PSDCPY,PSDDT,PSDEV,PSDG,PSDIO,PSDN,PSDNA,PSDOUT,PSDPT,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDSN,PSDST,QTY,REQD,REQDT,RPDT,SEL,STAT,STATN,TEXT,X,Y
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDRPT",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 ;;The next line inserted for E3R# 3311 2-9-95.
 I PG,$G(PSDCPY)="V"!($G(COPY)=2) W !,"* VERIFIED ORDER WAS EDITED."
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF I PSDCPY="V"!(COPY=2) W !,?45,"*** RECEIPT VERIFICATION COPY ***",!,?42,"Technician Delivering Orders: ________________________",!
 W !,?2,"VA FORM 10-2321",?42,"Narcotic Dispensing/Receiving Report" I NAOU]"",NAOU'=0 W " for ",NAOU W:$P($G(^PSD(58.8,+$O(^PSD(58.8,"B",NAOU,0)),2)),U,5) " (Perpetual Inventory)"
 W ?125,"Page: ",PG,!,?52,RPDT,!
 W !,?14,"DATE",?78,"DATE"
 W !,"DISP #",?12,"DISPENSED",?24,"QTY",?33,"DRUG",?78,"ORD",?90,"ORDERED BY"
 W !,LN,!!
 Q
COPY ;copy 1 and 2
 S (COMM,PG,PSDOUT,NAOU)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDRPT",$J)) D HDR W !!,?45,"****  NO PENDING NARCOTIC ORDERS TO BE DELIVERED  ****" S FLAG=1 Q
 S NAOU="" F  S NAOU=$O(^TMP("PSDRPT",$J,NAOU)) Q:NAOU=""!(PSDOUT)  D HDR Q:PSDOUT  D  Q:PSDOUT  I PSDCPY="B",COPY=1 S COPY=2 D HDR D  S COPY=1
 .;;$Y changed to 12 to force fnote to print at bottom of page E3R# 3311.
 .S NUM="" F  S NUM=$O(^TMP("PSDRPT",$J,NAOU,NUM)) Q:NUM=""!(PSDOUT)  D:$Y+12>IOSL HDR Q:PSDOUT  S NODE=^TMP("PSDRPT",$J,NAOU,NUM) D
COP ..I $P(NODE,"^",9),$Y+12>IOSL D HDR Q:PSDOUT
 ..;;The next line inserted for E3r# 3311 2-9-95.
 ..NEW X S X=$P(NODE,"^",2) S X=$S(PSDCPY="V":X,COPY=2:X,1:+X)
 ..W !,NUM,?12,$P(NODE,"^",3),?21,$J(X,6),?33,$P(NODE,"^"),?78,$P(NODE,"^",4),?90,$P(NODE,"^",5)
 ..;;Balance inserted for E3R# 3311 2-9-95.
 ..I PSDCPY="V"!(COPY=2) W !,?33,"BALANCE:  "_$S($P(NODE,"^",11)]"":+$P(NODE,"^",11),1:"UNKNOWN")_" "_$P(NODE,"^",12)
 ..I $P(NODE,"^",6)]"" W !,?33,"Mfg/Lot #/Exp Date:  ",$P(NODE,"^",6)_"  "_$P(NODE,"^",7)_"  "_$P(NODE,"^",8)
 ..W !!,?7,"Disp by RPh:___________________________________",?61,"Rec'd by Nurse:___________________________________",!,?19,"(Full Name)",?76,"(Full Name)",!
 ..I $P(NODE,"^",9) W ?24,"COMMENTS:" S COMM=1,PSDA=$P(NODE,"^",10) K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.81,PSDA,2,TEXT)) Q:'TEXT  D:$Y+4>IOSL HDR Q:PSDOUT  S X=$G(^PSD(58.81,PSDA,2,TEXT,0)),DIWL=34,DIWR=115,DIWF="W" D ^DIWP
 ..I COMM D ^DIWW S COMM=0 W !
 ..K DA,DIE,DR S (DA,PSDA)=+$P(NODE,"^",10),DR="102////"_PSDPT,DIE=58.81 D ^DIE K DA,DIE,DR
 ;;The next line inserted for E3R# 3311 2-9-95.
 I PG,$G(PSDCPY)="V"!($G(COPY)=2) W !,"* VERIFIED ORDER WAS EDITED."
 Q
