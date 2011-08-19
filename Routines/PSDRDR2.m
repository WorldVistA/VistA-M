PSDRDR2 ;BIR/BJW-Narc Disp/Rec (reprint VA FORM 10-2321) (cont'd) ; 4 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;reprint log in lieu of VA FORM 10-2321
 S COPY=1 D COPY Q:PSDOUT  G:$D(FLAG) DONE
 I PSDCPY="B" S COPY=2 D COPY
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END Q
HDR ;header for log
 I PG,$G(PSDCPY)="V"!($G(COPY)=2) W !,"* VERIFIED ORDER WAS EDITED."
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?55,"*** REPRINT ***",! I PSDCPY="V"!(COPY=2) W !,?50,"*** PHARMACY VAULT COPY ***",!,?42,"Technician Delivering Orders: ____________________",!
 W !,?2,"VA FORM 10-2321",?42,"Narcotic Dispensing/Receiving Report" I NAOU]"",NAOU'=0 W " for ",NAOU
 W ?120,"Page: ",PG,!,?52,RPDT,!
 W !,?14,"DATE",?78,"DATE"
 W !,"DISP #",?12,"DISPENSED",?24,"QTY",?33,"DRUG",?78,"ORD",?90,"ORDERED BY"
 W !,LN,!!
 Q
COPY ;copy number
 S (COMM,PG,PSDOUT,NAOU)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDRDR",$J)) D HDR W !!,?45,"****  NO PENDING NARCOTIC ORDERS TO BE DELIVERED  ****" S FLAG=1 Q
 S NAOU="" F  S NAOU=$O(^TMP("PSDRDR",$J,NAOU)) Q:NAOU=""!(PSDOUT)  D HDR Q:PSDOUT  D  Q:PSDOUT
 .S NUM="" F  S NUM=$O(^TMP("PSDRDR",$J,NAOU,NUM)) Q:NUM=""!(PSDOUT)  D:$Y+12>IOSL HDR Q:PSDOUT  S NODE=^TMP("PSDRDR",$J,NAOU,NUM) D
 ..I $P(NODE,"^",9),$Y+12>IOSL D HDR Q:PSDOUT
 ..NEW X S X=$P(NODE,"^",2) S X=$S(PSDCPY="V":X,COPY=2:X,1:+X)
 ..W !,NUM,?12,$P(NODE,"^",3),?21,$J(X,6),?33,$P(NODE,"^"),?78,$P(NODE,"^",4),?90,$P(NODE,"^",5)
 ..;;The next line added for E3R# 3311 2-9-95.
 ..I PSDCPY="V"!(COPY=2) W !,?33,"BALANCE:  "_$S(+$P(NODE,"^",13):+$P(NODE,"^",13),1:"UNKNOWN")_" "_$P(NODE,"^",14)
 ..I $P(NODE,"^",6)]"" W !,?33,"Mfg/Lot #/Exp Date:  ",$P(NODE,"^",6)_"  "_$P(NODE,"^",7)_"  "_$P(NODE,"^",8)
 ..W !!,?7,"Disp by RPh:",$S($P(NODE,"^",11)]"":"  "_$P(NODE,"^",11),1:"___________________________________")
 ..W ?61,"Rec'd by Nurse:",$S($P(NODE,"^",12)]"":"  "_$P(NODE,"^",12),1:"___________________________________")
 ..W !,?19,"(Full Name)",?76,"(Full Name)",!
 ..I $P(NODE,"^",9) W ?24,"COMMENTS:" S COMM=1,PSDA=$P(NODE,"^",10) K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.81,PSDA,2,TEXT)) Q:'TEXT  D:$Y+4>IOSL HDR Q:PSDOUT  S X=$G(^PSD(58.81,PSDA,2,TEXT,0)),DIWL=34,DIWR=115,DIWF="W" D ^DIWP
 ..I COMM D ^DIWW S COMM=0 W !
 I PG,$G(PSDCPY)="V"!($G(COPY)=2) W !,"* VERIFIED ORDER WAS EDITED."
 Q
