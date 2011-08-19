IBNCPDPC ;DALOI/SS - CLAIMS TRACKING EDITOR for ECME ;3/6/08  16:17
 ;;2.0;INTEGRATED BILLING;**276,339,363,384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
% ; -- main entry point for IBT CLAIMS TRACKING EDIT
 ;DFN- patients IEN (file #2)
 ;IBECMEN - NCPDP/ECME number (last 7 digits of the IEN of file #52)
 ; that belong to this claim.
 ;ien in CLAIMS TRACKING file #356
 ;
CT(DFN,IBECMEN,IBREFNUM) ;
 Q:'$G(DFN)
 Q:'$G(IBECMEN)
 N IBTRN
 S IBTRN=+$$SELCT(IBECMEN,IBREFNUM)
 I +IBTRN=0 D  Q
 . W !,"There is no claims tracking record for this claim."
 . D PAUSE^VALM1
 D EN^VALM("IBNCPDP LSTMN CT")
 Q
 ;
EN ; -- main entry point for IBT EXPAND/EDIT TRACKING
 D EN^IBTRED
 Q
 ;
INIT ; -- init variables and list array
 D INIT^IBTRED
 Q
 ;
HELP ; -- help code
 D HELP^IBTRED
 Q
 ;
EXIT ; -- exit code
 D EXIT^IBTRED
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D BLANK^IBTRED(.LINE)
 Q
 ;
ETYP(IBTRN) ; -- Expand type of epidose and date
 Q $$ETYP^IBTRED(IBTRN)
 ;
ENCL(IBOE) ; -- output format of classifications
 Q $$ENCL^IBTRED(IBOE)
 ;
SELCT(IBECMEN,IBREFNUM) ;
 N IBRET,IB356
 S (IB356,IBRET)=0
 F  S IB356=+$O(^IBT(356,"AE",IBECMEN,IB356)) Q:((IB356=0)!(IBRET'=0))  D
 . I IBREFNUM=+$P($G(^IBT(356,IB356,0)),U,10) S IBRET=IB356
 Q +IBRET
 ;
 ;return RX info
 ;IBDFN - patient's DFN
 ;IBRX - ien in #52
 ;output in .PSOTMP array
PSOCPVW(IBDFN,IBRX,PSOTMP) ;
 Q:($G(IBDFN)=0)!($G(IBRX)=0)
 K ^TMP($J,"IBNCPDP-RXINFO")
 D RX^PSO52API(IBDFN,"IBNCPDP-RXINFO",IBRX,"",0)
 S PSOTMP(52,+$P(IBTRND,"^",8),.01,"E")=$G(^TMP($J,"IBNCPDP-RXINFO",IBDFN,IBRX,.01))
 S PSOTMP(52,+$P(IBTRND,"^",8),7,"E")=$G(^TMP($J,"IBNCPDP-RXINFO",IBDFN,IBRX,7))
 S PSOTMP(52,+$P(IBTRND,"^",8),8,"E")=$G(^TMP($J,"IBNCPDP-RXINFO",IBDFN,IBRX,8))
 S PSOTMP(52,+$P(IBTRND,"^",8),6,"E")=$P($G(^TMP($J,"IBNCPDP-RXINFO",IBDFN,IBRX,6)),U,2)
 K ^TMP($J,"IBNCPDP-RXINFO")
 Q
 ;
