RMPRSP7 ;HIN/RVD-PRINT 2319 WITHOUT SUSPENSE LINK ;3/17/03  08:13
 ;;3.0;PROSTHETICS;**62,69,77,135**;Feb 09, 1996;Build 12
 ;RVD 8/27/01 patch #62 - PCE data print
 ;RVD 4/9/02 patch #69 -  Disregard Historical data
 ;RVD 3/17/02 patch #77 - Fixed For Loop to include all PT 2319 records
 ;                        that are not linked
 ;RGB 3/22/07 patch 135 - Modified code to check issues in 660 against file 668 suspense records
 ;                        in addition to current check of complete flag in issue record.
 ;
 D DIV4^RMPRSIT I $D(Y),(Y<0) Q
 ; Prompt for Start Date
STDT ;RMPRSDT is start date in FM internal form.
 K %DT,X,Y
 S %DT("A")="Starting Date: "
 S %DT(0)=-DT
 S %DT="AEP"
 D ^%DT I Y<0 G EXIT1
 S RMPRSDT=$P(Y,".",1)
 S %DT("A")="Ending Date: ",%DT="AEX" D ^%DT G:Y<0 EXIT1
 S RMPREDT=$P(Y,".",1)
 I RMPRSDT>RMPREDT W !,$C(7),"Invalid Date Range Selection!!" G STDT
 ;
CONT G:'$D(RMPRSDT) EXIT1 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT1 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PROSTHETIC PATIENT RECORDS WITHOUT SUSPENSE",ZTRTN="PRINT^RMPRSP7",ZTIO=ION,ZTSAVE("RMPRSDT")=""
 S ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMPR(")="",ZTSAVE("RMPREDT")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT
 ;
PRINT I $E(IOST)["C" W !!,"Processing report......."
 K ^TMP($J)
 K %DT,X,Y
 S X="NOW" D ^%DT S RMDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 S RMPAGE=1,(RMTOBAL,RMPREND)=0,RS=RMPR("STA")
 S RDT=RMPRSDT-1,RET=RMPREDT+1,RS=RMPR("STA")
 S Y=RMPRSDT D DD^%DT S RMSDAT=Y
 S Y=RMPREDT D DD^%DT S RMEDAT=Y
 D BUILD
 I '$D(^TMP($J)) D HEAD,NONE G EXIT
 D HEAD,HEAD1
 D WRITE
 G EXIT
 ;
BUILD ;build a tmp global.
 F RI=RDT:0:RET S RI=$O(^RMPR(660,"B",RI)) Q:(RI'>0)!(RMPREND)!(RI>RMPREDT)  F RJ=0:0 S RJ=$O(^RMPR(660,"B",RI,RJ)) Q:(RJ'>0)  D
 .;don't include if O2 transactions.
 .Q:$D(^RMPO(665.72,"AC",RJ))
 .S RM0=$G(^RMPR(660,RJ,0))
 .S RM10=$G(^RMPR(660,RJ,10))
 .Q:($P(RM0,U,13)=13)!($P(RM0,U,15)="*")
 .Q:($P(RM10,U,14)>0)!($P(RM0,U,10)'=RMPR("STA"))
 .;FILTER SHIPPING CHARGES AND DDC TRANSACTIONS
 .Q:($P(RM0,U,17)'="")!($P(RM0,U,13)=16)
 .S RMIE68=$O(^RMPR(668,"F",RJ,0))
 .I RMIE68,$D(^RMPR(668,RMIE68,10,"B",RJ)) Q
 .I $P(RM0,U,10)=RS D
 ..S RMDFN=$P(RM0,U,2)
 ..S RMITIEN=$P(RM0,U,6)
 ..S (RMITEM,RMPAT)=""
 ..I RMITIEN,($D(^RMPR(661,RMITIEN,0))),($D(^PRC(441,$P(^RMPR(661,RMITIEN,0),U,1),0))) D
 ...S RMITEM=$P(^PRC(441,$P(^RMPR(661,RMITIEN,0),U,1),0),U,2)
 ..S RMITEM=$E(RMITEM,1,18)
 ..I $D(^DPT(RMDFN,0)) S RMPAT=$E($P(^DPT(RMDFN,0),U,1),U,15)
 ..S RMSUSP=$P(RM10,U,1)
 ..S RMRXDT=$P(RM10,U,2)
 ..S RMIADT=$P(RM10,U,3)
 ..S RCDT=$P(RM10,U,4)
 ..S RMAMT=$P(RM0,U,16)
 ..S RMSRC=RJ
 ..S RMPRDI=$P(RM10,U,7)
 ..S RMINIE=$P(RM0,U,27)
 ..S RMCOSU=$P(RM10,U,9)
 ..S RMSUST=$P(RM10,U,11)
 ..S RMPCEP=$P(RM10,U,12)
 ..S RPDT=$P(RM10,U,13)
 ..I RMINIE,$D(^VA(200,RMINIE,0)) S RMINI=$E($P(^VA(200,RMINIE,0),U,1),1,10)
 ..E  S RMINI=""
 ..S RDDT=$E(RI,4,5)_"/"_$E(RI,6,7)_"/"_$E(RI,2,3)
 ..S:RPDT'="" RPDT=$E(RPDT,4,5)_"/"_$E(RPDT,6,7)_"/"_$E(RPDT,2,3)
 ..S:RCDT'="" RCDT=$E(RCDT,4,5)_"/"_$E(RCDT,6,7)_"/"_$E(RCDT,2,3)
 ..S ^TMP($J,RI,RMPAT,RJ)=RMITEM_"^"_RDDT_"^"_RMAMT_"^"_RMSRC_"^"_RMINI_"^"_RPDT_"^"_$E(RMPRDI,1,10)
 Q
 ;
WRITE ;write report to a selected device
 S (RMPREND,RI,RM)=0
 F  S RI=$O(^TMP($J,RI)) Q:(RI'>0)!(RMPREND)  S RJ="" F  S RJ=$O(^TMP($J,RI,RJ)) Q:(RJ="")!(RMPREND)  F  S RM=$O(^TMP($J,RI,RJ,RM)) Q:(RM'>0)!(RMPREND)  D
 .S RMDAT=$G(^TMP($J,RI,RJ,RM))
 .S RMPAT=RJ
 .S RMITEM=$P(RMDAT,U,1)
 .S RDDT=$P(RMDAT,U,2)
 .S RMAMT=$P(RMDAT,U,3)
 .S RMSRC=$P(RMDAT,U,4)
 .S RMINI=$P(RMDAT,U,5)
 .S RPDT=$P(RMDAT,U,6)
 .S RMPRDI=$E($P(RMDAT,U,7),1,12)
 .W !,RDDT,?10,RMPAT,?26,RMITEM,?45,$J(RMAMT,8,2),?57,RMSRC,?67,RMINI
 .S RMPRFLG=1
 .I $E(IOST)["C"&($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD,HEAD1 Q
 .I $Y>(IOSL-6) W @IOF D HEAD,HEAD1 K RMPRFLG Q
 W !,RMPR("L")
 W !,"<End of Report>"
 Q
 ;
HEAD W !,"PROSTHETICS PATIENT RECORDS NOT LINKED TO SUSPENSE  Run Date:",RMDATE,?70,"PAGE: ",RMPAGE
 W !,"Start Date: ",RMSDAT,?26,"End Date: ",RMEDAT,?51,"station: ",$E($P($G(^DIC(4,RS,0)),U,1),1,19)
 S RMPAGE=RMPAGE+1
 Q
 ;
HEAD1 I $E(IOST)["C"&($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD
 I $E(IOST)'["C"&($Y>(IOSL-6)) W @IOF D HEAD
 W !,RMPR("L")
 W !,"DATE",?10,"PATIENT",?26,"ITEM",?49,"COST",?57,"VISTA #",?67,"INITIATOR"
 W !,"----",?10,"-------",?26,"----",?49,"----",?57,"-------",?67,"---------"
 S RMPRFLG=1
 Q
 ;
EXIT I $E(IOST)["C",'RMPREND K DIR S DIR(0)="E" D ^DIR
EXIT1 D ^%ZISC
 K ^TMP($J)
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
NONE W !!,"NO DATA TO PRINT !!!!!"
 Q
