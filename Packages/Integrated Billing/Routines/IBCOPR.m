IBCOPR ;WISC/RFJ,BOISE/WRL - print dollar amts for pre-registration ;05 May 97  8:30 AM [7/22/03 11:59am]
 ;;2.0;INTEGRATED BILLING;**75,345,528,664,668**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;IA - 3336 (IB REFERENCING 433)
 ;ib
 W !!,"This report will print bills and payments within the user selected"
 W !,"date range that are associated to an insurance policy with a source"
 W !,"of information equal to the user selected criteria."
 ;
 N CT,DATEEND,DATESTRT,DATETYPE,ENDDATE,IBCNFSUM,IBCNESOI,IBCNOUT,IBCNSORT,Q,WIDTH,X,Y
 ;
DATETYPE ;
 ;Prompt for the type of date to report on.
 S DIR(0)="S^B:Billed Date;C:Collected Date",DIR("B")=""
 S DIR("A")="Report by (B)ill Date or by (C)ollected Date?"
 S DIR("?")="Enter B or C"
 S DIR("??")="^D BCHELP^IBCOPR"
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G EXIT
 S DATETYPE=Y K DIR,Y
 ;
DATESEL ;Select Start and End Date
 ;Get Start Date
 S DIR(0)="DA^::EX",DIR("B")=$$FMTE^XLFDT($E(DT,1,5)_"01")
 S DIR("A")="Starting "_$S(DATETYPE="B":"Billed",1:"Collected")_" Date: "
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G EXIT
 I Y>DT W !,"FUTURE DATES ARE NOT ALLOWED." G DATESEL
 S DATESTRT=Y K DIR,Y
 ;
ENDDATE ;
 ;Get End Date
 S DIR(0)="DA^::EX",DIR("B")=$$FMTE^XLFDT(DT)
 S DIR("A")="  Ending "_$S(DATETYPE="B":"Billed",1:"Collected")_" Date: "
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G EXIT
 I Y>DT W !,"FUTURE DATES ARE NOT ALLOWED." G ENDDATE
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE." G ENDDATE
 S DATEEND=Y K DIR,Y
 W !!?5,"***  Selected ",$S(DATETYPE="B":"Billed",1:"Collected")_" Date"," range from ",$$FMTE^XLFDT(DATESTRT)," to ",$$FMTE^XLFDT(DATEEND),"  ***",!
 ;
 ;  select Source of Information (SOI)
SOISEL ; Select one SOI (source of information) or ALL - File #355.12
 S CT=0 W !,"Enter Sources of Information to include one at a time OR <RETURN> for ALL."
SOISEL1 S DIC(0)="AMEQ"
 S Q="Include Source of Information"
 I CT S Q="Also "_Q
 S DIC("A")=$$FO^IBCNEUT1(Q_": ",36,"R")
 S DIC="^IBE(355.12,"
 D ^DIC K DIC
 I $D(DUOUT)!$D(DTOUT) G EXIT
 ; If nothing was selected (Y=-1), select ALL sources
 I Y=-1 G SUMMARY:CT=1 S IBCNESOI="A" G SUMMARY
 S IBCNESOI($P(Y,"^",1))=$P(Y,"^",2),IBCNESOI=$G(IBCNESOI)+1,CT=1 G SOISEL1
 ;
SUMMARY ;  ask to print detailed or summary report
 S DIR(0)="S^D:Detailed;S:Summary;",DIR("B")="Summary"
 S DIR("A")="Print (D)etailed or (S)ummary report?"
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G EXIT
 S IBCNFSUM=Y="S"
 ;
SORT ;Sort the detail report
 S IBCNSORT=""
 I 'IBCNFSUM D
 . S DIR(0)="S^P:Patient;I:Insurance;B:Billed Amount;C:Collected Amount;D:Date;S:Source of Information"
 . S DIR("B")="Source of Information"
 . S DIR("A")="Sort the report by"
 . W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q
 . S IBCNSORT=Y
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G EXIT
 ;
OUT ; select Excel or Report format
 N %ZIS,DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,X,Y,ZTDESC,ZTRTN,ZTSAVE
 W !
 S DIR(0)="S^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) G EXIT
 S IBCNOUT=Y
 ;
 W !!,"If you selected a long report period it is"
 W !,"recommended that this report be queued."
 ;
 I 'IBCNFSUM W !!,"*** This report is 132 characters wide ***"
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTDESC="Source of Information Report",ZTRTN="DQ^IBCOPR"
 . S ZTSAVE("DATE*")="",ZTSAVE("IBCN*")="",ZTSAVE("ZTREQ")="@"
 . D ^%ZTLOAD K IO("Q"),ZTSK
 ;
 I IBCNOUT="R" W !!,"<*> please wait <*>"
 ;
 ;^TMP($J,CLASS,SORT,SORTIEN)=DFN^SSN^BILLNO^INS^BILLDATE^BILLAMT
DQ ;Process Report (queue entry point)
 N ARTRX,BILLIEN,DATE,TRXIEN
 K ^TMP($J,"IBCOPR")
 ;
 ;AR Transactions to show on the report.
 S ARTRX("PAYMENT (IN PART)")=""
 S ARTRX("PAYMENT (IN FULL)")=""
 ;
 ;Collect Data based on the Bill Date
 I DATETYPE="B" D  G PRINT
 . N DATE
 . S DATE=DATESTRT-1
 . F  S DATE=$O(^DGCR(399,"APD3",DATE)) Q:'DATE!(DATE>DATEEND)  D
 .. N BILLIEN
 .. S BILLIEN=""
 .. F  S BILLIEN=$O(^DGCR(399,"APD3",DATE,BILLIEN)) Q:(BILLIEN="")  D
 ... N BILLDATA,CLMDATA
 ... D BILLDATA(BILLIEN,.BILLDATA,.SORT)
 ... I '$G(BILLDATA("SOI")) Q
 ... S TRXIEN="" F  S TRXIEN=$O(^PRCA(433,"C",BILLIEN,TRXIEN)) Q:'TRXIEN  D
 .... D CLMDATA(TRXIEN,.CLMDATA)
 ... D SETTMP(.BILLDATA,.CLMDATA)
 ;
 ;Collect Data based on the Collection Date
 N TYPE,TYPEIEN
 S TYPE=""
 F  S TYPE=$O(ARTRX(TYPE)) Q:TYPE=""  D
 . S TYPEIEN=$O(^PRCA(430.3,"B",TYPE,""))
 . S DATE=DATESTRT-1,ENDDATE=$$FMADD^XLFDT(DATEEND,30)
 . F  S DATE=$O(^PRCA(433,"AT",TYPEIEN,DATE)) Q:'DATE!(DATE>ENDDATE)  D
 .. S TRXIEN=0
 .. F  S TRXIEN=$O(^PRCA(433,"AT",TYPEIEN,DATE,TRXIEN)) Q:'TRXIEN  D
 ... N BILLDATA,CLMDATA
 ... D CLMDATA(TRXIEN,.CLMDATA)
 ... I '$D(CLMDATA) Q
 ... D BILLDATA(CLMDATA(TRXIEN,"BILLNUM"),.BILLDATA)
 ... I '$D(BILLDATA("SOI")) Q
 ... D SETTMP(.BILLDATA,.CLMDATA)
 ;
PRINT ; Print the report
 N IBEX,LINE,PAGE,RDATE,SORTBY,TAB
 S RDATE=$$FMTE^XLFDT($$NOW^XLFDT),IBEX=0
 I 'IBCNFSUM S SORTBY=$S(IBCNSORT="P":"Patient",IBCNSORT="I":"Insurance",IBCNSORT="B":"Billed Amount",IBCNSORT="C":"Collected Amount",IBCNSORT="D":$S(DATETYPE="B":"Bill ",1:"Collected ")_"Date",IBCNSORT="S":"Source of Information",1:"")
 I IBCNOUT="E" D EXCEL^IBCOPR1
 I IBCNOUT="R" D REPORT^IBCOPR1
 I '$G(IBEX),($E(IOST,1,2)="C-") D PAUSE^VALM1
 ;
EXIT ; Exit routine
 D ^%ZISC
 K ^TMP($J,"IBCOPR")
 Q
 ;
BILLDATA(BILLIEN,DATA,SORT) ;Get Billing Data
 N ARRAY,BILLIENS,DFN,FLD,INS,INSCOIEN,INSIENS,SEQ,SOI
 ;
 S BILLIENS=BILLIEN_","
 ;.01 - BILL NUMBER
 ;.02 - PATIENT NAME (DFN)
 ;.05 - BILL CLASSIFICATION
 ;.21 - CURRENT BILL PAYER SEQUENCE
 ;10 - AUTHORIZATION DATE (BILL DATE)
 ;16 - CANCEL BILL?
 ;201 - TOTAL CHARGES
 D GETS^DIQ(399,BILLIENS,".01;.02;.05;.21;10;16;201","EI","ARRAY","ERROR")
 ;Get data from INSURANE TYPE subfile.
 S DATA("BILLNUM")=$G(ARRAY(399,BILLIENS,.01,"E"))
 S DATA("BILLAMT")=$G(ARRAY(399,BILLIENS,201,"I"))
 S DATA("BILLDATE")=$G(ARRAY(399,BILLIENS,10,"I"))
 S DATA("CANCEL")=$G(ARRAY(399,BILLIENS,16,"I"))
 S DATA("CLASS")=$S($G(ARRAY(399,BILLIENS,.05,"I"))<3:1,1:3)  ;Inpatient (1) or Outpatient (3)
 S SEQ=$G(ARRAY(399,BILLIENS,.21,"I")),FLD=$S(SEQ="P":101,SEQ="S":102,1:103)
 S (DATA("PATIENT"),DFN)=$G(ARRAY(399,BILLIENS,.02,"I"))
 S INSCOIEN=$$GET1^DIQ(399,BILLIENS,FLD,"I") I 'INSCOIEN G BILLDATX
 S INS=$O(^DPT(DFN,.312,"B",INSCOIEN,""))
 ;.09 - SSN
 D GETS^DIQ(2,DFN_",",".09","EI","ARRAY","ERROR")
 S INSIENS=INS_","_DFN_","
 ;.01 - Insurance Company
 ;1.09 - Source of Information
 D GETS^DIQ(2.312,INSIENS,".01;1.09","EI","ARRAY","ERROR")
 S SOI=$G(ARRAY(2.312,INSIENS,1.09,"I")) I SOI="" G BILLDATX
 I ($G(IBCNESOI)'="A"),'$D(IBCNESOI(SOI)) G BILLDATX   ;Quit if SOI not selected and not ALL
 S DATA("SOI")=SOI
 S DATA("SSN")=$E($G(ARRAY(2,DFN_",",.09,"E")),6,9)
 S DATA("INSCO")=$G(ARRAY(2.312,INSIENS,.01,"I"))
 I $D(^TMP($J,"IBCOPR","B",DATA("CLASS"),BILLIEN)) G BILLDATX
 I DATA("CANCEL") Q  ;Don't add to totals
 ;
BILLDATX ; Exit the Bill data gathering subroutine
 Q
 ;
CLMDATA(CLMIEN,DATA) ; Get Data from Transaction file.
 ;
 ;Retrieve the following fields from the AR TRANSACTION FILE (#433)
 ;.03 - Bill Number
 ; 11 - Date
 ; 12 - Type
 ; 15 - Transaction Amount
 ;
 N ARRAY,CLMIENS,TRXDATE,TRXTYPE
 S CLMIENS=CLMIEN_","
 D GETS^DIQ(433,CLMIENS,".03;11;12;15","EI","ARRAY","ERROR")
 S TRXTYPE=$G(ARRAY(433,CLMIENS,12,"E")) I TRXTYPE="" G CLMDATAX
 S TRXDATE=$G(ARRAY(433,CLMIENS,11,"I")) I (DATETYPE="C"),((TRXDATE<DATESTRT)!(TRXDATE>DATEEND)) G CLMDATAX
 I '$D(ARTRX(TRXTYPE)) G CLMDATAX
 S DATA(CLMIEN,"TRXAMT")=$G(ARRAY(433,CLMIENS,15,"I"))
 S DATA(CLMIEN,"BILLNUM")=$G(ARRAY(433,CLMIENS,.03,"I"))
 S DATA(CLMIEN,"TRXDATE")=TRXDATE
 S DATA(CLMIEN,"TRXTYPE")=TRXTYPE
 ;
CLMDATAX ; Exit the Claim data gathering subroutine
 Q
 ;
SETTMP(BILL,CLAIM) ; Set ^TMP($J,"IPCOPR") global with data for printing the report
 ;
 ; BILL    - Data from Billing
 ; BILL("BILLAMT")=Bill Amount
 ; BILL("BILLDATE")=Bill Date
 ; BILL("BILLNUM")=Bill Number
 ; BILL("CANCEL")=1 if bill cancelled
 ; BILL("CLASS")=1 (inpatient) OR 3 (outpatient)
 ; BILL("INSCO")=Ins Co IEN
 ; BILL("PATIENT")=DFN
 ; BILL("SOI")=SOI IEN
 ; BILL("SSN")=Last 4 SSN
 ; CLAIM   - Data from AR Transaction
 ; CLAIM(TRXIEN,"BILLNUM")=Bill IEN
 ; CLAIM(TRXIEN,"TRXDATE")=Transaction Date in FileMan format
 ; CLAIM(TRXIEN,"TRXTYPE")=Transaction Type
 ; CLAIM(TRXIEN,"TRXAMT")=Tranaction Amount
 ;
 N STR,TOT,TRX
 I DATETYPE="C" S TRX=$O(CLAIM("")),BILLIEN=$G(CLAIM(TRX,"BILLNUM")) I 'BILLIEN G SETTMPX
 ;
 I '$D(CLAIM),$D(^TMP($J,"IBCOPR","B",BILLIEN)) G SETTMPX   ;No change
 ;
 I '$G(BILL("CANCEL")) D
 . I '$D(^TMP($J,"IBCOPR","B",BILLIEN)) D
 .. ;Grand Total
 .. S TOT=$G(^TMP($J,"IBCOPR","T","BILLCNT"))+1,^("BILLCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","T","BILLAMT"))+BILL("BILLAMT"),^("BILLAMT")=TOT
 .. ;
 .. ;Total by class
 .. S TOT=$G(^TMP($J,"IBCOPR","T",BILL("CLASS"),"BILLCNT"))+1,^("BILLCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","T",BILL("CLASS"),"BILLAMT"))+BILL("BILLAMT"),^("BILLAMT")=TOT
 .. ;
 .. I 'IBCNFSUM Q  ;Only Summary report
 .. ;
 .. ;Total by class and SOI
 .. S TOT=$G(^TMP($J,"IBCOPR","S",BILL("CLASS"),BILL("SOI"),"BILLCNT"))+1,^("BILLCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","S",BILL("CLASS"),BILL("SOI"),"BILLAMT"))+BILL("BILLAMT"),^("BILLAMT")=TOT
 .. ;
 .. ;Grand Total by SOI
 .. S TOT=$G(^TMP($J,"IBCOPR","S","T",BILL("SOI"),"BILLCNT"))+1,^("BILLCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","S","T",BILL("SOI"),"BILLAMT"))+BILL("BILLAMT"),^("BILLAMT")=TOT
 . ;
 . I $D(CLAIM) S TRX="" F  S TRX=$O(CLAIM(TRX)) Q:'TRX  D
 .. ;Grand Total
 .. S TOT=$G(^TMP($J,"IBCOPR","T","CLMCNT"))+1,^("CLMCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","T","CLMAMT"))+CLAIM(TRX,"TRXAMT"),^("CLMAMT")=TOT
 .. ;
 .. ;Total by Class
 .. S TOT=$G(^TMP($J,"IBCOPR","T",BILL("CLASS"),"CLMCNT"))+1,^("CLMCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","T",BILL("CLASS"),"CLMAMT"))+$G(CLAIM(TRX,"TRXAMT")),^("CLMAMT")=TOT
 .. ;
 .. I 'IBCNFSUM Q  ;Only Summary report
 .. ;
 .. ;Total by class and SOI
 .. S TOT=$G(^TMP($J,"IBCOPR","S",BILL("CLASS"),BILL("SOI"),"CLMCNT"))+1,^("CLMCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","S",BILL("CLASS"),BILL("SOI"),"CLMAMT"))+CLAIM(TRX,"TRXAMT"),^("CLMAMT")=TOT
 .. ;
 .. ; Total by SOI
 .. S TOT=$G(^TMP($J,"IBCOPR","S","T",BILL("SOI"),"CLMCNT"))+1,^("CLMCNT")=TOT
 .. S TOT=$G(^TMP($J,"IBCOPR","S","T",BILL("SOI"),"CLMAMT"))+CLAIM(TRX,"TRXAMT"),^("CLMAMT")=TOT
 . S ^TMP($J,"IBCOPR","B",BILLIEN)=""
 ;
 I 'IBCNFSUM D  ; Only Detail Report
 . N FPN,INSCO,PN,SOI,TRX
 . S PN=$$GET1^DIQ(2,BILL("PATIENT")_",",.01),INSCO=$$GET1^DIQ(36,BILL("INSCO")_",",.01)
 . S SOI=$$GET1^DIQ(355.12,BILL("SOI")_",",.01)
 . S STR=PN                                        ;Patient Name
 . S STR=STR_U_BILL("SSN")                         ;SSN
 . S STR=STR_U_$S(BILL("CANCEL"):"*",1:" ")        ;Cancel
 . S STR=STR_BILL("BILLNUM")                       ;Bill Number (concatenacted to Cancel)
 . S STR=STR_U_INSCO                               ;Insurance Company
 . S STR=STR_U_$G(BILL("BILLAMT"))                 ;Bill Amt
 . S STR=STR_U_BILL("BILLDATE")                    ;Bill Date
 . S $P(STR,U,10)=SOI                              ;SOI
 . ;
 . ; Only have Bill Data
 . I '$D(CLAIM) D  Q
 .. S $P(STR,U,9)="N"
 .. D SETLINE
 . ;
 . ; Process Collection Data
 . S TRX=0
 . F  S TRX=$O(CLAIM(TRX)) Q:'TRX  D
 .. S FPN=$S($G(CLAIM(TRX,"TRXTYPE"))["FULL":"F",$G(CLAIM(TRX,"TRXTYPE"))["PART":"P",1:"N")
 .. S $P(STR,U,7)=$G(CLAIM(TRX,"TRXAMT"))                    ;Collected Amt
 .. S $P(STR,U,8)=$G(CLAIM(TRX,"TRXDATE"))                   ;Collected Date
 .. S $P(STR,U,9)=FPN                                        ;F/P/N
 .. D SETLINE
 ;
SETTMPX ;Exit subroutine
 Q
 ;
SETLINE ; Set up data line for detail report
 ;
 N CNT,SORT
 S SORT="" D
 . I IBCNSORT="P" S SORT=PN Q
 . I IBCNSORT="I" S SORT=INSCO Q
 . I IBCNSORT="B" S SORT=BILL("BILLAMT") Q
 . I IBCNSORT="C" S SORT=+$G(CLAIM(+$G(TRX),"TRXAMT")) Q
 . I IBCNSORT="D" S SORT=$S(DATETYPE="B":BILL("BILLDATE"),1:$G(CLAIM(TRX,"TRXDATE"))) Q
 . S SORT=SOI
 S CNT=$G(^TMP($J,"IBCOPR","D",BILL("CLASS"),SORT))+1,^(SORT)=CNT,^(SORT,CNT)=STR
 Q
 ;
BCHELP ;Help for DATETYPE field
 W !!,"Enter 'B' for Bill Date      - The date bills were generated"
 W !,"or    'C' for Collected Date - The date money was collected for"
 W !,"                               a claim (may be partial or full).",!
 Q
