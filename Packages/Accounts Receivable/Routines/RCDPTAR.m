RCDPTAR ;ALB/TJB - EFT TRANSACTION AUDIT REPORT ;1/02/15
 ;;4.5;Accounts Receivable;**303,321,326,380,371,424,439,446**;Mar 20, 1995;Build 15
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
 S:RCREP="S" RCREP2=$$ASKSUM2^RCDPTAR2()
 Q:RCREP2=-1
 ;
 I RCREP="S",RCREP2=1 D SUM^RCDPTAR1
 I RCREP="S",RCREP2=2 D SUM2^RCDPTAR1
 I RCREP="D" D DET
 Q
 ;
 ; PRCA*4.5*439 Moved subroutine ASKSUM2 to RCDPTAR2 because of space, PRCA*4.5*380 - New Subroutine added
 ;
DET ; Entry point for detailed report
 ; Input: variable RCREP defined and equal to "D"
 ; Output: Written to device
 ;
 N RCDATA,RCDET
 ;
DET1 ; Prompt for user selection criteria
 K DIR
 S DIR(0)="SO^N:Deposit Number;D:Deposit Date;R:Receipt Number;T:Trace Number;F:FMS Document Number"
 ; PRCA*4.5*424 - Begin changed block - Add search by FMS document number
 S DIR("PRE")="S:X?1N X=$S(X=1:""N"",X=2:""D"",X=3:""R"",X=4:""T"",X=5:""F"",1:""X"")"
 S DIR("L",1)="Search for EFT Number by:"
 S DIR("L",2)=""
 S DIR("L",3)="  1. Deposit (N)umber"
 S DIR("L",4)="  2. Deposit (D)ate"
 S DIR("L",5)="  3. (R)eceipt #"
 S DIR("L",6)="  4. (T)race #"
 S DIR("L")="  5. (F)MS Document Number"
 S DIR("A")="Search for EFT by"
 ; End PRCA*4.5*424 changes
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCDET=Y
 ;
 ; Do lookup of EFTs based on the user selection above
 S RCDATA=""
 ; PRCA*4.5*424 - Move subroutine RC to RCDPTAR2 for size and add FMS doc ID search
 D @($S(RCDET="N":"DN",RCDET="D":"DT",RCDET="R"!(RCDET="F"):"RC^RCDPTAR2",1:"TR")_"(.RCDATA)")
 Q
 ;
SHOWONE(STOP) ; Prompt for device and output data for one EFT
 ; Input:   STOP    - Initially set to 0
 ; Output:  STOP    - 1 user entered '^', 0 otherwise
 ;I '$L($G(RCDBAL)) S RCDBAL=1   ; If RCDBAL wasn't passed, reset the value
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
 D RUN(RCDATA)  ; Add parameter RCDBAL PRCA*4.5*439
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
 N DIC,DTOUT,DUOUT,LOCKIEN,RCBAL,RCDBAL,RCDBAL1,RCDEFLUP,STOP,USERDN,Y
 S STOP=0
 ;
DN2 ; Lookup Deposit Number
 ; PRCA*4.5*439 Begin
 N ARR,CDDT,CTR
 N RCDDT,RCDIEN,RCDNUM,XRCDT1,XRCDT2,RCEFTCNT,RCLOOP,RCSTOP,XX ; PRCA*4.5*439 add RCDIEN,RCLOOP
 N RCDNUM
 S RCLOOP=0
 S RCDNUM=$$ASKDNUM^RCDPTAR1()                  ; Select deposit number
 I RCDNUM=-1 S RCDATA=-1 Q                      ; Quit if user did not select a valid deposit number
 ;
 S LOCKIEN=+$O(^RCY(344.3,"C",RCDNUM,""))
 I 'LOCKIEN D  G DN2
 . W !!,"EFT NOT FOUND - please check Deposit"
 . D PAUSE
 ;
DN3 ; Lookup Deposit Number by Deposit Date
 I RCLOOP,$G(CTR)<2 Q                          ; PRCA*4.5*439
 S CTR=0,RCDDT="",CDDT="",RCSTOP=0
 F  D  Q:RCDDT'=""  Q:RCSTOP
 . I CTR=0 W !,"Select Deposit:"                ; Move inside loop, PRCA*4.5*439
 . S CDDT=$O(^RCY(344.3,"ADEP2",RCDNUM,CDDT),-1)
 . I CDDT="" D  Q                               ; No more Deposit Dates to display for Deposit Number
 . . Q:CTR=0
 . . S RCDDT=$$SELDT^RCDPTAR1(CTR,.ARR,RCLOOP)  ; Final selection choice ; PRCA*4.5*439 add RCLOOP to call
 . . I RCDDT=-1 S RCSTOP=1
 . S CTR=CTR+1,ARR(CTR)=CDDT
 . S XX=$$FMTE^XLFDT(CDDT,"5DZ")
 . W !,$J(CTR,3)," ",RCDNUM," on: ",XX
 . S RCDIEN="",RCDBAL="1^0^0"
 . F  S RCDIEN=$O(^RCY(344.3,"ADEP2",RCDNUM,CDDT,RCDIEN)) Q:'RCDIEN  D  ; PRCA*4.5*439
 . . S RCDBAL1=$$DEPBAL^RCDPTAR2(RCDIEN)        ; Is deposit in balance with EFT totals, PRCA*4.5*439
 . . S $P(RCDBAL,U,3)=$P(RCDBAL,U,3)+$P(RCDBAL1,U,3)
 . . S:'$P(RCDBAL1,U,1) $P(RCDBAL,U,1)=0        ;Check for out of balance PRCA*4.5*446
 . W $J($P(RCDBAL,U,3),19,2)                    ; Deposit total
 . I 'RCDBAL W " **UNBALANCED**"                ; Add UNBALANCED indicator if deposit is not in balance, PRCA*4.5*439
 . I CTR#10=0 D  Q:RCDDT'=""                    ; Ask selection every 10 times
 . . S RCDDT=$$SELDT^RCDPTAR1(CTR,.ARR,RCLOOP)  ; PRCA*4.5*439 add RCLOOP to parameters
 . . I RCDDT=-1 S RCSTOP=1
 Q:RCDDT=""  Q:RCSTOP                           ; No Deposit Date selected
 ;
DN4 S RCDATA=$$DEPEFTS^RCDPTAR1(RCDNUM,RCDDT,.RCEFTCNT)
 S RCLOOP=1                                     ; PRCA*4.5*439
 I RCDATA=0 G DN3
 ;
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE(.STOP)                               ; Display output
 Q:STOP
 I RCEFTCNT=1 G DN3                             ; Don't loop back to EFT selection if only one,  PRCA*4.5*439
 G DN4                                          ; Otherwise, go back to DN4 to select a different EFT
 ; PRCA*4.5*439 - End Modified code block
 Q
 ;
DT(RCDATA) ; Deposit Date
 ; Input:   RCDATA  - null on entry
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 ;
 N CNT,DATA,DEPIEN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ITEM,LINE,LIST,RCDBAL,RCDT,RCI,RCIEN,RCLOOP,STOP,X,Y
 S (RCLOOP,STOP)=0
 ;
DT1 ; Ask the user for the Deposit Date
 K DIR
 S DIR(0)="DAO^:"_DT_":APE"
 S DIR("B")=$S($G(RCLOOP):"",1:"T") ; PRCA*4.5*439
 S DIR("A")="Select DEPOSIT DATE: "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S RCDATA=-1 Q
 I $G(RCLOOP),Y="" S RCDATA=-1 Q  ; PRCA*4.5*439
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
 . . S RCDBAL=$$DEPBAL^RCDPTAR2(RCIEN)
 . . S $E(LINE,19)="by: "_$E($P($G(^VA(200,+$P(DATA,"^",6),0)),"^"),1,15)
 . . I '$P(DATA,"^",7) S $P(DATA,"^",7)="???????"
 . . S $E(LINE,39)="on: "_$E($P(DATA,"^",7),4,5)_"/"_$E($P(DATA,"^",7),6,7)_"/"_$E($P(DATA,"^",7),2,3)
 . . S $E(LINE,52)="amt: $"_$J($P(DATA,"^",4),10,2)
 . . I 'RCDBAL S $E(LINE,69)="UNBALANCED" ;Check deposit balance, change 70 -> 69 PRCA*4.5*439
 . . I RCDBAL S $E(LINE,69)=$P("N/A^OPEN^DEPOSITED^CONFIRMED^PROCESSED^VOID","^",+$P(DATA,"^",12)+1)  ;Check deposit balance, change 70 -> 69 PRCA*4.5*439
 . . S LIST(CNT)=RCIEN_"^"_$P(DATA,U,1)_"^"_LINE
 ;
 ; If no deposits in the LIST, display a message and try again
 I CNT=0 D  G DT1
 . W !,"Date ",$$DATE^RCDPRU(RCDT)," does not have any valid deposits, please try again...",!
 ;
 ; If only one deposit in the list, use it
 I CNT=1 D  Q:STOP  G DT1
 . S RCDATA=$$EFT(+LIST(CNT))
 . ;
 . Q:RCDATA=-1
 . Q:RCDATA=""                                  ; No EFTs found
 . D SHOWONE(.STOP)                             ; Display output
 . S RCLOOP=1                                   ; PRCA*4.5*439
 ;
DT2 ; Multiple entries found so prompt for the one that is wanted
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
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 S RCDBAL=$$DEPBAL^RCDPTAR2(ITEM(Y))            ; Reset unbalanced flag. Set again once deposit is selected, PRCA*4.5*439
 D SHOWONE(.STOP)                               ; Display output
 S RCLOOP=1                                     ; PRCA*4.5*439
 Q:STOP
 G DT2
 Q
 ;
TR(RCDATA) ; Lookup by Trace Number
 ; Input:   RCDATA  - null on entry
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 N D,DIC,DTOUT,DUOUT,STOP,X,Y
 S STOP=0
 ;
TR2 ; Use "F" index in EDI EFT Detail file
 W !
 S DIC="^RCY(344.31,",DIC(0)="QEASn",D="F",DIC("A")="Select TRACE: "
 ; DIC("W") may need to be fixed if Trace numbers go over 32 characters. The fields
 ; displayed are the EFT#, Insurance company name, amount and Date Recieved.
 S DIC("W")="D EN^DDIOL($J($P(^(0),U,1),7)_"" ""_$$LJ^XLFSTR($E($P(^(0),U,2),1,20),20)_$J(($S($P(^(0),U,16)=""D"":""-"",1:"""")_$P(^(0),U,7)),10)_"" ""_$$DATE^RCDPRU($P(^(0),U,13)),,""?32"")"
 D IX^DIC
 I $D(DTOUT)!$D(DUOUT)!(Y=-1) S RCDATA=-1 Q
 S RCDATA=$$EFTDATA(+Y)
 ;
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE(.STOP)                               ; Display output
 Q:STOP
 G TR2
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
 ; Display list of EFTs. Manual display and reading so we can put data on two lines. PRCA*4.5*439
 N ROW,TRANS,X
 W !!,"Deposit #: "_$J($$GET1^DIQ(344.3,LOCKIEN_",",.06),10)_"   "
 W "Deposit Date: "_$$DATE^RCDPRU($$GET1^DIQ(344.3,LOCKIEN_",",.07,"I"),"2DZ")
 I '$$DEPBAL^RCDPTAR2(LOCKIEN) W "  **UNBALANCED**" ; Check for unbalanced deposit PRCA*4.5*439
 N LCNT,QUIT   ; RCA*4.5*439
 S LCNT=0,QUIT=0,Y=-1
 F ROW=1:1:CNT D  Q:QUIT
 . S DATA=LIST(ROW),EFTIEN=$P(DATA,U,3)
 . D DISPLAY(ROW,EFTIEN)
 S Y=$$READ(1,ROW,CNT)
 I Y'>0 Q -1
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
DISPLAY(ROW,EFTIEN,TRANS) ; Display EFT detail during user selection process  ; PRCA*4.5*439 Modified display
 ; Input: ROW    - Current row number
 ;        EFTIEN - IEN for EFT (#344.31)
 ;        TRANS  - EFT transaction number e.g. 999.1
 ;
 ; Output is written to the screen
 N PAYER,SUFX,TRANS
 S TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.01,"I")
 S SUFX=$$GET1^DIQ(344.31,EFTIEN_",",.14)
 S:SUFX SUFX="."_SUFX
 S PAYER=$$GET1^DIQ(344.31,EFTIEN_",",.02)
 ;
 W !,$E(ROW_".     ",1,5)                            ; Row Number
 W $J(TRANS_SUFX,9)                                  ; EFT number with suffix
 W " "_$E(PAYER,1,45)_$E($J("",45),1,45-$L(PAYER))   ; Payer Name
 W " "_$J($$GET1^DIQ(344.31,EFTIEN_",",.07),19)      ; Amount
 W !,$J(" ",15)_$$GET1^DIQ(344.31,EFTIEN_",",.04)    ; Trace number
 Q
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
 N CNT,DATE,DATA,LINES,RCDBAL,RCHR,RCNOW,RCPG,RCSCR
 ;
 ; Initialize Report Date, Page Number and String of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU()),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 S RCDBAL=$$DEPBAL^RCDPTAR2($P(RCDATA,U,2))
 ;
 U IO
 D HEADER^RCDPTAR2(RCNOW,.RCPG,RCHR,RCDATA,RCDBAL)  ; Add parameter RCDBAL PRCA*4.5*439
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
 I RCPG,RCSCR S STOP=$S('$$PAUSE():1,1:0)
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
 D HEADER^RCDPTAR2(RCNOW,.RCPG,RCHR,RCDATA)
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
 ; Read EFT line manually PRCA*4.5*439
READ(BEG,END,CNT) ; Read number of EFT line from 1 to END
 ; Input: BEG - Begining of current numeric range displayed
 ;        END - End of numeric current range displayed
 ;        CNT - Number of last record in the list
 N DIR,DTOUT,DUOUT,DIRUT,X,Y
 S DIR(0)="NOA^"_BEG_":"_END
 I END'=CNT S DIR("A",1)="Press <Enter> to see more, '^' to exit this list,  OR"
 S DIR("A")="CHOOSE "_BEG_"-"_END_": "
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 Q Y
