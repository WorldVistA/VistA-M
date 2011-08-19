IBCOPR ;WISC/RFJ,BOISE/WRL-print dollar amts for pre-registration ; 05 May 97  8:30 AM [7/22/03 11:59am]
 ;;2.0; INTEGRATED BILLING ;**75,345**; 21-MAR-94;Build 28
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 W !!,"This report will sort through insurance policies in the patient file"
 W !,"and print patients, bills, and payments with an insurance policy source"
 W !,"of information equal to the user selected criteria."
 ;
 N DATEEND,DATESTRT,IBCNFSUM,IBCNESOI
 ;
 ;  select date range
 W ! D DATESEL I '$G(DATEEND) Q
 ;
 ;  select Source of Information (SOI)
 W ! D SOISEL I '$D(IBCNESOI) Q
 ;
 S IBCNFSUM=$$SUMMARY I 'IBCNFSUM Q
 ;
 W !!,"Since this report has to loop through all patients and check all insurance"
 W !,"policies, it is recommended this report be queued."
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Source of Information Report",ZTRTN="DQ^IBCOPR"
 .   S ZTSAVE("DATE*")="",ZTSAVE("IBCN*")="",ZTSAVE("ZTREQ")="@"
 ;
 W !!,"<*> please wait <*>"
 ;
DQ ;  report (queue) starts here
 N AMOUNT,BILLNUM,CANCEL,CLASS,COUNTNEW,DA,DATA,DATE,DFN,INSCO,PAYMTAMT,PAYMTCNT,TOTALAMT,TOTALCNT,TRANDA,VA,Y,SOI
 K ^TMP($J,"IBCOPR")
 S COUNTNEW=0
 ;
 ;  build list of patients using source
 S INSCO=0 F  S INSCO=$O(^DPT("AB",INSCO)) Q:'INSCO  D
 .   S DFN=0 F  S DFN=$O(^DPT("AB",INSCO,DFN)) Q:'DFN  D
 .   .   S DA=0 F  S DA=$O(^DPT("AB",INSCO,DFN,DA)) Q:'DA  D
 .   .   .   S DATA=$G(^DPT(DFN,.312,DA,1))
 .   .   .   S DATE=$P($P(DATA,"^",10),".")
 .   .   .   S SOI=$P(DATA,"^",9)
 .   .   .   ;
 .   .   .   ; Check for existence of SOI
 .   .   .   I $G(SOI)="" Q
 .   .   .   ;
 .   .   .   ;  check source of information
 .   .   .   I $G(IBCNESOI)'=1,$G(IBCNESOI(SOI))="" Q
 .   .   .   ;
 .   .   .   ;  build list of all patients
 .   .   .   D PID^VADPT
 .   .   .   S Y=$P(DATE,".") D DD^%DT
 .   .   .   S ^TMP($J,"IBCOPR","ALL",DFN,INSCO)=$P($G(^DPT(DFN,0)),"^")_"^"_$G(VA("BID"))_"^"_Y_"^"_SOI
 .   .   .   ;
 .   .   .   ;  check date of source of information
 .   .   .   I DATE<DATESTRT!(DATE>DATEEND) Q
 .   .   .   ;
 .   .   .   ;  build list of patients match during select date range
 .   .   .   S COUNTNEW(SOI)=$G(COUNTNEW(SOI))+1
 .   .   .   S COUNTNEW=COUNTNEW+1
 .   .   .   S ^TMP($J,"IBCOPR","NEW",SOI,DFN,INSCO)=""
 ;
 ;  get charges and payments
 S DFN=0 F  S DFN=$O(^TMP($J,"IBCOPR","ALL",DFN)) Q:'DFN  D
 .   S INSCO=0 F  S INSCO=$O(^TMP($J,"IBCOPR","ALL",DFN,INSCO)) Q:'INSCO  D
 .   .   S SOI=$P(^TMP($J,"IBCOPR","ALL",DFN,INSCO),"^",4)
 .   .   S DA=0 F  S DA=$O(^DGCR(399,"AE",DFN,INSCO,DA)) Q:'DA  D
 .   .   .   ;  date first printed, bill classification
 .   .   .   S DATE=$P($P($G(^DGCR(399,DA,"S")),"^",12),".")
 .   .   .   S CLASS=$P($G(^DGCR(399,DA,0)),"^",5)
 .   .   .   ;
 .   .   .   ;  check for 1 or 2 inpatient, 3 or 4 outpatient
 .   .   .   S CLASS=$S(CLASS<3:1,1:3)
 .   .   .   ;
 .   .   .   ;  bill canceled
 .   .   .   S CANCEL="" I $P($G(^DGCR(399,DA,"S")),"^",16)=1 S CANCEL="*"
 .   .   .   S BILLNUM=$P($G(^DGCR(399,DA,0)),"^")
 .   .   .   S AMOUNT=+$$ORI^PRCAFN(DA) I AMOUNT'>0 Q
 .   .   .   ;
 .   .   .   I DATE'<DATESTRT,DATE'>DATEEND D
 .   .   .   .   S ^TMP($J,"IBCOPR","BILL",SOI,CLASS,DATE,DA)=DFN_"^"_INSCO_"^"_CANCEL_"^"_BILLNUM_"^"_AMOUNT
 .   .   .   .   I CANCEL="" S TOTALCNT(SOI,CLASS)=$G(TOTALCNT(SOI,CLASS))+1,TOTALAMT(SOI,CLASS)=$G(TOTALAMT(SOI,CLASS))+AMOUNT
 .   .   .   ;
 .   .   .   ;  get payments
 .   .   .   S TRANDA=0 F  S TRANDA=$O(^PRCA(433,"C",DA,TRANDA)) Q:'TRANDA  D
 .   .   .   .   S DATA=$G(^PRCA(433,TRANDA,1))
 .   .   .   .   ;  transaction type 2 and 34 are payments
 .   .   .   .   I $P(DATA,"^",2)'=2,$P(DATA,"^",2)'=34 Q
 .   .   .   .   S DATE=$P($P(DATA,"^",9),".")
 .   .   .   .   I DATE<DATESTRT!(DATE>DATEEND) Q
 .   .   .   .   I '$P($G(^PRCA(433,TRANDA,0)),"^",4) Q
 .   .   .   .   S AMOUNT=$P($G(^PRCA(433,TRANDA,3)),"^")
 .   .   .   .   S ^TMP($J,"IBCOPR","TRAN",SOI,CLASS,DATE,DA)=DFN_"^"_INSCO_"^"_CANCEL_"^"_TRANDA_"^"_$P(DATA,"^",2)_"^"_AMOUNT
 .   .   .   .   I CANCEL="" S PAYMTCNT(SOI,CLASS)=$G(PAYMTCNT(SOI,CLASS))+1,PAYMTAMT(SOI,CLASS)=$G(PAYMTAMT(SOI,CLASS))+AMOUNT
 ;
 S SOI=0
 F  S SOI=$O(TOTALCNT(SOI)) Q:SOI=""  I $G(COUNTNEW(SOI))="" S COUNTNEW(SOI)=0
 F  S SOI=$O(PAYMTCNT(SOI)) Q:SOI=""  I $G(COUNTNEW(SOI))="" S COUNTNEW(SOI)=0
 D PRINT^IBCOPR1
 ;
 D ^%ZISC
 K ^TMP($J,"IBCOPR")
 Q
 ;
 ;
DATESEL ;  select starting and ending dates in days
 ;  returns datestrt and dateend
 N %,%DT,%H,%I,DEFAULT,X,Y
 K DATEEND,DATESTRT
START S Y=$E(DT,1,5)_"01" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S DATESTRT=Y
 S Y=DT D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START
 S DATEEND=Y,Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
 ;
 ;;
SOISEL ; Select one SOI (source of information) or ALL - File #355.12
 NEW DIC,DTOUT,DUOUT,X,Y,CT,Q
 K IBCNESOI S CT=0 W !?5,"Enter Sources of Information to include one at a time."
SOISEL1 S DIC(0)="AMEQ"
 S Q="Include Source of Information"
 I CT=0 S Q=Q_" (<RETURN> for ALL)"
 E  S Q="Also "_Q
 S DIC("A")=$$FO^IBCNEUT1(Q_": ",50,"R")
 S DIC="^IBE(355.12,"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) G SOISELX
 ; If nothing was selected (Y=-1), select ALL sources
 I Y=-1 G SOISELX:CT=1 S IBCNESOI=1 G SOISELX
 S IBCNESOI($P(Y,"^",1))=$P(Y,"^",2),CT=1 G SOISEL1
 ;
SOISELX ; SOISEL exit pt
 Q
 ;
SUMMARY() ;  ask to print detailed or summary report
 N DIR,DIRUT,X,Y
 S DIR(0)="SOA^D:detailed;S:summary;",DIR("B")="summary"
 S DIR("A")="Type of report to print: "
 W ! D ^DIR
 I $D(DIRUT) Q 0
 Q $S(Y="S":1,Y="D":2,1:0)
 ;
