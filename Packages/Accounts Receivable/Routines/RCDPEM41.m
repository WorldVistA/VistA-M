RCDPEM41 ;OIFO-BAYPINES/MR - EPAYMENTS AUDIT REPORTS - Cont. ;Jul 01, 2014@02:11:19
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
SVERA(ERAIEN,STA,STNUM,STNAM) ;Put the data into the ^TMP global
 ; INPUTS: ERAIEN = ien of the ERA
 ;         STNUM = station IEN
 ; RETURNS  : Builds each entry in the ^TMP global
 ;
 N SUB,CNT,USER,DATE,Y,DEPO,ERA,REC,MATCH,POST
 S REC(0)=$G(^RCY(344.4,ERAIEN,0)),REC(7)=$G(^(7))
 ;User marked ERA as posted to paper EOB
 S USER=$$NAME^XUSER($P(REC(7),U,2),"F")
 ;Date/Time ERA was marked posted 
 S DATE=$$FMTE^XLFDT($P(REC(7),U),"2S")
 ;ERA number
 S ERA=$P(REC(0),U)
 ;Deposit
 S DEPO=$$EXTERNAL^DILFD(344.4,.08,,$P(REC(0),U,8))
 ;EFT Match Status
 S MATCH=$$EXTERNAL^DILFD(344.4,.09,,$P(REC(0),U,9))
 ;Detail Post Status
 S POST=$$EXTERNAL^DILFD(344.4,.14,,$P(REC(0),U,14))
 ;
 S SUB=$S(RCDIV=2:"DIV",1:"ALL"),CNT=$G(^TMP(RCPROG,$J,SUB,0))+1,^(0)=CNT
 S ^TMP(RCPROG,$J,SUB,CNT)=STNAM_U_STNUM_U_DATE_U_USER_U_ERA_U_DEPO_U_MATCH_U_POST
 Q
 ;
SVEOB(EOBIEN,IEN101,STA,STNUM,STNAM) ;Put the data into ^TMP global
 ; INPUTS: EOBIEN = ien of the EOB
 ;         STNUM= station ien
 ; RETURNS  : Builds each entry in the ^TMP global
 ;
 N CNT,SUB,USER,DATE,Y,DEPO,REC101,JUST,ORIG,TRACE,ERA,PAYAMT,OTHER,NBILL,X,ACTION
 ; ^IBM(361.1,0) = EXPLANATION OF BENEFITS^361.1PI
 S REC101=$G(^IBM(361.1,EOBIEN,101,IEN101,0))
 ; User who did MOVE/COPY/REMOVE
 S USER=$$NAME^XUSER($P(REC101,U,2),"F")
 ;Date/Time ERA was marked posted 
 S DATE=$$FMTE^XLFDT($P(REC101,U),"2S")
 ;Justification comment
 S JUST=$P(REC101,U,3)
 ;Moved, Copied or Removed
 S ACTION=$P(REC101,U,5) I RCACT'="A" Q:ACTION'=RCACT
 S ACTION=$S(ACTION="C":"COPIED",ACTION="M":"MOVED",ACTION="R":"REMOVED",1:"")
 ;Original bill pointer
 S ORIG=$P(REC101,U,4)
 ;Ignore if original bill is null (this is EOB copied from)
 I ACTION'="REMOVED" Q:'ORIG
 ;Get claim number from pointer
 S ORIG=$$EXTERNAL^DILFD(361.1,.01,,ORIG)
 S X=$O(^PRCA(430,"D",ORIG,""))
 I $G(X) S X=$P($G(^PRCA(430,X,0)),U) I X'="" S ORIG=$TR(X,"-","")
 ;New Bill (only displayed for a move)
 S NBILL=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,EOBIEN,0)),U))
 ;Paid Amount
 S PAYAMT=$P($G(^IBM(361.1,EOBIEN,1)),U)
 ;Trace Number
 S TRACE=$P($G(^IBM(361.1,EOBIEN,0)),U,7),ERA=""
 ;ERA number
 S:TRACE]"" ERA=$O(^RCY(344.4,"D",TRACE,""))
 ;Other bill numbers
 S OTHER=$$OTHER(EOBIEN,IEN101)
 ;
 S SUB=$S(RCDIV=2:"DIV",1:"ALL"),CNT=$G(^TMP(RCPROG,$J,SUB))+1,^(SUB)=CNT
 S ^TMP(RCPROG,$J,SUB,CNT)=STNAM_U_STNUM_U_DATE_U_USER_U_ORIG_U_NBILL_U_ERA_U_TRACE_U_PAYAMT_U_JUST_U_OTHER_U_ACTION
 Q
 ;
OTHER(EOBIEN,IEN101) ;Build list of bill numbers
 N SUB,NBILL,STR,FOUND
 S SUB=0,FOUND=0,STR=""
 F  S SUB=$O(^IBM(361.1,EOBIEN,101,IEN101,1,SUB)) Q:'SUB  D
 .S NBILL=$G(^IBM(361.1,EOBIEN,101,IEN101,1,SUB,0)) Q:'NBILL
 .S NBILL=$$EXTERNAL^DILFD(361.1,.01,,NBILL)
 .I FOUND S STR=STR_", "
 .S STR=STR_NBILL,FOUND=1
 S:'FOUND STR=STR_"NONE"
 Q STR
