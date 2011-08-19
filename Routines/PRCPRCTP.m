PRCPRCTP ;WISC/RFJ/DST-cost trend analysis (primary)                    ;26 May 93
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
PRIMARY ;  cost trend analysis for primary
 ;  There is no Cost Trend Analysis for secondary
 N %,%H,%I,DATEEND,DATESTRT,PRCPALLI,PRCPSUMM,X,X1,X2,Y
 N ODI  ; On-Demand Item flag
 K X S X(1)="The Cost Trend Analysis Report will compute the average item cost for the specified period based on the monthly opening balance last receipt cost."
 S X(2)="It will compare the computed average item cost with the current monthly opening balance average cost and display the percent increase or decrease change."
 S X(3)="The report will sort Primary inventory items by description."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Enter the date range (month-year) for computing the average item cost." D DISPLAY^PRCPUX2(2,40,.X)
 D MONTHSEL^PRCPURS2 I '$G(DATEEND) Q
 K X S X(1)="Select the Items to display." W ! D DISPLAY^PRCPUX2(2,40,.X)
 D ITEMSEL^PRCPURS4 I '$G(PRCPALLI),'$O(^TMP($J,"PRCPURS4",0)) Q
 S PRCPSUMM=$$SUMMARY^PRCPURS0 I PRCPSUMM<0 Q
 W ! S %ZIS="Q" D ^%ZIS G:POP Q I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Cost Trend Analysis",ZTRTN="DQ^PRCPRCTP"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("DATE*")="",ZTSAVE("^TMP($J,""PRCPURS4"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N AVG,CHANGE,COUNT,CURDT,CURRENT,D,DATA,DATE,DATEEDT,DATESDT,DESCR,HDR,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,TOTAL
 K ^TMP($J,"PRCPRCTP")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   I '$G(PRCPALLI),'$D(^TMP($J,"PRCPURS4",ITEMDA)) Q
 .   S DESCR=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA) S:DESCR="" DESCR=" "
 .   S (COUNT,TOTAL)=0
 .   S DATE=$E(DATESTRT,1,5) F  D  Q:DATE>$E(DATEEND,1,5)
 .   .   S D=$G(^PRCP(445.1,PRCP("I"),1,ITEMDA,1,DATE,0))
 .   .   S ^TMP($J,"PRCPRCTP",$E(DESCR,1,15),ITEMDA,DATE)=+$P(D,"^",7)
 .   .   I $P(D,"^",7) S COUNT=COUNT+1,TOTAL=TOTAL+$P(D,"^",7)
 .   .   S X1=DATE_"00",X2=40 D C^%DTC S DATE=$E(X,1,5)
 .   S AVG=$S(COUNT=0:0,1:$J(TOTAL/COUNT,0,3)),CURRENT=+$P($G(^PRCP(445.1,PRCP("I"),1,ITEMDA,1,$E(DT,1,5),0)),"^",7),CHANGE=$S(AVG=0:"***.**",1:(CURRENT-AVG)/AVG*100)
 .   S ^TMP($J,"PRCPRCTP",$E(DESCR,1,15),ITEMDA,"TOTAL")=AVG_"^"_CURRENT_"^"_CHANGE
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,Y=$E(DT,1,5)_"00" D DD^%DT S CURDT=Y
 S Y=$E(DATESTRT,1,5)_"00" D DD^%DT S DATESDT=Y,Y=$E(DATEEND,1,5)_"00" D DD^%DT S DATEEDT=Y
 S PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRCTP",DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRCTP",DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   ; On-Demand Item flag check
 .   S ODI=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   ;
 .   W !!,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,33),?35,$J(ITEMDA,6),?42,$S(ODI="Y":"D",1:""),?43,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),8)
 .   S D=$G(^TMP($J,"PRCPRCTP",DESCR,ITEMDA,"TOTAL"))
 .   W $J($P(D,"^"),9,2),$J($P(D,"^",2),10,2),$J($P(D,"^",3),10,2)
 .   I $G(PRCPSUMM) Q
 .   S DATE=0 F  D  Q:'DATE!($G(PRCPFLAG))
 .   .   S (DATA,HDR)=""
 .   .   F COUNT=1:1:9 S DATE=$O(^TMP($J,"PRCPRCTP",DESCR,ITEMDA,DATE)) Q:'DATE  S D=^(DATE) D
 .   .   .   S %=$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec","^",+$E(DATE,4,5))_" "_$E(DATE,2,3),HDR=HDR_$J(%,8)
 .   .   .   S DATA=DATA_$J(D,8,2)
 .   .   I DATA'="" W !?5,HDR,!?5,DATA
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I '$G(PRCPFLAG) D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRCTP"),^TMP($J,"PRCPURS4")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"COST TREND ANALYSIS FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 W !?5,"CUM AVG CALCULATED FROM DATE RANGE: ",DATESDT,"  TO  ",DATEEDT
 S %="",$P(%,"-",81)="" W !,"DESCRIPTION",?38,"IM",?42,"OD",$J("UNIT/IS",9),$J("CUM AVG",9),$J(CURDT,9),$J("%CHANGE",9),!,%
 Q
