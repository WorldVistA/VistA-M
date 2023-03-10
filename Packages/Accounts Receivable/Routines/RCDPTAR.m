RCDPTAR ;ALB/TJB - EFT TRANSACTION AUDIT REPORT ;1/02/15
 ;;4.5;Accounts Receivable;**303,321,326,380,371**;Mar 20, 1995;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*303 - EFT TRANSACTION AUDIT REPORT
 ;
 ; Executed by the option "EFT Transaction Audit Report" from the "EDI Lockbox Reports Menu"
 ;
 ; DESCRIPTION: The following generates a report that displays an audit history for an EFT
 ;
EN ; Main entry point for this report
 ; Ask Summary or Detail output
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,RCREP,RCREP2,X,Y
 W !
 S DIR(0)="SOA^S:Summary Information Only;D:Detail Report"
 S DIR("A")="(S)ummary or (D)etail Report format? "
 S DIR("B")="SUMMARY"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCREP=Y
 ;
 ; PRCA*4.5*380 - Ask if display sum. rpt. by Dep. Date or Dep. Num.
 S RCREP2=0
 S:RCREP="S" RCREP2=$$ASKSUM2()
 Q:RCREP2=-1
 ;
 I RCREP="S",RCREP2=1 D SUM^RCDPTAR1
 I RCREP="S",RCREP2=2 D SUM2^RCDPTAR1
 I RCREP="D" D DET
 Q
 ;
 ; PRCA*4.5*380 - New Subroutine added
ASKSUM2() ; Ask the user if they want to display the summary report by Deposit Date
 ; or by Deposit Number
 ; Input:   None
 ; Returns: -1 - User quit or timed out
 ;           1 - Display Summary report by Deposit Date
 ;           2 - Display Summary report by Deposit Number
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SOA^EFTS:EFTS by Date;DATE:Deposit Number"
 S DIR("A")="(E)FTs by Date or (D)eposit? "
 S DIR("B")="DEPOSIT"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 I $E(Y,1)="E" Q 1
 Q 2
 ;
DET ; Entry point for detailed report
 ; Input: variable RCREP defined and equal to "D"
 ; Output: Written to device
 ;
 N RCDATA,RCDET
 ;
DET1 ; Prompt for user selection criteria
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
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q                 ;PRCA*4.5*371 Changed G DETQ to Q
 S RCDET=Y
 ;
 ; Do lookup of EFTs based on the user selection above
 S RCDATA=""
 D @($S(RCDET="N":"DN",RCDET="D":"DT",RCDET="R":"RC",1:"TR")_"(.RCDATA)")
 ;PRCA*4.5*371 Moved lines that were here to new method SHOWONE
 Q
 ;
SHOWONE(STOP) ; Prompt for device and output data for one EFT
 ; Input:   STOP    - Initially set to 0
 ; Output:  STOP    - 1 user entered '^', 0 otherwise
 ;PRCA*4.5*371 - Added Method
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 S STOP=POP
 Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="RUN^RCDPTAR(RCDATA)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="EFT TRANSACTION SUMMARY REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 D RUN(RCDATA)
 Q
 ;
RUN(RCDATA) ; Compile and output the report
 ; Input: RCDATA - see subroutine EFTDA for delimited list of fields
 ; Output: none
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
DN(RCDATA) ; Lookup by Deposit Number
 ; Input:   RCDATA  - null on entry
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 ; Note variable RCDEFLUP is needed by LOOKUP^RCDPUDEP, which is called by the .01 field
 ;
 N DIC,DTOUT,DUOUT,LOCKIEN,RCDEFLUP,STOP,USERDN,Y   ;PRCA*4.5*371 Added STOP
 S STOP=0                                           ;PRCA*4.5*371 Added line
 ;
DN2 ; Lookup Deposit Number                         ;PRCA*4.5*371 Added looping Tag
 W !
 S DIC="^RCY(344.1,",DIC(0)="QEAMn",DIC("A")="Select DEPOSIT: ",DIC("W")="D DICW^RCDPUDEP"
 S RCDEFLUP=1
 D ^DIC
 I $G(DTOUT)!$G(DUOUT)!(Y=-1) S RCDATA=-1 Q
 ;
 S LOCKIEN=+$O(^RCY(344.3,"ARDEP",+Y,""))
 I 'LOCKIEN D  G DN2                                ;PRCA*4.5*371 Changed Q to G DN2
 . W !!,"EFT NOT FOUND - please check Deposit"
 . D PAUSE
 ;
 ; Get EFT pointer
 S RCDATA=$$EFT(LOCKIEN)
 ;
 ;PRCA*4.5*371 - Added lines Begin
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE(.STOP)                               ; Display output
 Q:STOP
 G DN2
 ;PRCA*4.5*371 - Added lines End
 Q
 ;
DT(RCDATA) ; Deposit Date
 ; Input:   RCDATA  - null on entry
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 ;
 ;PRCA*4.5*371 Added STOP below
 N CNT,DATA,DEPIEN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ITEM,LINE,LIST,RCDT,RCI,RCIEN,STOP,X,Y
 S STOP=0                                       ;PRCA*4.5*371 Added line
 ;
DT1 ; Ask the user for the Deposit Date
 K DIR
 S DIR(0)="DAO^:"_DT_":APE",DIR("B")="T"
 S DIR("A")="Select DEPOSIT DATE: "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S RCDATA=-1 Q
 S RCDT=Y
 ;
 ; Build List
 K LIST
 S RCI="",CNT=0
 F  S RCI=$O(^RCY(344.3,"ADEP",RCDT,RCI)) Q:RCI=""  D
 . S RCIEN=""
 . F  S RCIEN=$O(^RCY(344.3,"ADEP",RCDT,RCI,RCIEN)) Q:RCIEN=""  D
 . . S DEPIEN=$P($G(^RCY(344.3,RCIEN,0)),U,3)
 . . I DEPIEN="" Q
 . . S DATA=$G(^RCY(344.1,DEPIEN,0))
 . . I DATA="" Q
 . . S CNT=CNT+1
 . . ; Code below is similiar to DICW^RCDPUDEP code
 . . S LINE=$J(CNT,3)_". "_$P(DATA,U,1)
 . . S $E(LINE,19)="by: "_$E($P($G(^VA(200,+$P(DATA,"^",6),0)),"^"),1,15)
 . . I '$P(DATA,"^",7) S $P(DATA,"^",7)="???????"
 . . S $E(LINE,39)="on: "_$E($P(DATA,"^",7),4,5)_"/"_$E($P(DATA,"^",7),6,7)_"/"_$E($P(DATA,"^",7),2,3)
 . . S $E(LINE,52)="amt: $"_$J($P(DATA,"^",4),10,2)
 . . S $E(LINE,70)=$P("N/A^OPEN^DEPOSITED^CONFIRMED^PROCESSED^VOID","^",+$P(DATA,"^",12)+1)
 . . S LIST(CNT)=RCIEN_"^"_$P(DATA,U,1)_"^"_LINE
 ;
 ; If no deposits in the LIST, display a message and try again
 I CNT=0 D  G DT1
 . W !,"Date ",$$DATE^RCDPRU(RCDT)," does not have any valid deposits, please try again...",!
 ;
 ; If only one deposit in the list, use it
 I CNT=1 D  Q:STOP  G DT1                       ;PRCA*4.5*371 Changed Q to Q:STOP G DT1
 . S RCDATA=$$EFT(+LIST(CNT))
 . ;
 . ;PRCA*4.5*371 Begin Added lines 
 . Q:RCDATA=-1
 . Q:RCDATA=""                                  ; No EFTs found
 . D SHOWONE(.STOP)                             ; Display output
 . ;PRCA*4.5*371 End Added lines 
 ;
DT2 ; Multiple entries found so prompt for the one that is wanted ;PRCA*4.5*371 Added looping Tag
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
 ;
 ;PRCA*4.5*371 - Added lines Begin
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE(.STOP)                               ; Display output
 Q:STOP
 G DT2
 ;PRCA*4.5*371 - Added lines End
 Q
 ;
RC(RCDATA) ; Lookup by Receipt Number
 ; Input:   RCDATA  - null on entry
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 ;
 N D,DIC,DTOUT,DUOUT,RCDTN,RCED,RCIEN,STOP,X,Y  ;PRCA*4.5*371 Added Stop
 S STOP=0                                       ;PRCA*4.5*371 Added line
RC2 ;                                           ;PRCA*4.5*371 Added looping Tag
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
 I RCDATA="" D  G RC2                           ;PRCA*4.5*371 Changed Q to G RC2
 . W !!,"EFT NOT FOUND - please check Receipt"
 . D PAUSE
 ;
 ;PRCA*4.5*371 - Added lines Begin
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE(.STOP)                               ; Display output
 Q:STOP
 G RC2
 ;PRCA*4.5*371 - Added lines End
 Q
 ;
TR(RCDATA) ; Lookup by Trace Number
 ; Input:   RCDATA  - null on entry
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 N D,DIC,DTOUT,DUOUT,STOP,X,Y                   ;PRCA*4.5*371 Added STOP
 S STOP=0                                       ;PRCA*4.5*371 Added line
 ;
TR2 ; Use "F" index in EDI EFT Detail file      ;PRCA*4.5*371 Added looping Tag
 W !
 S DIC="^RCY(344.31,",DIC(0)="QEASn",D="F",DIC("A")="Select TRACE: "
 ; DIC("W") may need to be fixed if Trace numbers go over 32 characters. The fields
 ; displayed are the EFT#, Insurance company name, amount and Date Recieved.
 S DIC("W")="D EN^DDIOL($J($P(^(0),U,1),7)_"" ""_$$LJ^XLFSTR($E($P(^(0),U,2),1,20),20)_$J($P(^(0),U,7),10)_"" ""_$$DATE^RCDPRU($P(^(0),U,13)),,""?32"")"
 D IX^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) S RCDATA=-1 Q
 S RCDATA=$$EFTDATA(+Y)
 ;
 ;PRCA*4.5*371 - Added lines Begin
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE(.STOP)                               ; Display output
 Q:STOP
 G TR2
 ;PRCA*4.5*371 - Added lines End
 Q
 ;
EFT(LOCKIEN) ; Select a single EFT Number
 ; Input: LOCKIEN - IEN for LOCKBOX DEPOSIT (#344.3)
 ; Return: LIST(Y) - Delimiter list of information as returned by suboutine EFTDATA
 ;
 I '$G(LOCKIEN) W !!,"No EFT detail for this selection" D PAUSE Q ""
 ;
 N EFTIEN,CNT,DATA,LIST,Y
 ;
 S EFTIEN="",CNT=0
 F  S EFTIEN=$O(^RCY(344.31,"B",LOCKIEN,EFTIEN)) Q:EFTIEN=""  D  ;
 . S DATA=$$EFTDATA(EFTIEN) I DATA]"" S CNT=CNT+1,LIST(CNT)=DATA
 ;
 I CNT=0 W !!,"No EFT detail for this selection" D PAUSE Q ""
 ;
 ; If only one EFT, select it and quit
 I CNT=1 S Y=1 G EFT1
 ;
 ; Display and the let the user select the EFT
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,ROW,TRANS,X
 S DIR(0)="SO^"
 S DIR("A")="Select item from list"
 S DIR("L",1)="Select single EFT:"
 F ROW=1:1:CNT-1 D
 . S DATA=LIST(ROW),LOCKIEN=$P(DATA,U,2),EFTIEN=$P(DATA,U,3),TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.01,"I")
 . S DIR(0)=DIR(0)_ROW_":"_TRANS_";"
 . S DIR("L",(ROW+1))=$J(ROW,3)_". "_TRANS_$$DISPLAY(EFTIEN,LOCKIEN) ; PRCA*4.5*326
 S DATA=LIST(CNT),LOCKIEN=$P(DATA,U,2),EFTIEN=$P(DATA,U,3),TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.01,"I")
 S DIR(0)=DIR(0)_CNT_":"_TRANS
 S DIR("L")=$J(CNT,3)_". "_TRANS_$$DISPLAY(EFTIEN,LOCKIEN) ; PRCA*4.5*326
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 ;
EFT1 ;
 Q LIST(Y)
 ;
EFTDATA(EFTIEN) ; Get associated records for this EFT
 ; Input: EFTIEN - IEN for EFT [344.31]
 ; Returns: A1^A2^A3^A4^45
 ;   where  A1=ERAIEN - IEN for ERA (#344.4)
 ;          A2=LOCKIEN - IEN for LOCKBOX DEPOSIT (#344.3)
 ;          A3=EFTIEN - IEN for EFT (#344.31)
 ;          A4=DEPIEN - IEN for AR DEPOSIT (#344.1)
 ;          A5=BATCHIEN - IEN for AR BATCH PAYMENT (#344)
 ;
 I '$G(EFTIEN) Q ""
 ;
 N BATCHIEN,DEPIEN,ERAIEN,LOCKIEN                       ;PRCA*4.5*321 removed DEPOSIT
 S (ERAIEN,DEPIEN,BATCHIEN)=""
 S ERAIEN=$$GET1^DIQ(344.31,EFTIEN,.1,"I")              ;PRCA*4.5*321 use ^DIQ vs global access
 S LOCKIEN=$$GET1^DIQ(344.31,EFTIEN,.01,"I")            ;PRCA*4.5*321
 I LOCKIEN S DEPIEN=$$GET1^DIQ(344.3,LOCKIEN,.03,"I")   ;PRCA*4.5*321 instead of $O on B index of 344.1
 I DEPIEN S BATCHIEN=$O(^RCY(344,"AD",DEPIEN,""))
 Q ERAIEN_U_LOCKIEN_U_EFTIEN_U_DEPIEN_U_BATCHIEN
 ;
DISPLAY(EFTIEN,LOCKIEN) ; Display EFT detail during user selection process
 ; Input: EFTIEN - IEN for EFT (#344.31)
 ;        LOCKIEN - IEN for LOCKBOX DEPOSIT (#344.3)
 ; Return: X1_"    "_X2_"    "_X3_"    "_X4_"    "_X5
 ; where   X1=PAYER NAME
 ;         X2=TRACE NUMBER
 ;         X3=AMOUNT OF PAYMENT
 ;         X4=DEPOSIT NUMBER
 ;         X5=DEPOSIT DATE
 N SUFX,X ; Added Suffix - PRCA*4.5*326
 S EFTIEN=$G(EFTIEN)
 S LOCKIEN=$G(LOCKIEN)
 S SUFX=$$GET1^DIQ(344.31,EFTIEN_",",.14) ; PRCA*4.5*326
 S:SUFX SUFX="."_SUFX ; PRCA*4.5*326
 S X=SUFX_$J("",4-$L(SUFX)) ; PRCA*4.5*326
 S X=X_$$GET1^DIQ(344.31,EFTIEN_",",.02)_"    "_$$GET1^DIQ(344.31,EFTIEN_",",.04)_"    " ; PRCA*4.5*326
 S X=X_$$GET1^DIQ(344.31,EFTIEN_",",.07)_"    "_$$GET1^DIQ(344.3,LOCKIEN_",",.06)_"    "
 S X=X_$$DATE^RCDPRU($$GET1^DIQ(344.3,LOCKIEN_",",.07,"I"),"2DZ")
 Q X
 ;
COMPILE(RCDATA) ; Compile data for display
 ; Input: RCDATA - see subroutine EFTDA for delimited list of fields
 ; Output: ^TMP("RCDPTAR",$J)
 ;
 I $G(RCDATA)="" Q
 ;
 N BATCHIEN,DEPDATE,DEPIEN,EFTIEN,ERAIEN,FILEDATE,FMSDOCNO,IENS,LASTIEN,LINE,LOCKIEN
 N MATCHDATE,MATCHIEN,PROCDATE,STATUS,TRANS
 K ^TMP("RCDPTAR",$J)
 ;
 ; Get Pointers from RCDATA
 S ERAIEN=$P(RCDATA,U,1),LOCKIEN=$P(RCDATA,U,2),EFTIEN=$P(RCDATA,U,3)
 S DEPIEN=$P(RCDATA,U,4),BATCHIEN=$P(RCDATA,U,5)
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
 . I $G(DEPDATE),PROCDATE<DEPDATE S PROCDATE=DEPDATE     ;PRCA*4.5*321 add $G
 . S FMSDOCNO=$$FMSSTAT^RCDPUREC(BATCHIEN)
 . S ^TMP("RCDPTAR",$J,PROCDATE,5)="DEP RCPT#:"_$$GET1^DIQ(344,BATCHIEN_",",.01,"E")_" ENTRY#:"_BATCHIEN_"^FMS DOC#:"_$P(FMSDOCNO,U,1)_"^^DOC STATUS:"_$E($P(FMSDOCNO,U,2),1,18)
 ;
 ; Get Receipt information (ERA)
 S BATCHIEN=$$GET1^DIQ(344.4,ERAIEN_",",.08,"I")
 I BATCHIEN D
 . S PROCDATE=$$GET1^DIQ(344,BATCHIEN_",",.08,"I")
 . I $G(DEPDATE),PROCDATE<DEPDATE S PROCDATE=DEPDATE     ; PRCA*4.5*321 add $G
 . I 'PROCDATE Q
 . S FMSDOCNO=$$FMSSTAT^RCDPUREC(BATCHIEN)
 . ;S ^TMP("RCDPTAR",$J,PROCDATE,6)="RCPT#:"_$$GET1^DIQ(344,BATCHIEN_",",.01,"E")_" EFT DETAIL#:"_EFTIEN_"^BY "_$E($$GET1^DIQ(344,BATCHIEN_",",.02,"E"),1,14)_" on "_$$DATE^RCDPRU(PROCDATE,"2DZ")
 . S ^TMP("RCDPTAR",$J,PROCDATE,6)="RCPT#:"_$$GET1^DIQ(344,BATCHIEN_",",.01,"E")_"^BY "_$E($$GET1^DIQ(344,BATCHIEN_",",.02,"E"),1,14)_" on "_$$DATE^RCDPRU(PROCDATE,"2DZ")
 . S ^TMP("RCDPTAR",$J,PROCDATE,7)="FMS DOC#:"_$P(FMSDOCNO,U,1)_"^DOC STATUS:"_$E($P(FMSDOCNO,U,2),1,18)
 Q
 ;
REPORT(RCDATA) ; Print out the report
 ; Input: RCDATA - see subroutine EFTDA about for delimited list of fields
 ; Output: Write statements
 ;
 N CNT,DATE,DATA,LINES,RCHR,RCNOW,RCPG,RCSCR
 ;
 ; Initialize Report Date, Page Number and String of underscores
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
 ; PRCA*4.5*371 - STOP if user enters '^'
 I RCPG,RCSCR S STOP=$S('$$PAUSE():1,1:0)
 Q
 ;
HEADER(RCNOW,RCPG,RCHR,RCDATA) ; Print Header Section
 ; Input: RCNOW - DATE/TIME in external format
 ;        RCPG - Current page number
 ;        RCHR - Line of "-" to margin width
 ;        RCDATA - See subroutine EFTDA about for delimited list of fields
 ; Output: Write statements
 ;
 N EFTDATA,LINE
 S EFTDATA=$G(^RCY(344.31,+$P(RCDATA,U,3),0))
 ;
 W @IOF
 S RCPG=RCPG+1
 W "EFT TRANSACTION AUDIT REPORT"
 S LINE=RCNOW_"   PAGE: "_RCPG_" "
 W ?(IOM-$L(LINE)),LINE
 ; Added EFT line identifier nnn.nn - PRCA*4.5*326
 W !,"EFT#: ",$$AGED(+$P(RCDATA,U,3)),$$GET1^DIQ(344.31,$P(RCDATA,U,3)_",",.01,"E"),?19,"DEPOSIT#: ",$P($G(^RCY(344.3,+$P(RCDATA,U,2),0)),U,6),?42,"EFT TOTAL AMT: "_$P(EFTDATA,U,7)
 W !,"EFT TRACE#: ",$P(EFTDATA,U,4)
 W !,"DATE RECEIVED: ",$$DATE^RCDPRU($P(EFTDATA,U,12)),?26,"PAYER/ID: "_$P(EFTDATA,U,2)_"/"_$P(EFTDATA,U,3)
 ;
 W !,"DATE",?10,"ACTION/DETAILS",?51,"STATUS"
 W !,RCHR
 Q
 ;
PAUSE() ; Pause at end of each page for user input
 ; Input: None
 ; Output: User response
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E"
 D ^DIR
 Q Y
 ;
CHKP(RCNOW,RCPG,RCHR,RCDATA,RCSCR,LINES) ; Check if we need to do a page break
 ; Input: RCNOW - DATE/TIME in external format
 ;        RCPG - Current page number
 ;        RCHR - Line of "-" to margin width
 ;        RCDATA - See subroutine EFTDA about for delimited list of fields
 ;        RCSCR - 1 - Output is going to the users screen, 0 - to printer
 ;        LINES - Current line count
 ;
 I $Y'>(IOSL-LINES) Q
 I RCSCR,'$$PAUSE S RCPG=0 Q
 D HEADER(RCNOW,.RCPG,RCHR,RCDATA)
 Q
 ;
AGED(EFTIEN) ; Check if EFT is locked or stale
 ; Input
 ;    EFTIEN: IEN of EDI THIRD PARTY EFT DETAIL (#344.31)
 ; Output
 ;    "*" - Warning; "**" - Error; Null - Good
 N DAYSLIMT,RECVDT,TRARRY
 S RECVDT=$$GET1^DIQ(344.31,EFTIEN_",",.13,"I")
 I RECVDT<$$CUTOFF^RCDPEWLP Q ""  ; EFTs 2 months older than *298 installation do not lock the system
 S DAYSLIMT("M")=$$GET1^DIQ(344.61,1,.06),DAYSLIMT("P")=$$GET1^DIQ(344.61,1,.07)
 D CHKEFT^RCDPEWLP(RECVDT,EFTIEN,"B",.DAYSLIMT,.TRARRY)
 I $D(TRARRY("ERROR")) Q "**"
 I $D(TRARRY("WARNING")) Q "*"
 Q ""
