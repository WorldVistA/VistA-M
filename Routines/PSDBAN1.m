PSDBAN1 ;BIR/JPW,LTL-Nurse BAL Report ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
DEV ;ask device and queue info
 W !!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="HOME" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDBAN1",ZTDESC="Balance of NAOU drugs, Contingency Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;loops thru DRUGS
 W !!,"Give me a second or two to alphabetize.",!
 N PSDRUG,PSDRUGN S PSDRUG=0,PSDRUGN="" K ^TMP("PSDNST",$J)
 F  S PSDRUG=$O(^PSD(58.8,NAOU,1,PSDRUG)) Q:'PSDRUG  D:$P($G(^PSD(58.8,NAOU,1,PSDRUG,0)),U,4)
 .S ^TMP("PSDNST",$J,$P($G(^PSDRUG(+PSDRUG,0)),U))=$P($G(^PSD(58.8,NAOU,1,PSDRUG,0)),U,4)_" "_$S($P($G(^(0)),U,8)]"":$P($G(^(0)),U,8),1:$P($G(^PSDRUG(PSDRUG,660)),U,8))
PRINT ;prints the report
 S (PG,PSDOUT)=0,RPDT=$$HTE^XLFDT($H)
 K LN S $P(LN,"-",80)="" D HDR I '$D(^TMP("PSDNST",$J)) W !!,?10,"****  NO BALANCES TO REPORT  ****" G END
 S PSDR="" F  S PSDR=$O(^TMP("PSDNST",$J,PSDR)) Q:PSDR=""!(PSDOUT)  D:$Y+16>IOSL HDR Q:$G(PSDOUT)  W !,?2,"=>  ",PSDR,?62,$G(^TMP("PSDNST",$J,PSDR)),! D ^PSDRPGS3 Q:PSDOUT
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,ALL,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE,OK,ORD
 K PG,POP,PSDOUT,PSDPN,PSDR,PSDRN,PSDST,PSDT,QTY,REQ,RPDT,STAT,STATN,X,X1,X2,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?5,"Controlled Substance Balances, Contingency Report",?70,"Page: ",PG,!,?35,NAOUN,!,?25,RPDT,!
 W !,?2,"=> DRUG",?62,"QUANTITY",!
 W !,LN,!
 Q
SAVE S (ZTSAVE("ALL"),ZTSAVE("NAOU"),ZTSAVE("NAOUN"))="" S:$D(PSDR) ZTSAVE("PSDR")=""
 Q
