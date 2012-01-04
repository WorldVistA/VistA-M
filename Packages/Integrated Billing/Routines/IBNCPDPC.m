IBNCPDPC ;DALOI/SS - CLAIMS TRACKING EDITOR for ECME ;3/6/08  16:17
 ;;2.0;INTEGRATED BILLING;**276,339,363,384,435**;21-MAR-94;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CT(IBRXIEN,IBRXFIL) ; look up CT entry and call CT listman
 ; entry point for DBIA# 4693
 ; Input: IBRXIEN - internal Rx ien
 ;        IBRXFIL - fill#
 ;
 N IBTRN,DFN
 S IBTRN=+$O(^IBT(356,"ARXFL",+$G(IBRXIEN),+$G(IBRXFIL),0))
 I 'IBTRN D  Q
 . W !,"There is no Claims Tracking record for this prescription/fill."
 . D PAUSE^VALM1
 . Q
 ;
 S DFN=+$P($G(^IBT(356,IBTRN,0)),U,2)
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
PSOCPVW(IBDFN,IBRX,PSOTMP) ; return RX info
 ; IBDFN - patient's DFN
 ; IBRX - ien in #52
 ; output in .PSOTMP array
 ;
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
