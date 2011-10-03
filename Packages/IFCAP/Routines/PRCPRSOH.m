PRCPRSOH ;WISC/RFJ/DAP/VAC-days of stock on hand report ; 10/19/06 9:09am
 ;;5.1;IFCAP;**84,83,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;*83 Routine PRCPLO associated with PRC*5.1*83 is a modified copy of
 ;this routine and any changes made to this routine should also be
 ;considered for that routine as well.
 ;
 ;*98 Modified to show if Standard, On-Demand or Both
 ;
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N DATEEND,DATEENDD,DATESTRD,DATESTRT,DAYSLEFT,DIR,GROUPALL,PRCPDAYS,PRCPEND,PRCPSTRT,PRCPTYPE,TOTALDAY,X,X1,X2,Y
 N ODIFLG,ODITEM,USEFLG
 K X S X(1)="The Days Of Stock On Hand Report will print a list of items which have stock on hand less than or greater than a specified number of days."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the date range which should be used for calculating the daily usage. *** Select by month & year only. ***" D DISPLAY^PRCPUX2(2,40,.X)
 D MONTHSEL^PRCPURS2 I '$G(DATEEND) Q
 S X1=DATEEND,X2=DATESTRT D ^%DTC S TOTALDAY=X+1
 S Y=DATEEND D DD^%DT S DATEENDD=Y,Y=DATESTRT D DD^%DT S DATESTRD=Y
 W !?5,"-- TOTAL NUMBER OF DAYS: ",TOTALDAY
 ;  select greater or less
 K X S X(1)="Select the type of report: less than a specified number of days or greater than a specified number of days." D DISPLAY^PRCPUX2(2,40,.X)
 S DIR(0)="S^1:LESS;2:GREATER",DIR("A")="Print items with GREATER or LESS than 'X' days stock on hand",DIR("B")="LESS"
 D ^DIR S PRCPTYPE=+Y I 'PRCPTYPE Q
 ;  select days
 K X S X(1)="Select the number of days which the current stock on hand should be "_$S(PRCPTYPE=1:"LESS than",1:"GREATER than")_"." D DISPLAY^PRCPUX2(2,40,.X)
 S DIR(0)="N^1:365",DIR("A")="Print items with stock on hand "_$S(PRCPTYPE=1:"less than",1:"greater than")_" DAYS",DIR("B")=30
 D ^DIR S PRCPDAYS=+Y I 'PRCPDAYS Q
 ;  whse sort
 I PRCP("DPTYPE")="W" D  I '$D(PRCPSTRT) Q
 .   K X S X(1)="Select the range of NSNs to display" D DISPLAY^PRCPUX2(2,40,.X)
 .   D NSNSEL^PRCPURS0
 ;  prim/seco sort
 I PRCP("DPTYPE")'="W" D  I '$G(GROUPALL),'$O(^TMP($J,"PRCPURS1","YES",0)) W !,"*** NO GROUP CATEGORIES SELECTED !" Q
 .   K X S X(1)="Select the Group Categories to display" D DISPLAY^PRCPUX2(2,40,.X)
 .   D GROUPSEL^PRCPURS1(PRCP("I"))
 ;
ODIFLG ;*98 Set flag for Standard, On-Demand item or Both
 S ODIFLG="W"
 I PRCP("DPTYPE")'="W" S ODIFLG=$$ODIPROM^PRCPUX2(0)
 Q:ODIFLG=0
 ;
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  Q
 .   S ZTDESC="Days of Stock On Hand Report",ZTRTN="DQ^PRCPRSOH"
 .   S ZTSAVE("^TMP($J,""PRCPURS1"",")=""
 .   S ZTSAVE("DATE*")="",ZTSAVE("GROUP*")="",ZTSAVE("PRCP*")="",ZTSAVE("TOTALDAY")="",ZTSAVE("ZTREQ")="@",ZTSAVE("O*")="",ZTSAVE("U*")=""
 .   D ^%ZTLOAD
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N AVERAGE,DATE,GROUP,GROUPNM,ITEMDA,ITEMDATA,NSN,ONHAND,TOTAL,X,Y
 K ^TMP($J,"PRCPRSOH")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^(ITEMDA,0)) I ITEMDATA'="" D
 .; Select item based on selection criteria
 .   S USEFLG="Y"
 .   I PRCP("DPTYPE")'="W" D
 .   .  S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   .  I ODIFLG=1&(ODITEM="Y") S USEFLG="N"
 .   .  I ODIFLG=2&(ODITEM'="Y") S USEFLG="N"
 .   .  I ODIFLG=3 S USEFLG="Y"
 .   I USEFLG="N" Q
 .   I $$REUSABLE^PRCPU441(ITEMDA) Q
 .   ;  calculate total usage between dates
 .   S DATE=$E(DATESTRT,1,5)-.01,TOTAL=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,DATE)) Q:'DATE!(DATE>$E(DATEEND,1,5))  S TOTAL=TOTAL+$P($G(^(DATE,0)),"^",2)
 .   S AVERAGE=$J(TOTAL/TOTALDAY,0,2),ONHAND=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19)
 .   S DAYSLEFT=$S('AVERAGE&(ONHAND):9999999,'AVERAGE:0,1:ONHAND/AVERAGE\1)
 .   I PRCPTYPE=1,DAYSLEFT'<PRCPDAYS Q
 .   I PRCPTYPE=2,DAYSLEFT'>PRCPDAYS Q
 .   ;  sort for whse
 .   I PRCP("DPTYPE")="W" D  Q
 .   .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   .   I $E(NSN,1,$L(PRCPSTRT))'=PRCPSTRT,$E(NSN,1,$L(PRCPEND))'=PRCPEND I NSN']PRCPSTRT!(PRCPEND']NSN) Q
 .   .   S ^TMP($J,"PRCPRSOH",NSN,ITEMDA)=TOTAL_"^"_AVERAGE_"^"_ONHAND_"^"_$P(DAYSLEFT,".")_"^"_$P(ITEMDATA,"^",27)
 .   ;  sort for primary and secondary
 .   S GROUP=+$P(ITEMDATA,"^",21)
 .   I 'GROUP,'$G(GROUPALL) Q
 .   I $G(GROUPALL),$D(^TMP($J,"PRCPURS1","NO",GROUP)) Q
 .   I '$G(GROUPALL),'$D(^TMP($J,"PRCPURS1","YES",GROUP)) Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_" (#"_GROUP_")"
 .   S:GROUPNM="" GROUPNM=" "
 .   S ^TMP($J,"PRCPRSOH",GROUPNM,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,15),ITEMDA)=TOTAL_"^"_AVERAGE_"^"_ONHAND_"^"_$P(DAYSLEFT,".")_"^"_$P(ITEMDATA,"^",27)
 ;
 D PRINT^PRCPRSO1
 K ^TMP($J,"PRCPURS1"),^TMP($J,"PRCPRSOH")
 D ^%ZISC
 Q
