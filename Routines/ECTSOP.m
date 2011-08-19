ECTSOP ;B'ham ISC/PTD-Outpatient Workload Trends by Fiscal Year ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ECT(731)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Management' File - #731 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731,0)) W *7,!!,"'VAMC Management' File - #731 has not been populated on your system.",!! S XQUIT="" Q
 W !,"You may select the fiscal year RANGE for this report.",!,"(Up to 5 years of data may be displayed.)",!!,"Enter ONLY the 2 or 4 digit year!",!
BYR S %DT="AE",%DT("A")="Enter BEGINNING fiscal year: ",%DT(0)=2700000 D ^%DT K %DT G:$D(DTOUT)!("^"[X) EXIT S BYRDA=$E(Y,1,3),BYR=$E(Y,2,3)
EYR S %DT="AE",%DT("A")="Enter ENDING fiscal year: ",%DT(0)=BYRDA_"0000" D ^%DT K %DT G:$D(DTOUT)!("^"[X) EXIT S EYRDA=$E(Y,1,3),EYR=$E(Y,2,3)
 I EYRDA-BYRDA>4 W *7,!!,"Only a 5 year range may be shown on one report!",!! K BYRDA,BYR,EYRDA,EYR,X,Y G BYR
 S FLG=0 F YR=BYRDA:1:EYRDA I $D(^ECT(731,YR,40,0)) S FLG=1
 I FLG=0 W *7,!!,"There is NO DATA in the file for the selected date range!",!! G EXIT
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^ECTSOP",ZTDESC="Outpatient Workload Trends by Fiscal Year",ZTSAVE("BYRDA")="",ZTSAVE("EYRDA")=""
 I  D ^%ZTLOAD K ZTSK G EXIT
 U IO
 ;
ENQ ;ENTRY POINT WHEN QUEUED
 K ^TMP($J) S CNT=0 F YR=BYRDA:1:EYRDA S OPT=0,CNT=CNT+1,TOT(YR)=0 F J=0:0 S OPT=$O(^ECT(731,YR,40,OPT)) Q:'OPT  S LCN=$P(^DG(40.8,OPT,0),"^"),VST=$P(^ECT(731,YR,40,OPT,0),"^",2),^TMP($J,LCN,YR)=VST
 S PGCT=1,(OPT,QFLG)="",$P(LN,"-",81)="" D HDR
LCN F K=0:0 S OPT=$O(^TMP($J,OPT)) Q:OPT=""  D WRTLN G:QFLG EXIT
WRTOT W !?34 F J=1:1:46 W "-"
 W !?14,"TOTAL VISITS:" S CT=0,INCR=9,COL=25 F YEAR=BYRDA:1:EYRDA S CT=CT+1,COL=COL+INCR S TOT=$P(TOT(YEAR),"^") W:CT'>CNT ?COL,$S(TOT=0:" NO DATA",1:$J(TOT,7))
 ;
EXIT K ^TMP($J),%,%H,%I,BYR,BYRDA,CNT,COL,CT,DTOUT,DIR,DSCH,EYR,EYRDA,FLG,INCR,J,K,LCN,LN,OPT,PGCT,POP,QFLG,TOT,VST,X,Y,YEAR,YR,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC I IO="" S IOP="HOME" D ^%ZIS
 Q
 ;
HDR ;PRINT REPORT MAIN HEADER
 W @IOF,!?25,"VAMC OUTPATIENT WORKLOAD TRENDS",!?24,"VISITS FROM FY: "_(1700+BYRDA)_" TO FY: "_(1700+EYRDA) D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") W !!?45,Y,?70,"PAGE ",PGCT S PGCT=PGCT+1
 W !!?10,"LOCATION" S CT=0,INCR=9,COL=27 F YR=BYRDA:1:EYRDA S CT=CT+1,COL=COL+INCR W:CT'>CNT ?COL,"FY "_$E(((BYRDA-1)+CT),2,3)
 W !,LN
 Q
 ;
WRTLN D:$Y+5>IOSL PRTCHK Q:QFLG  W !,OPT S CT=0,INCR=9,COL=26
 F YEAR=BYRDA:1:EYRDA S CT=CT+1,COL=COL+INCR D VISIT S TOT(YEAR)=TOT(YEAR)+VST W:CT'>CNT ?COL,$S(VST="":"NO DATA",1:$J(VST,6))
 Q
 ;
VISIT I '$D(^TMP($J,OPT,YEAR)) S VST="" Q
 S VST=$P(^TMP($J,OPT,YEAR),"^")
 Q
 ;
PRTCHK I $E(IOST)="C" S DIR(0)="E" D ^DIR I Y=0 S QFLG=1 Q
 D HDR
 Q
 ;
