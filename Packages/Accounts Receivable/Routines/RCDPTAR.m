RCDPTAR ;ALB/TJB - EFT TRANSACTION AUDIT REPORT ;1/02/15
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*303 - EFT TRANSACTION AUDIT REPORT
 ;
 ; Executed by the option "EFT Transaction Audit Report" from the "EDI Lockbox Reports Menu"
 ;
 ; DESCRIPTION: The following generates a report that displays an audit history for an EFT
 ;
EN ;
 ; Ask Summary or Detail output
 N DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT,RCREP
 W !
 S DIR(0)="SOA^S:Summary Information Only;D:Detail Report"
 S DIR("A")="(S)ummary or (D)etail Report format? "
 S DIR("B")="SUMMARY"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCREP=Y
 ;
 I RCREP="S" D SUM^RCDPTAR1
 I RCREP="D" D DET
 Q
 ;
DET ;
 N RCDET,RCDATA
 ;
DET1 ;
 K DIR
 S DIR(0)="SO^N:Deposit Number;D:Deposit Date;R:Receipt Number;T:Trace Number"
 S DIR("PRE")="S:X?1N X=$S(X=1:""N"",X=2:""d"",X=3:""r"",X=4:""t"",1:""X"")"
 S DIR("L",1)="Search for EFT Number by:"
 S DIR("L",2)=""
 S DIR("L",3)="  1. Deposit (N)umber"
 S DIR("L",4)="  2. Deposit (D)ate"
 S DIR("L",5)="  3. (R)eceipt #"
 S DIR("L")="  4. (T)race #"
 S DIR("A")="Search for EFT by"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G DETQ
 S RCDET=Y
 ;
 ; Do lookup of EFTs based on the user selection above
 S RCDATA=""
 D @($S(RCDET="N":"DN",RCDET="D":"DT",RCDET="R":"RC",1:"TR")_"(.RCDATA)")
 I RCDATA=-1 G DETQ
 I RCDATA="" G DET1
 ;
  ; Prompt for device
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP G DETQ
 I $D(IO("Q")) D  G DETQ
 . S ZTRTN="RUN^RCDPTAR(RCDATA)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="EFT TRANSACTION SUMMARY REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 ;
 D RUN(RCDATA)
 Q
 ;
DETQ ;
 Q
 ;
RUN(RCDATA) ;
 ;
 ; Compile Data
 D COMPILE(RCDATA)
 ;
 ; Generate Report
 D REPORT(RCDATA)
 ;
 K ^TMP("RCDPTAR",$J)
 Q
 ;
DN(RCDATA) ;
 ; Lookup by Deposit Number
 ; Note variable RCDEFLUP is needed by LOOKUP^RCDPUDEP, which is called by the .01 field
 ;
 N DIC,DTOUT,DUOUT,Y,RCDEFLUP,LOCKIEN
 ;
 ; Lookup Deposit Number
 W !
 S DIC="^RCY(344.1,",DIC(0)="QEAMn",DIC("A")="Select DEPOSIT: ",DIC("W")="D DICW^RCDPUDEP"
 S RCDEFLUP=1
 D ^DIC
 I $G(DTOUT)!$G(DUOUT)!(Y=-1) S RCDATA=-1 Q
 ;
 S LOCKIEN=+$O(^RCY(344.3,"ARDEP",+Y,""))
 I 'LOCKIEN W !!,"EFT NOT FOUND - please check Deposit" D PAUSE Q
 ;
 ; Get EFT pointer
 S RCDATA=$$EFT(LOCKIEN)
 Q
 ;
DT(RCDATA) ; Deposit Date
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,RCDT
 N LIST,RCI,CNT,RCIEN,DEPIEN,DATA,LINE,ITEM
 ;
DT1 ;
 ; Ask the user for the Deposit Date
 K DIR
 S DIR(0)="DAO^:"_DT_":APE",DIR("B")="T"
 S DIR("A")="Select DEPOSIT DATE: "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCDATA=-1 Q
 S RCDT=Y
 ;
 ; Build List
 K LIST
 S RCI="",CNT=0 F  S RCI=$O(^RCY(344.3,"ADEP",RCDT,RCI)) Q:RCI=""  D
 . S RCIEN="" F  S RCIEN=$O(^RCY(344.3,"ADEP",RCDT,RCI,RCIEN)) Q:RCIEN=""  D
 .. S DEPIEN=$P($G(^RCY(344.3,RCIEN,0)),U,3)
 .. I DEPIEN="" Q
 .. S DATA=$G(^RCY(344.1,DEPIEN,0))
 .. I DATA="" Q
 .. S CNT=CNT+1
 .. ; Code below is similiar to DICW^RCDPUDEP code
 .. S LINE=$J(CNT,3)_". "_$P(DATA,U,1)
 .. S $E(LINE,19)="by: "_$E($P($G(^VA(200,+$P(DATA,"^",6),0)),"^"),1,15)
 .. I '$P(DATA,"^",7) S $P(DATA,"^",7)="???????"
 .. S $E(LINE,39)="on: "_$E($P(DATA,"^",7),4,5)_"/"_$E($P(DATA,"^",7),6,7)_"/"_$E($P(DATA,"^",7),2,3)
 .. S $E(LINE,52)="amt: $"_$J($P(DATA,"^",4),10,2)
 .. S $E(LINE,70)=$P("N/A^OPEN^DEPOSITED^CONFIRMED^PROCESSED^VOID","^",+$P(DATA,"^",12)+1)
 .. S LIST(CNT)=RCIEN_"^"_$P(DATA,U,1)_"^"_LINE
 ;
 ; If no deposits in the LIST, display a message and try again
 I CNT=0 W !,"Date ",$$DATE^RCDPRU(RCDT)," does not have any valid deposits, please try again...",! G DT1
 ;
 ; If only one deposit in the list, use it
 I CNT=1 S RCDATA=$$EFT(+LIST(CNT)) Q
 ;
 ; Multiple entries found so prompt for the one that is wanted
 W !!,"Deposits on ",$$DATE^RCDPRU(RCDT)
 K DIR,ITEM
 S DIR(0)="SAO^"
 S DIR("A")="Select DEPOSIT: "
 S DIR("L",1)="  Choose from:"
 F LINE=1:1:CNT D
 . S DATA=LIST(LINE),DIR(0)=DIR(0)_LINE_":"_$P(DATA,U,2)_";"
 . S DIR("L",LINE+1)=$P(DATA,U,3),ITEM(LINE)=+DATA
 . W !,"  ",$P(DATA,U,3)
 S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
 S DIR("L")=DIR("L",CNT+1) K DIR("L",CNT+1)
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S RCDATA=-1 Q
 I Y="" G DT1
 S RCDATA=$$EFT(ITEM(Y))
 Q
 ;
RC(RCDATA) ;
 ; Lookup by Receipt Number
 N DIC,D,DTOUT,DUOUT,X,Y,RCIEN,RCDTN,RCED
 ;
 W !
 S DIC="^RCY(344,",DIC(0)="QEAMn",DIC("A")="Select RECEIPT: "
 S DIC("W")="D DICW^RCDPUREC"
 S DIC("S")="I $$EDILBEV^RCDPEU($P($G(^(0)),U,4))"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) S RCDATA=-1 Q
 ;
 ; Check if there is a pointer to the AR Deposit
 S RCDATA=""
 S RCIEN=$P($G(^RCY(344,+Y,0)),U,6)
 ;
 ; If there is, then get the EFT via AR Deposit and EDI LockBox files
 I RCIEN D
 . ; Get Ticket Number
 . S RCDTN=$P($G(^RCY(344.1,RCIEN,0)),U,1)
 . I RCDTN="" Q
 . ;
 . ; Get EDI Lockbox Deposit File
 . S RCED=$O(^RCY(344.3,"C",RCDTN,""))
 . I RCED="" Q
 . S RCDATA=$$EFT(RCED)
 ;
 ; If this AR Deposit record is not found, check if it is a receipt on the ERA
 I 'RCIEN D
 . S ERAIEN=$O(^RCY(344.4,"H",+Y,""))
 . I 'ERAIEN S ERAIEN=$O(^RCY(344.4,"ARCT",+Y,""))
 . I 'ERAIEN Q
 . S EFTIEN=$O(^RCY(344.31,"AERA",ERAIEN,""))
 . I EFTIEN S RCDATA=$$EFTDATA(EFTIEN)
 ;
 I RCDATA="" W !!,"EFT NOT FOUND - please check Receipt" D PAUSE Q
 Q
 ;
TR(RCDATA) ;
 ; Lookup by Trace Number
 N DIC,D,Y,X,DTOUT,DUOUT
 ;
 ; Use "F" index in EDI EFT Detail file
 W !
 S DIC="^RCY(344.31,",DIC(0)="QEASn",D="F",DIC("A")="Select TRACE: "
 ; DIC("W") may need to be fixed if Trace numbers go over 32 characters. The fields
 ; displayed are the EFT#, Insurance company name, amount and Date Recieved.
 S DIC("W")="D EN^DDIOL($J($P(^(0),U,1),7)_"" ""_$$LJ^XLFSTR($E($P(^(0),U,2),1,20),20)_$J($P(^(0),U,7),10)_"" ""_$$DATE^RCDPRU($P(^(0),U,13)),,""?32"")"
 D IX^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) S RCDATA=-1 Q
 S RCDATA=$$EFTDATA(+Y)
 Q
 ;
EFT(LOCKIEN) ;
 ; Select a single EFT Number
 I '$G(LOCKIEN) W !!,"No EFT detail for this selection" D PAUSE Q ""
 ;
 N EFTIEN,DATA,CNT,LIST,Y
 ;
 S EFTIEN="",CNT=0
 F  S EFTIEN=$O(^RCY(344.31,"B",LOCKIEN,EFTIEN)) Q:EFTIEN=""  S DATA=$$EFTDATA(EFTIEN) I DATA]"" S CNT=CNT+1,LIST(CNT)=DATA
 ;
 I CNT=0 W !!,"No EFT detail for this selection" D PAUSE Q ""
 ;
 ; If only one EFT, select it and quit
 I CNT=1 S Y=1 G EFT1
 ;
 ; Display and the let the user select the EFT
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X
 N ROW,TRANS
 S DIR(0)="SO^"
 S DIR("A")="Select item from list"
 S DIR("L",1)="Select single EFT:"
 F ROW=1:1:CNT-1 D
 . S DATA=LIST(ROW),LOCKIEN=$P(DATA,U,2),EFTIEN=$P(DATA,U,3),TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.01)
 . S DIR(0)=DIR(0)_ROW_":"_TRANS_";"
 . S DIR("L",(ROW+1))=$J(ROW,3)_". "_TRANS_"    "_$$DISPLAY(EFTIEN,LOCKIEN)
 S DATA=LIST(CNT),LOCKIEN=$P(DATA,U,2),EFTIEN=$P(DATA,U,3),TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.01)
 S DIR(0)=DIR(0)_CNT_":"_TRANS
 S DIR("L")=$J(CNT,3)_". "_TRANS_"    "_$$DISPLAY(EFTIEN,LOCKIEN)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 ;
EFT1 ;
 Q LIST(Y)
 ;
EFTDATA(EFTIEN) ;
 ;
 I '$G(EFTIEN) Q ""
 ;
 N ERAIEN,LOCKIEN,DEPOSIT,DEPIEN,BATCHIEN
 S (ERAIEN,DEPIEN,BATCHIEN)=""
 S ERAIEN=$P($G(^RCY(344.31,EFTIEN,0)),U,10)
 S LOCKIEN=$P($G(^RCY(344.31,EFTIEN,0)),U,1)
 I LOCKIEN S DEPOSIT=$P($G(^RCY(344.3,LOCKIEN,0)),U,6)
 I DEPOSIT]"" S DEPIEN=$O(^RCY(344.1,"B",DEPOSIT,""))
 I DEPIEN S BATCHIEN=$O(^RCY(344,"AD",DEPIEN,""))
 Q ERAIEN_U_LOCKIEN_U_EFTIEN_U_DEPIEN_U_BATCHIEN
 ;
DISPLAY(EFTIEN,LOCKIEN) ;
 N X
 S EFTIEN=$G(EFTIEN)
 S LOCKIEN=$G(LOCKIEN)
 S X=$$GET1^DIQ(344.31,EFTIEN_",",.02)_"    "_$$GET1^DIQ(344.31,EFTIEN_",",.04)_"    "
 S X=X_$$GET1^DIQ(344.31,EFTIEN_",",.07)_"    "_$$GET1^DIQ(344.3,LOCKIEN_",",.06)_"    "
 S X=X_$$DATE^RCDPRU($$GET1^DIQ(344.3,LOCKIEN_",",.07,"I"),"2DZ")
 Q X
 ;
COMPILE(RCDATA) ;
 ;
 I $G(RCDATA)="" Q
 ;
 N ERAIEN,LOCKIEN,EFTIEN,DEPIEN,BATCHIEN,FILEDATE,TRANS,DEPDATE,PROCDATE,STATUS,FMSDOCNO
 N MATCHIEN,IENS,MATCHDATE,LASTIEN,LINE
 K ^TMP("RCDPTAR",$J)
 ;
 ; Get Pointers from RCDATA
 S ERAIEN=$P(RCDATA,U,1),LOCKIEN=$P(RCDATA,U,2),EFTIEN=$P(RCDATA,U,3),DEPIEN=$P(RCDATA,U,4),BATCHIEN=$P(RCDATA,U,5)
 ;
 ; Get Inital Creation/Deposit information
 K RCDATA
 I LOCKIEN D
 . D GETS^DIQ(344.3,LOCKIEN_",",".02;.06;.08","IE","RCDATA")
 . S FILEDATE=$G(RCDATA(344.3,LOCKIEN_",",.02,"I"))
 . I 'FILEDATE Q
 . S ^TMP("RCDPTAR",$J,FILEDATE,1)="DEP#:"_$G(RCDATA(344.3,LOCKIEN_",",.06,"E"))_"  DEP AMT:"_$G(RCDATA(344.3,LOCKIEN_",",.08,"E"))_"^EFT STATUS:RECEIVED"
 ;
 ; Check if posted to revenue code 8NZZ
 S TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.14)
 I TRANS,$D(^RCY(344,+BATCHIEN,1,TRANS,0)),LOCKIEN,$D(RCDATA(344.3,LOCKIEN_",")) D
 . S DEPDATE=$$GET1^DIQ(344.1,DEPIEN_",",.07,"I")
 . I 'DEPDATE Q
 . S ^TMP("RCDPTAR",$J,DEPDATE,2)="DEP#:"_$G(RCDATA(344.3,LOCKIEN_",",.06,"E"))_"  DEP AMT:"_$G(RCDATA(344.3,LOCKIEN_",",.08,"E"))_"^DEP STATUS:POSTED TO 8NZZ"
 ;
 ; Get Match Status History information
 I EFTIEN D
 . ; Get the Last IEN of the multiple
 . S LASTIEN=$O(^RCY(344.31,EFTIEN,4,999999),-1)
 . ; Loop through history and build data
 . S MATCHIEN=0 F  S MATCHIEN=$O(^RCY(344.31,EFTIEN,4,MATCHIEN)) Q:'MATCHIEN  D
 .. S IENS=MATCHIEN_","_EFTIEN_","
 .. D GETS^DIQ(344.314,IENS,"*","IE","RCDATA")
 .. S MATCHDATE=$G(RCDATA(344.314,IENS,.02,"I"))
 .. I MATCHDATE="" Q
 .. S STATUS=$G(RCDATA(344.314,IENS,.01,"E"))
 .. I STATUS="MATCHED WITH ERRORS" S STATUS="MATCHED W/ERRORS"
 .. S LINE="EFT STATUS:"_STATUS
 .. ; If this is the last record and the status is matched, add the ERA record to the data
 .. I MATCHIEN=LASTIEN,STATUS="MATCHED"!(STATUS="MATCHED W/ERRORS"),$$GET1^DIQ(344.31,EFTIEN_",",.1) S LINE=LINE_" ERA#:"_$$GET1^DIQ(344.31,EFTIEN_",",.1)
 .. S ^TMP("RCDPTAR",$J,MATCHDATE,3)=LINE_"^BY "_$E($G(RCDATA(344.314,IENS,.03,"E")),1,14)_" on "_$$DATE^RCDPRU(MATCHDATE,"2ZD")
 ;
 ; Get Receipt information (EFT)
 I BATCHIEN D
 . S PROCDATE=$$GET1^DIQ(344,BATCHIEN_",",.08,"I")
 . I 'PROCDATE Q
 . I DEPDATE,PROCDATE<DEPDATE S PROCDATE=DEPDATE
 . S FMSDOCNO=$$FMSSTAT^RCDPUREC(BATCHIEN)
 . S ^TMP("RCDPTAR",$J,PROCDATE,5)="DEP RCPT#:"_$$GET1^DIQ(344,BATCHIEN_",",.01,"E")_" ENTRY#:"_BATCHIEN_"^FMS DOC#:"_$P(FMSDOCNO,U,1)_"^^DOC STATUS:"_$E($P(FMSDOCNO,U,2),1,18)
 ;
 ; Get Repeipt information (ERA)
 S BATCHIEN=$$GET1^DIQ(344.4,ERAIEN_",",.08,"I")
 I BATCHIEN D
 . S PROCDATE=$$GET1^DIQ(344,BATCHIEN_",",.08,"I")
 . I DEPDATE,PROCDATE<DEPDATE S PROCDATE=DEPDATE
 . I 'PROCDATE Q
 . S FMSDOCNO=$$FMSSTAT^RCDPUREC(BATCHIEN)
 . ;S ^TMP("RCDPTAR",$J,PROCDATE,6)="RCPT#:"_$$GET1^DIQ(344,BATCHIEN_",",.01,"E")_" EFT DETAIL#:"_EFTIEN_"^BY "_$E($$GET1^DIQ(344,BATCHIEN_",",.02,"E"),1,14)_" on "_$$DATE^RCDPRU(PROCDATE,"2DZ")
 . S ^TMP("RCDPTAR",$J,PROCDATE,6)="RCPT#:"_$$GET1^DIQ(344,BATCHIEN_",",.01,"E")_"^BY "_$E($$GET1^DIQ(344,BATCHIEN_",",.02,"E"),1,14)_" on "_$$DATE^RCDPRU(PROCDATE,"2DZ")
 . S ^TMP("RCDPTAR",$J,PROCDATE,7)="FMS DOC#:"_$P(FMSDOCNO,U,1)_"^DOC STATUS:"_$E($P(FMSDOCNO,U,2),1,18)
 Q
 ;
REPORT(RCDATA) ; Print out the report
 ;
 N RCSCR,RCNOW,RCPG,RCHR
 N DATE,CNT,DATA,LINES
 ;
 ; Initialize Report Date, Page Number and Sting of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU()),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 U IO
 D HEADER(RCNOW,.RCPG,RCHR,RCDATA)
 I $G(RCDATA)=""!'$D(^TMP("RCDPTAR",$J)) W !,"No data found"
 ;
 ; Display the detail
 S DATE="" F  S DATE=$O(^TMP("RCDPTAR",$J,DATE)) Q:'DATE  D  I RCPG=0 Q
 . S CNT=0 F  S CNT=$O(^TMP("RCDPTAR",$J,DATE,CNT)) Q:'CNT  D  I RCPG=0 Q
 .. S DATA=^TMP("RCDPTAR",$J,DATE,CNT)
 .. S LINES=1
 .. I $P(DATA,U,3)]""!($P(DATA,U,4)]"") S LINES=2
 .. I RCSCR S LINES=LINES+1
 .. D CHKP(RCNOW,.RCPG,RCHR,RCDATA,RCSCR,LINES) I RCPG=0 Q
 .. W !,$$DATE^RCDPRU(DATE,"2DZ"),?10,$P(DATA,U,1),?51,$P(DATA,U,2)
 .. I $P(DATA,U,3)]""!($P(DATA,U,4)]"") W !,?10,$P(DATA,U,3),?51,$P(DATA,U,4)
 ;
 I 'RCSCR W !,@IOF
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;
 I RCPG,RCSCR D PAUSE
 Q
 ;
HEADER(RCNOW,RCPG,RCHR,RCDATA) ;
 ; Print Header Section
 ;
 N EFTDATA,LINE
 S EFTDATA=$G(^RCY(344.31,+$P(RCDATA,U,3),0))
 ;
 W @IOF
 S RCPG=RCPG+1
 W "EFT TRANSACTION AUDIT REPORT"
 S LINE=RCNOW_"   PAGE: "_RCPG_" "
 W ?(IOM-$L(LINE)),LINE
 ;
 W !,"EFT#: ",$$AGED(+$P(RCDATA,U,3)),$P(EFTDATA,U,1),?19,"DEPOSIT#: ",$P($G(^RCY(344.3,+$P(RCDATA,U,2),0)),U,6),?42,"EFT TOTAL AMT: "_$P(EFTDATA,U,7)
 W !,"EFT TRACE#: ",$P(EFTDATA,U,4)
 W !,"DATE RECEIVED: ",$$DATE^RCDPRU($P(EFTDATA,U,12)),?26,"PAYER/ID: "_$P(EFTDATA,U,2)_"/"_$P(EFTDATA,U,3)
 ;
 W !,"DATE",?10,"ACTION/DETAILS",?51,"STATUS"
 W !,RCHR
 Q
 ;
PAUSE() ;
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="E"
 D ^DIR
 Q Y
 ;
CHKP(RCNOW,RCPG,RCHR,RCDATA,RCSCR,LINES) ;
 ; Check if we need to do a page break
 ;
 I $Y'>(IOSL-LINES) Q
 I RCSCR,'$$PAUSE S RCPG=0 Q
 D HEADER(RCNOW,.RCPG,RCHR,RCDATA)
 Q
 ;
AGED(EFTIEN) ;
 ; Check if EFT is locked or stale
 ; Input
 ;    EFTIEN: IEN of EDI THIRD PARTY EFT DETAIL (#344.31)
 ; Output
 ;    "*" - Warning; "**" - Error; Null - Good
 N RECVDT,DAYSLIMT,TRARRY
 S RECVDT=$$GET1^DIQ(344.31,EFTIEN_",",.13,"I")
 I RECVDT<$$CUTOFF^RCDPEWLP Q ""  ; EFTs 2 months older than *298 installation do not lock the system
 S DAYSLIMT("M")=$$GET1^DIQ(344.61,1,.06),DAYSLIMT("P")=$$GET1^DIQ(344.61,1,.07)
 D CHKEFT^RCDPEWLP(RECVDT,EFTIEN,"B",.DAYSLIMT,.TRARRY)
 I $D(TRARRY("ERROR")) Q "**"
 I $D(TRARRY("WARNING")) Q "*"
 Q ""
