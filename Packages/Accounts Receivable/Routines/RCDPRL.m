RCDPRL ;AITC/CJE - list of receipts report ;23 Aug 2017
 ;;4.5;Accounts Receivable;**321**;;Build 48
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for RCDP LIST OF RECIEPTS REPORT
 N RCDPFXIT
 D EN^VALM("RCDP LIST OF RECEIPTS REPORT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=^TMP($J,"RCDPRLIS","HDR",2)
 S VALMHDR(2)=^TMP($J,"RCDPRLIS","HDR",3)
 S VALMHDR(3)=^TMP($J,"RCDPRLIS","HDR",4)
 Q
 ;
INIT ; -- init variables and list array
 N K
 S (K,VALMCNT)=0
 F  S K=$O(^TMP($J,"RCDPRLIS",K)) Q:'K  D  ;
 . S VALMCNT=VALMCNT+1
 . D SET^VALM10(VALMCNT,^TMP($J,"RCDPRLIS",K),VALMCNT)
 Q
 ;
RP ; EP - Launch receipt processing list template
 ; Input: None
 ; Output: None
 ;
 N IBFASTXT,RCRECTDA,RCK
 D EN^VALM2($G(XQORNOD(0)),"S")
 I '$D(VALMY) Q
 ;
 S VALMBCK="R"
 S RCK=0
 F  S RCK=$O(VALMY(RCK)) Q:'RCK!$G(RCDPFXIT)  D  ;
 . S RCRECTDA=$G(^TMP($J,"RCDPRLIS","IDX",RCK))
 . D EN^VALM("RCDP RECEIPT PROFILE")
 . ; fast exit
 . I $G(RCDPFXIT) S RCRECTDA=0
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 Q
 ;
