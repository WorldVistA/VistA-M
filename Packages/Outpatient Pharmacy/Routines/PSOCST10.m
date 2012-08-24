PSOCST10 ;BHAM ISC/SAB - high cost report ; 12/11/96 13:47
 ;;7.0;OUTPATIENT PHARMACY;**31,56,331,398**;DEC 1997;Build 10
 ;this routine list rxs that cost over a specified $ amount for a specified date range
 ;External Ref. ^PSDRUG( is supp. by DBIA# 221
BEG W ! S %DT(0)=-DT,%DT("A")="Beginning Date: ",%DT="APE" D ^%DT G:Y<0!($D(DTOUT)) EXIT S (%DT(0),BEGDATE)=Y
 W ! S %DT("A")="Ending Date: " D ^%DT G:Y<0!($D(DTOUT)) EXIT S ENDDATE=Y D:+$E(Y,6,7)=0 DTC
MAX K DIR S DIR("A")="Dollar Limit ",DIR("B")=30,DIR(0)="N^0:9999:2",DIR("?")="Enter a dollar amount between 0-9999 with no more than two decimals or ^ quit"
 D ^DIR K DIR G:$D(DIRUT) EXIT S MAX=Y
DEV K %ZIS,IOP,POP,ZTSK S PSOION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION W !,"Please try later!" G EXIT
 K PSOION I $D(IO("Q")) D  G EXIT
 .S ZTDESC="Outpatient High Cost Report",ZTRTN="START^PSOCST10" F G="BEGDATE","ENDDATE","MAX" S:$D(@G) ZTSAVE(G)=""
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
START U IO S PAGE=1,(CNT,TCOST)=0 D HD
 F NDT=BEGDATE:1:ENDDATE F TY="AL","AM" S PSDT=NDT-1_".999999" D ST1 Q:$D(DIRUT)  ;*331
 Q:$D(DIRUT)  D HD:($Y+4)>IOSL
 D:'$D(DIRUT) FT
EXIT W ! D ^%ZISC K XTYPE,DIR,DTOUT,DUOUT,DIROUT,DIRUT,^TMP($J),NDT,TY,BEGDATE,CNT,COST,TCOST,DR0,DRCST,ENDDATE,MAX,PAGE,PGM,POP,PSDT,PSFILL,PSRXN,QTY,RX0,RX1,VAR,X,Y,%DT
 S:$D(ZTQUEUED) ZTREQ="@" Q
ST1 F  S PSDT=$O(^PSRX(TY,PSDT)) Q:'PSDT!(PSDT>(NDT_".999999"))  D ST2 Q:$D(DIRUT)
 Q
ST2 S PSRXN=0 F  S PSRXN=$O(^PSRX(TY,PSDT,PSRXN)) Q:'PSRXN  D ST3 Q:$D(DIRUT)
 Q
ST3 S PSFILL=""
 F  S PSFILL=$O(^PSRX(TY,PSDT,PSRXN,PSFILL)) Q:PSFILL=""  D CHK Q:$D(DIRUT)
 Q
CHK Q:'$D(^PSRX(PSRXN,0))!(+$P(^PSRX(PSRXN,"STA"),"^")=13)  S RX0=^(0) Q:'$D(^PSDRUG(+$P(RX0,"^",6),0))  S DR0=^(0)
 I TY="AL" S:PSFILL RX1=$G(^PSRX(PSRXN,1,PSFILL,0)) Q:PSFILL&($G(RX1)="")
 I TY="AM" Q:'$P($G(^PSRX(PSRXN,"P",PSFILL,0)),"^",19)  S RX1=^(0)
 S DRCST=$S('PSFILL&(+$P(RX0,"^",17)):$P(RX0,"^",17),PSFILL&(+$P($G(RX1),"^",11)):$P($G(RX1),"^",11),1:0)
 S QTY=$S('PSFILL:+$P(RX0,"^",7),1:+$P(RX1,"^",4))
 I 'DRCST S DRCST=$S($P($G(^PSDRUG(+$P(RX0,"^",6),660)),"^",6):+$P(^(660),"^",6),1:0)
 S COST=QTY*DRCST Q:COST<MAX
 Q:$D(DIRUT)  D HD:($Y+4)>IOSL
 Q:$D(DIRUT)  W !,$S(PSFILL&(TY="AL"):"*",TY="AM":"%",1:" ")_$P(RX0,"^"),?11,$E($P(DR0,"^"),"^",40),?51,$J(QTY,6),?60,$J(DRCST,6,3),?68,$J(COST,12,2) S CNT=CNT+1,TCOST=TCOST+COST
 Q
HD I PAGE>1,$E(IOST)="C" S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q:$D(DIRUT)  W @IOF,!,"Fills That Cost at Least $"_MAX_" for the Period: " S Y=BEGDATE D DT^DIO2 W " to " S Y=ENDDATE D DT^DIO2 W ?72,"Page "_PAGE,!,"Run Date: " S Y=DT D DT^DIO2 S PAGE=PAGE+1
 W !!,"Rx #",?11,"Drug",?54,"QTY",?59,"Un.Cost",?70,"Total Cost"
 W ! F I=1:1:80 W "-"
 Q
FT W ! F I=1:1:80 W "-"
 S TCOST="Total Cost = "_$FN(TCOST,",",2)
 W !,"No. of Fills = "_CNT,?50,$J(TCOST,30)
 W ! F I=1:1:80 W "-"
 W !,"(* indicates a refill, % indicates a partial) "
 Q
DTC N DD,MM S DD=31,MM=+$E(Y,4,5) I MM'=12 S MM=MM+1,MM=$S(MM<10:"0",1:"")_MM,X2=Y,X1=$E(Y,1,3)_MM_"00" D ^%DTC S DD=X
 S ENDDATE=Y+DD
 Q
