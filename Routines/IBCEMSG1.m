IBCEMSG1 ;ALB/JEH - EDI PURGE STATUS MESSAGES CONT. ;04-MAY-01
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; - main entry
 N IBDELDT,IBIEN,IBMSG,IBSORT,IBQUIT,IBFNR,IBFRD,IBREC,IBNUM,IBSEV,IB0,IBK
 D EN^VALM("IBCEM STATUS MESSAGE")
 Q
HDR ; -- header code
 S VALMHDR(1)="Selected by "_$S(IBSORT="A":"Auto Filed/No Review",IBSORT="B":"Bill Number: "_IBNUM,IBSORT="S":"Message Severity: "_IBSEV,1:"Message Text containing word or phrase "_IBMSG)
 S VALMHDR(2)="Reviewed Prior to: "_$$FMTE^XLFDT(IBDELDT,"2D")
 Q
 ;
INIT ; -- set up variables
 N DIR,X,Y
 K ^TMP("IBCEMSGA",$J)
 S DIR("A")="Select messages based on"
 S DIR(0)="S^A:Auto Filed/No Review Only;B:Bill Number;S:Message Severity;T:Specific Message Text"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y<0) S VALMQUIT=1 G INITQ
 S IBSORT=Y
 I IBSORT="B" D  G:$G(VALMQUIT) INITQ
 . S DIR("A")="Enter Bill Number"
 . S DIR(0)="P^361:AEMQZ"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y<0) S VALMQUIT=1 Q
 . S IBIEN=$P(Y,U,2),IBNUM=$$BN1^PRCAFN(IBIEN)
 I IBSORT="S" D  G:$G(VALMQUIT) INITQ
 . S DIR("A")="(I)nformation/Warning or (R)ejection"
 . S DIR(0)="SB^I:Information/Warning;R:Rejection"
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT)!(Y<0) S VALMQUIT=1 Q
 . S IBSEV=Y
 I IBSORT="T" D  G:$G(VALMQUIT) INITQ
 . S DIR("A")="Enter specific word or phrase the message should contain to be deleted"
 . S DIR(0)="F^5:15^K:X'?.U X"
 . D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT)!(Y<0) S VALMQUIT=1 Q
 . S IBMSG=Y
 S DIR("A")="INCLUDE STATUS MESSAGES REVIEWED PRIOR TO"
 S DIR(0)="D^:DTP:EX" W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 Q
 S IBDELDT=Y
 D @IBSORT
 D BLD^IBCEMSG2
INITQ ;
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ; -- clean up and exit
 K ^TMP("IBCEMSGA",$J),^TMP("IBCEMSGB",$J)
 D CLEAN^VALM10
 Q
A ; -- sort by auto filed
 S IBK=0 F  S IBK=$O(^IBM(361,"ANR",1,IBK)) Q:'IBK  S IB0=$G(^IBM(361,IBK,0)) D
 . I '$P(IB0,U,13)!($P(IB0,U,13)>IBDELDT) Q
 . D SET
 Q
 ;
B ; -- sort by bill number
 S IBK=0 F  S IBK=$O(^IBM(361,"B",IBIEN,IBK)) Q:'IBK  S IB0=$G(^IBM(361,IBK,0)) D
 . I '$P(IB0,U,13)!($P(IB0,U,13)>IBDELDT) Q
 . D SET
 Q
 ;
S ; -- sort by message severity
 S IBK=0 F  S IBK=$O(^IBM(361,"ASV",IBSEV,IBK)) Q:'IBK  S IB0=$G(^IBM(361,IBK,0)) D
 . I '$P(IB0,U,13)!($P(IB0,U,13)>IBDELDT) Q
 . D SET
 Q
 ;
T ; -- sort by message text
 N Z,IBTXT,IB,IBDT
 S IBDT=0 F  S IBDT=$O(^IBM(361,"AFR",IBDT)) Q:'IBDT!(IBDT>IBDELDT)  S IBK=0 F  S IBK=$O(^IBM(361,"AFR",IBDT,IBK)) Q:'IBK  S IB0=$G(^IBM(361,IBK,0)) D
 . I '$O(^IBM(361,IBK,1,0)) Q
 . S IB=0 F  S IB=$O(^IBM(361,IBK,1,IB)) Q:'IB  S Z=$G(^IBM(361,IBK,1,IB,0)) I $$UPPER^VALM1(Z)[IBMSG S IBTXT=$E(Z,1,60) D
 .. D SET
 .. S ^TMP("IBCEMSGA",$J,IBK)=^TMP("IBCEMSGA",$J,IBK)_U_IBTXT
 Q
 ;
SET S IBNUM=$$BN1^PRCAFN($P(IB0,U))
 S IBSEV=$$EXPAND^IBTRE(361,.03,$P(IB0,U,3))
 S IBFNR=$$EXPAND^IBTRE(361,.1,$P(IB0,U,10))
 S IBFRD=$$DAT1^IBOUTL($P(IB0,U,13))
 S IBAUTO=$$EXPAND^IBTRE(361,.14,$P(IB0,U,14))
 S ^TMP("IBCEMSGA",$J,IBK)=IBNUM_U_IBSEV_U_IBFNR_U_IBFRD_U_IBAUTO
 Q
