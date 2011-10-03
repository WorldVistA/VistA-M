IBCEM1 ;ALB/TMP - 837 EDI RETURN MESSAGE MAIN LIST TEMPLATE ;02-MAY-96
 ;;2.0;INTEGRATED BILLING;**137,155**;21-MAR-94
 ;
EN ; Main entry point
 D DT^DICRW
 K XQORS,VALMEVL,IBFASTXT,IBDA
 D EN^VALM("IBCEM 837 MESSAGE LIST")
 K IBFASTXT,IBDA
 Q
 ;
INIT ; -- set up inital variables
 S U="^",VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
REBLD ; Set up formatted global
 ;
BLD ; -- build list of messages
 N IBCNT,IBEOB,IBMSGT,IBMSG,X,IB0
 K ^TMP("IBCEM-837",$J),^TMP("IBCEM-837DX",$J)
 S (IBCNT,IBMSG,VALMCNT)=0,IBEOB=+$O(^IBE(364.3,"B","835EOB",0))
 F  S IBMSG=$O(^IBA(364.2,IBMSG)) Q:'IBMSG  S IB0=$G(^(IBMSG,0)) D
 . N IBSTOP
 . S IBSTOP=0
 . S IBMSGT=$P(IB0,U,2)
 . I IBMSGT,IBEOB,IBMSGT=IBEOB D  Q:IBSTOP
 .. N Z,Z0 ; Only allow MRA EOB's to be viewed
 .. S Z=0 F  S Z=$O(^IBA(364.2,IBMSG,2,Z)) Q:'Z!(IBSTOP)  S Z0=$G(^(Z,0)) I $E(Z0,1,12)="##RAW DATA: ",$E(Z0,13,18)="835EOB",$P(Z0,U,5)'="Y" S IBSTOP=1 Q
 . ; -- add to list
 . S IBCNT=IBCNT+1,X=""
 . S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1($$FMTE^XLFDT($P(IB0,U,3),2),X,"DATEREC")
 . I IB0'="" S X=$$SETFLD^VALM1($$FMTE^XLFDT($P(IB0,U,10),2),X,"DATEMSG")
 . S X=$$SETFLD^VALM1(+IB0,X,"MENTRY")
 . S Z=$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U,6) S:Z="EOB" Z="MRA"
 . S X=$$SETFLD^VALM1($E(Z_$J("",6),1,6),X,"TYPE")
 . S X=$$SETFLD^VALM1($P($G(^IBA(364.1,+$P(IB0,U,4),0)),U),X,"BATCH")
 . S X=$$SETFLD^VALM1($$BILLNO($P(IB0,U,5)),X,"BILL")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(364.2,.06,$P(IB0,U,6)),X,"STATUS")
 . D SET(X)
 ;
 I '$D(^TMP("IBCEM-837",$J)) S VALMCNT=2,IBCNT=2,^TMP("IBCEM-837",$J,1,0)=" ",^TMP("IBCEM-837",$J,2,0)="   All Incoming EDI Messages For Billing Have Filed - No Action Needed"
 Q
 ;
FNL ; -- Clean up list
 K ^TMP("IBCEM-837DX",$J)
 D CLEAN^VALM10
 K IBFASTXT
 Q
 ;
SET(X) ; -- set arrays for 837 return messages
 S VALMCNT=VALMCNT+1,^TMP("IBCEM-837",$J,VALMCNT,0)=X
 S ^TMP("IBCEM-837",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBCEM-837DX",$J,IBCNT)=VALMCNT_U_IBMSG
 Q
 ;
BILLNO(DA) ; Return bill # from entry in file 364
 N Z
 S Z=$P($G(^DGCR(399,+$P($G(^IBA(364,+DA,0)),U),0)),U)
 Q $S($L(Z):Z,1:DA)
 ;
BATNO(DA) ; Return batch # from entry in file 364
 Q $P($G(^IBA(364.1,+$P($G(^IBA(364,+DA,0)),U,2),0)),U)
 ;
HDR ;
 S VALMHDR(1)=$J("",17)_"RETURN MESSAGES NEEDING TO BE FILED"
 S VALMHDR(2)=" "
 Q
 ;
