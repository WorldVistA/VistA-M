DVBCNTSC ;ALB ISC/THM-REQUESTS NOT SCHEDULED IN THREE DAYS ; 9/28/91  8:13 AM
 ;;2.7;AMIE;**2,19**;Apr 10, 1995
 ;;
 D HOME^%ZIS S (PG,TOTAL)=0
 S Y=DT X ^DD("DD") S DVBCDT(0)=Y D NOW^%DTC S DVBCNOW=% K %
 G EN
 ;
PRINT S DTA=^DVB(396.3,DA,0),DFN=$P(DTA,U,1),DTRPT=$P(DTA,U,5),RQSTAT=$P(DTA,U,18),REQCA=$P(DTA,U,19) Q:(RQSTAT["X"!(REQCA'=""))  ;cancelled requests
 S Y=DTRPT X ^DD("DD") S DTRPT2=Y,RO=$P(DTA,U,3),RO=$S($D(^DIC(4,+RO,0)):$P(^(0),U,1),1:"Unknown RO"),DTSCH=$P(DTA,U,6),Y=DTSCH X ^DD("DD") S DTSCH2=Y K DTA
 S DAYS=0 I DTSCH="" S X1=DVBCNOW,X2=DTRPT D ^%DTC Q:X'>3  S DAYS=X
 I DTSCH]"" S X1=DTSCH,X2=DTRPT D ^%DTC Q:X'>3  S DAYS=X
 W PNAM,?33,^TMP($J,RQDT,PNAM,DA),?45,DTRPT2,?69,DTSCH2,?93,RO,?119,DAYS,! S TOTAL=TOTAL+1 I $Y>55 D HDR
 Q
 ;
EN W @IOF,"2507 Exams Not Scheduled Within Three Days",!!!
 S %DT(0)=-DT,%DT="AE",%DT("A")="Enter STARTING DATE REPORTED TO MAS: " D ^%DT G:Y<0 EXIT S SDATE2=Y,SDATE=Y-.5
 S %DT("A")="    and ENDING DATE REPORTED TO MAS: " D ^%DT G:Y<0 EXIT S EDATE2=Y,EDATE=Y+.2359
 K %DT S HD="2507 Requests Not Scheduled in Three Days at "_$$SITE^DVBCUTL4,HD2="From " S Y=$E(SDATE2,1,7) X ^DD("DD") S HD2=HD2_Y S Y=$E(EDATE2,1,7) X ^DD("DD") S HD2=HD2_" to "_Y
 ;
DEV W !! S %ZIS="AEQ" D ^%ZIS G:POP EXIT
 I IOM<132 W *7,!!,"A right margin of 132 is required for this output!",!! G DEV
 I $D(IO("Q")) S ZTIO=ION,ZTRTN="GO^DVBCNTSC",ZTDESC="2507 exams not scheduled in 3 days" F I="TOTAL","PG","SDATE*","EDATE*","HD*","DVBC*" S ZTSAVE(I)=""
 I  D ^%ZTLOAD W:$D(ZTSK) *7,!!,"Request queued.",!! G EXIT
 ;
GO K ^TMP($J) ;S X1=SDATE,X2=-7 D C^%DTC S SDATE=X ;allow for last month since using date reported
 U IO D HDR F RQDT=SDATE:0 S RQDT=$O(^DVB(396.3,"C",RQDT)) Q:RQDT=""!(RQDT>EDATE)  F DA=0:0 S DA=$O(^DVB(396.3,"C",RQDT,DA)) Q:DA=""  S X=$P(^DVB(396.3,DA,0),U,5) I X'<SDATE,X'>EDATE D GO1
 S PNAM="" F RQDT=0:0 S RQDT=$O(^TMP($J,RQDT)) Q:RQDT=""  F ZI=0:0 S PNAM=$O(^TMP($J,RQDT,PNAM)) Q:PNAM=""  F DA=0:0 S DA=$O(^TMP($J,RQDT,PNAM,DA)) Q:DA=""  D PRINT
 W !!,"Total requests: ",TOTAL,!!
 ;
EXIT D:$D(ZTQUEUED) KILL^%ZTLOAD K DTRPT,DTRPT2,REQCA G KILL^DVBCUTIL
 ;
GO1 ;request can be included only if at least one exam wasn't transferred out
 S TFIND=0,COUNT=0
 F XI=0:0 S XI=$O(^DVB(396.4,"C",DA,XI)) Q:XI=""  D
 .S COUNT=COUNT+1
 .I $D(^DVB(396.4,XI,"TRAN")) S TFIND=TFIND+1
 ;if TFIND=COUNT then all exams are transferred, so do not consider for report
 I TFIND<COUNT D
 .S DFN=$P(^DVB(396.3,DA,0),U,1)
 .S NAME=$S($D(^DPT(DFN,0)):$P(^(0),U,1),1:"patient file record missing")
 .S DVBCSSN=$S($D(^DPT(DFN,0)):$P(^(0),U,9),1:"")
 .S ^TMP($J,$E(RQDT,1,7),NAME,DA)=DVBCSSN K DVBCSSN,DFN,NAME
 Q
 ;
HDR S PG=PG+1 I (IOST?1"C-".E)!(PG>1) W @IOF
 W DVBCDT(0),?(IOM-$L(HD)\2),HD,?(IOM-9),"Page: ",PG,!?(IOM-$L(HD2)\2),HD2,!!!
 W "Veteran name",?33,"SSN",?45,"Date reported-MAS",?69,"Date scheduled",?93,"Requested by",?119,"Days",!
 F LINE=1:1:IOM W "-"
 W !! Q
