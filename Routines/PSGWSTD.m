PSGWSTD ;BHAM ISC/KKA - Standard Cost Report ; 25 Aug 97 / 9:59 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;**4,13**;4 JAN 94
 D SEL^PSGWUTL1 Q:'$D(SEL)  G:SEL="I" DVC
 F  S DIC=58.1,DIC(0)="QEAM" D ^DIC K DIC Q:Y<0  S AOULP(+Y)=""
 G:'$D(AOULP)&(X'="^ALL") END
 I X="^ALL" F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  S AOULP(AOU)=""
DVC ;select a device
 W !!,"The right margin for this report is 132.",!,"You may queue the report to print at a later time.",!!
 K IO("Q"),%ZIS,IOP S %ZIS="MQ",%ZIS("B")="" D ^%ZIS K %ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." Q
 I $D(IO("Q")) S ZTRTN="EN1^PSGWSTD",ZTDESC="MAXIMUM COST REPORT",ZTSAVE("AOULP(")="" D ^%ZTLOAD,HOME^%ZIS G END
 U IO
EN1 ;entry point when queued
 D NOW^%DTC S PSGWDT=X,PAGE=1,OUT=0
 S AOU=0 F  S AOU=$O(AOULP(AOU)) Q:AOU'>0!(OUT)  S TTCST=0 D PRINT
DONE I $E(IOST)="C"&('OUT) W !!!,"Press <RETURN> to continue: " R AUTO:DTIME
 W !,@IOF
END S:$D(ZTQUEUED) ZTREQ="@"
 K %ZIS,AOU,AOULP,AUTO,CONV,DIC,DIR,DRG,I,INACT,ITM,LVL,OUT,PAGE,POP,PSGWAOUN,PSGWDT,SEL,TCST,TTCST,UCST,X,Y,ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE
 D ^%ZISC
 Q
PRINT ;print all items for the AOU and their data
 D PAGE Q:OUT
 W !,"  ==>",$P(^PSI(58.1,AOU,0),"^")
 I '$O(^PSI(58.1,AOU,1,0)) W !!,"No items found for this AOU" Q
 S ITM=0,MFLG=0 F  S ITM=$O(^PSI(58.1,AOU,1,ITM)) Q:ITM'>0!(OUT)  D
 .I $Y+4>IOSL D PAGE Q:OUT
 .S PSGWAOUN=^PSI(58.1,AOU,1,ITM,0)
 .S DRG=$P(PSGWAOUN,"^") Q:'DRG
 .S INACT=$P(PSGWAOUN,"^",3) I INACT=""!(INACT>PSGWDT) D
 ..I $D(^PSDRUG(DRG,0)) D
 ...W !,$P(^PSDRUG(DRG,0),"^")
 ...S LVL=$P(PSGWAOUN,"^",2)
 ...I $D(^PSDRUG(DRG,660)) S UCST=$P(^(660),"^",6)
 ...S TCST=LVL*UCST I 'MFLG S TTCST=TTCST+TCST I TCST=0 S TTCST=0,MFLG=1
 ...W ?46,$S(LVL:$J(LVL,4),1:"DATA MISSING"),?62,"X"
 ...W ?72,$S($D(UCST):$J(UCST,8,4),1:"DATA MISSING"),?88,"="
 ...W ?92,$S(TCST'=0:$J(TCST,14,4),1:"DATA MISSING")
 Q:OUT
 W ! F X=1:1:120 W "_"
 W !!,"Total for ",$P(^PSI(58.1,AOU,0),"^"),?35 F X=1:1:60 W "-"
 W ">",?99,$S(TTCST'=0:$J(TTCST,20,4),1:"DATA MISSING")
 Q
PAGE ;
 I $E(IOST)="C"&(PAGE>1) S DIR(0)="E" D ^DIR K DIR I Y'=1 S OUT=1 Q
 W @IOF,!,"Standard Cost Report",?109,"PAGE ",PAGE,!,?109,$P($$PSGWDT^PSGWUTL1,"@",1)
 S PAGE=PAGE+1
 W !!!,?5,"AOU",!,"ITEM",?46,"LEVEL",?72,"UNIT COST",?97,"TOTAL COST",!
 F I=1:1:120 W "_"
 W !
 Q
