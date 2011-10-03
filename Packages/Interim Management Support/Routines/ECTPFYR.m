ECTPFYR ;B'ham ISC/PTD-VAMC Staffing Report by Fiscal Year ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ECT(731)) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'VAMC Management' File - #731 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ECT(731,0)) W *7,!!,"'VAMC Management' File - #731 has not been populated on your system.",!! S XQUIT="" Q
 W !,"You may select the fiscal year RANGE for this report.",!,"(Up to 5 years of data may be displayed.)",!!
BYR S %DT="AE",%DT("A")="Enter BEGINNING fiscal year: ",%DT(0)=2700000 D ^%DT K %DT G:$D(DTOUT)!("^"[X) EXIT S BYRDA=$E(Y,1,3)
EYR S %DT="AE",%DT("A")="Enter ENDING fiscal year: ",%DT(0)=BYRDA_"0000" D ^%DT K %DT G:$D(DTOUT)!("^"[X) EXIT S EYRDA=$E(Y,1,3)
 I EYRDA-BYRDA>4 W *7,!!,"Only a 5 year range may be shown on one report!",!! K BYRDA,EYRDA,X,Y G BYR
 S FLG=0 F YR=BYRDA:1:EYRDA I $D(^ECT(731,YR,10,0)) S FLG=1
 I FLG=0 W *7,!!,"There is NO DATA in the file for the selected date range!",!! G EXIT
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^ECTPFYR",ZTDESC="VAMC Staffing Report by Fiscal Year",ZTSAVE("BYRDA")="",ZTSAVE("EYRDA")=""
 I  D ^%ZTLOAD K ZTSK G EXIT
 U IO
 ;
ENQ ;ENTRY POINT WHEN QUEUED
 K ^TMP($J) S CNT=0 F YR=BYRDA:1:EYRDA S SRV=0,CNT=CNT+1 F J=0:0 S SRV=$O(^ECT(731,YR,10,SRV)) Q:'SRV  S FTEE=$P(^ECT(731,YR,10,SRV,0),"^",2),^TMP($J,SRV,YR)=FTEE
 S PGCT=1,QFLG="",$P(LN,"-",80)="" D HDR
SRV F SRV=0:0 S SRV=$O(^TMP($J,SRV)) Q:'SRV  D WRTLN G:QFLG EXIT
 ;
EXIT K ^TMP($J),%,%H,%I,BYRDA,CNT,COL,CT,DTOUT,DIR,EYRDA,FLG,FTEE,INCR,J,LN,PGCT,POP,QFLG,SRV,X,Y,YEAR,YR,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC I IO="" S IOP="HOME" D ^%ZIS
 Q
 ;
HDR ;PRINT REPORT MAIN HEADER
 W @IOF,!?25,"VAMC STAFFING TRENDS BY SERVICE",!?21,"ASSIGNED FTEE FOR FY: "_(1700+BYRDA)_" TO FY: "_(1700+EYRDA) D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") W !!?45,Y,?70,"PAGE ",PGCT S PGCT=PGCT+1
 W !!?10,"SERVICE" S CT=0,INCR=9,COL=27 F YR=BYRDA:1:EYRDA S CT=CT+1,COL=COL+INCR W:CT'>CNT ?COL,"FY "_$E(((BYRDA-1)+CT),2,3)
 W !,LN
 Q
 ;
WRTLN D:$Y+5>IOSL PRTCHK Q:QFLG  W !,$P(^ECC(730,SRV,0),"^") S CT=0,INCR=9,COL=25
 F YEAR=BYRDA:1:EYRDA S CT=CT+1,COL=COL+INCR D FTEE W:CT'>CNT ?COL,$S(FTEE="":"NO DATA",1:$J(FTEE,8,3))
 Q
 ;
FTEE I '$D(^TMP($J,SRV,YEAR)) S FTEE="" Q
 S FTEE=$P(^TMP($J,SRV,YEAR),"^")
 Q
 ;
PRTCHK I $E(IOST)="C" S DIR(0)="E" D ^DIR I Y=0 S QFLG=1 Q
 D HDR
 Q
 ;
