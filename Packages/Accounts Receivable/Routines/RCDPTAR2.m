RCDPTAR2 ;AITC/CJE - EFT TRANSACTION AUDIT REPORT (Continued) ;08/14/23
 ;;4.5;Accounts Receivable;**424,439,446**;Mar 20, 1995;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*424 - Moved subroutine RC from ^RCDPTAR and added FMS doc ID search
RC(RCDATA) ; Lookup by Receipt Number
 ; Input:   RCDATA  - null on entry
 ;          RCDET - Environmental variable assumed to be set to "R" - Reciept or "F" - FMS Document
 ; Output:  RCDATA  - passed by refence - see subroutine EFTDATA for delimited list of fields
 ;
 N D,DIC,DTOUT,DUOUT,EFTIEN,ERAIEN,RCDTN,RCED,RCIEN,STOP,X,Y
 S STOP=0
RC2 ;
 W !
 S DIC="^RCY(344,"
 S DIC(0)=$S(RCDET="F":"QEAn",1:"QEAMn")
 S DIC("A")=$S(RCDET="F":"Select FMS DOCUMENT NUMBER: ",1:"Select RECEIPT: ")
 S DIC("W")="D DICW^RCDPUREC"
 S DIC("S")="I $$EDILBEV^RCDPEU($P($G(^(0)),U,4))"
 I RCDET="R" D ^DIC
 I RCDET="F" S D="ADOC" D IX^DIC
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
 . S RCDATA=$$EFT^RCDPTAR(RCED)
 ;
 ; If this AR Deposit record is not found, check if it is a receipt on the ERA
 I 'RCIEN D
 . S ERAIEN=$O(^RCY(344.4,"H",+Y,""))
 . I 'ERAIEN S ERAIEN=$O(^RCY(344.4,"ARCT",+Y,""))
 . I 'ERAIEN Q
 . S EFTIEN=$O(^RCY(344.31,"AERA",ERAIEN,""))
 . I EFTIEN S RCDATA=$$EFTDATA^RCDPTAR(EFTIEN)
 ;
 I RCDATA="" D  G RC2
 . W !!,"EFT NOT FOUND - please check Receipt"
 . D PAUSE^RCDPTAR
 ;
 Q:RCDATA=-1
 Q:RCDATA=""                                    ; No EFTs found
 D SHOWONE^RCDPTAR(.STOP)                       ; Display output
 Q:STOP
 G RC2
 Q
 ;
DEPBAL(RCDIEN) ;Is the deposit total in balance with EFT amounts ; New subroutine PRCA*4.5*439
 ;
 ; If modified, also check DEPBAL^RCDPEDA4
 ; Input:   RCDIEN  - IEN for EDI LOCKBOX DEPOSIT, #344.3
 ;
 ; Output:  RCBALS, returned via function call
 ;          Piece 1 - 1 if in balance, 0 if out of balance
 ;          Piece 2 - null (no longer needed PRCA*4.5*446) Total of EFTs on the deposit
 ;          Piece 3 - Deposit Total
 ;
 ; PRCA*4.5*446, Modify sub-routine to use unbalanced flag in 344.3
 ;
 N DTOT,DEPDATA,EFTDATA,RCBALS
 S RCBALS="0^^0"
 ;
 Q:'$G(RCDIEN) RCBALS                                           ; Error condition, IEN is missing or incorrect
 ;
 S DEPDATA=$G(^RCY(344.3,RCDIEN,0)) Q:'$L($G(DEPDATA)) RCBALS   ; Quit if zero node does not exist or has bad data
 S DTOT=$P(DEPDATA,U,8)                                         ; Get total deposit amount
 ;
 S $P(RCBALS,U,3)=DTOT
 S $P(RCBALS,U,1)='$$GET1^DIQ(344.3,RCDIEN_",",.15,"I")         ; Equal to 1 if inbalance, 0 otherwise
 ;
 Q RCBALS
 ;
 ;Moved ASKSUM2 from RCDPTAR to RCDPTAR2 because of space, PRCA*4.5*439
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
  ;Moved HEADER from RCDPTAR to RCDPTAR2 because of space, PRCA*4.5*439
HEADER(RCNOW,RCPG,RCHR,RCDATA,RCDBAL) ; Print Header Section
 ; Input: RCNOW - DATE/TIME in external format
 ;        RCPG - Current page number
 ;        RCHR - Line of "-" to margin width
 ;        RCDATA - See subroutine EFTDA about for delimited list of fields
 ;        RCDBAL  - Piece 1: 1 if deposit is in balance, 0 otherwise   ; Add parameter PRCA*4.5*439
 ;                  Piece 2: Total of EFTs on the deposit
 ;                  Piece 3: Deposit Total
 ; Output: Write statements
 ;
 I '$L($G(RCDBAL)) S RCDBAL=1   ; if RCDBAL was not passed, set to 1 to indicate deposit is in balance  PRCA*4.5*439
 N EFTDATA,LINE
 S EFTDATA=$G(^RCY(344.31,+$P(RCDATA,U,3),0))
 ;
 W @IOF
 S RCPG=RCPG+1
 W "EFT TRANSACTION AUDIT REPORT"
 S LINE=RCNOW_"   PAGE: "_RCPG_" "
 W ?(IOM-$L(LINE)),LINE
 ; Added EFT line identifier nnn.nn - PRCA*4.5*326
 W !,"EFT#: ",$$AGED^RCDPTAR(+$P(RCDATA,U,3)),$$GET1^DIQ(344.31,$P(RCDATA,U,3)_",",.01,"E"),?19,"DEPOSIT#: ",$P($G(^RCY(344.3,+$P(RCDATA,U,2),0)),U,6)
 I 'RCDBAL W "  *UNBAL*",?51,"EFT TOTAL AMT: "_$S($P(EFTDATA,U,16)="D":"-",1:"")_$P(EFTDATA,U,7)  ; If Out of Balance Deposit PRCA*4.5*439
 I RCDBAL W ?42,"EFT TOTAL AMT: "_$S($P(EFTDATA,U,16)="D":"-",1:"")_$P(EFTDATA,U,7)   ; If not Out of Balance Deposit PRCA*4.5*439
 W !,"EFT TRACE#: ",$P(EFTDATA,U,4)
 W !,"DATE RECEIVED: ",$$DATE^RCDPRU($P(EFTDATA,U,12)),?26,"PAYER/ID: "_$P(EFTDATA,U,2)_"/"_$P(EFTDATA,U,3)
 ;
 W !,"DATE",?10,"ACTION/DETAILS",?51,"STATUS"
 W !,RCHR
 Q
 ;
MDATE(STATUS,EFTIEN) ; Finds the Match Date from the Match History Global for the EFT
 ; Input:   STATUS  - Internal value from the EFT MATCH STATUS field
 ;          EFTIEN  - EDI THIRD PARTY EFT DETAIL (#344.31) IEN
 ; Returns: Match Date from the MATCH STATUS HISTORY (#344.314) multiple
 ;
 ; Validate Parameters.  If STATUS is equal to UNMATCHED, quit with "" (no match date)
 I $G(STATUS)=0 Q ""
 I $G(EFTIEN)="" Q ""
 ;
 N MIEN,RCDATA,IENS
 ;
 ; Get last record from the Match status history global.  If no history, then quit with "" (no match date)
 S MIEN=$O(^RCY(344.31,EFTIEN,4,999999),-1)
 I 'MIEN Q "<No History>"
 ;
 ; Get data from match history
 S IENS=MIEN_","_EFTIEN_","
 D GETS^DIQ(344.314,IENS,".01;.02","I","RCDATA")
 ;
 ; If the most recent record is UNMATCHED, then it is does not match the EFT status so return "" (no match date)
 I RCDATA(344.314,IENS,.01,"I")=0 Q ""
 Q RCDATA(344.314,IENS,.02,"I")
 ;
