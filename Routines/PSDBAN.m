PSDBAN ;BIR/JPW,LTL-Nurse BAL Report ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**63**;13 Feb 97;Build 1
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,1:0)
 ;I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print this report.",! K OK Q
 ;G:$G(NAOU)&($G(NAOUN)]"") ALL
ASKN ;ask naou
 K DA,DIC
 S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: ",DIC("B")=$G(NAOUN)
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)" D ^DIC K DIC G:Y<0 END
 S NAOU=+Y,NAOUN=$P(Y,"^",2)
ALL ;asks for all orders
 ;W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print this report for all drugs",DIR("B")="YES"
 W ! K DA,DIR,DIRUT
 S DIR(0)="S^A:All Drugs;S:Single Drug;C:Contingency Report;G:All drugs (including green sheets)"
 S DIR("A")="Please select type of report",DIR("B")="All Drugs"
 S DIR("?",1)="Answer 'A' to list all balances for this NAOU,",DIR("?")="answer 'S' to show the balance for a specific drug or '^' to quit."
 D ^DIR K DIR G:$D(DIRUT) END S ALL=Y
 G:ALL="A"!(ALL="G") DEV G:ALL="C" DEV^PSDBAN1
DRUG ;select drugs
 W ! K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""  *** INACTIVE ***"""
 S DA(1)=+NAOU,DIC(0)="QEAM",DIC="^PSD(58.8,"_NAOU_",1," D ^DIC K DIC G:Y<0 END W !!,"Balance:  ",$P($G(^PSD(58.8,NAOU,1,+Y,0)),U,4)," ",$S($P($G(^PSD(58.8,NAOU,1,+Y,0)),U,8)]"":$P($G(^(0)),U,8),1:$P($G(^PSDRUG(+Y,660)),U,8)),!! Q
DEV ;ask device and queue info
 W !!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="HOME" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDBAN",ZTDESC="Balance of NAOU drugs" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 ;U IO
START ;loops thru DRUGS
 U 0
 W !!,"Give me a second or two to alphabetize.",!
 U IO
 N PSDRUG,PSDRUGN S PSDRUG=0,PSDRUGN="" K ^TMP("PSDNST",$J)
 F  S PSDRUG=$O(^PSD(58.8,NAOU,1,PSDRUG)) Q:'PSDRUG  D:$P($G(^PSD(58.8,NAOU,1,PSDRUG,0)),U,4)
 .S ^TMP("PSDNST",$J,$P($G(^PSDRUG(+PSDRUG,0)),U))=$P($G(^PSD(58.8,NAOU,1,PSDRUG,0)),U,4)_" "_$S($P($G(^(0)),U,8)]"":$P($G(^(0)),U,8),1:$P($G(^PSDRUG(PSDRUG,660)),U,8))
PRINT ;prints the report
 S (PG,PSDOUT)=0,RPDT=$$HTE^XLFDT($H)
 K LN S $P(LN,"-",80)="" D HDR I '$D(^TMP("PSDNST",$J)) W !!,?10,"****  NO BALANCES TO REPORT  ****" G END
 S PSDR="" F  S PSDR=$O(^TMP("PSDNST",$J,PSDR)) Q:PSDR=""!(PSDOUT)  W !,?2,"=>  ",PSDR,?62,$G(^TMP("PSDNST",$J,PSDR)),! Q:PSDOUT
 G:PSDOUT END
 ;W:$O(^TMP("PSDNSU",$J,0))]"" !!,"The following drugs have Green Sheets:",!!
 ;F  S PSDR=$O(^TMP("PSDNSU",$J,PSDR)) Q:PSDR=""!(PSDOUT)  W ?2,"=>  ",PSDR,?62,$G(^TMP("PSDNSU",$J,PSDR)),! Q:PSDOUT
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END D:$G(ALL)="G"&($D(ZTQUEUED)) START^PSDNSCG K %,%H,%I,%ZIS,ALL,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE,OK,ORD
 K PG,POP,PSDOUT,PSDPN,PSDR,PSDRN,PSDST,PSDT,QTY,REQ,RPDT,STAT,STATN,X,X1,X2,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK,^TMP("PSDNST",$J),^TMP("PSDNSU",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?25,"Controlled Substance Balances",?70,"Page: ",PG,!,?35,NAOUN,!,?25,RPDT,!
 W !,?2,"=> DRUG",?62,"QUANTITY",!
 W !,LN,!
 Q
SAVE S (ZTSAVE("ALL"),ZTSAVE("NAOU"),ZTSAVE("NAOUN"))="" S:$D(PSDR) ZTSAVE("PSDR")=""
 Q
