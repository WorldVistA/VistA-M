IBCEFG5 ;ALB/TMP - OUTPUT FORMATTER MAINT -FLD SCREEN BLD UTILITIES ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**52,51**;21-MAR-94
 ;
INIT ; -- set up inital variables local form field list
 S VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
BLD ; -- build list of local form fields
 N IBFLD,IBCNT,X,IB2,IBFORM,IBASSOC,IBPG,IBLN,IBCOL,IB0
 K ^TMP("IBCEFLD",$J),^TMP("IBCEFLDDX",$J)
 I '$D(IBCEXDA) D CHGFORM^IBCEFG4 G:'$G(IBCEXDA) BLDQ
 S (IBCNT,VALMCNT)=0,IBPG=""
 ;
 ; -- find all form fields
 S IBFORM=$S('$P($G(^IBE(353,IBCEXDA,2)),U,5):IBCEXDA,1:$P(^(2),U,5))
 S IBASSOC=(IBFORM'=IBCEXDA)
 F  S IBPG=$O(^IBA(364.6,"ASEQ",IBFORM,IBPG)) Q:IBPG=""  S IBLN="" F  S IBLN=$O(^IBA(364.6,"ASEQ",IBFORM,IBPG,IBLN)) Q:IBLN=""  D
 .S IBCOL="" F  S IBCOL=$O(^IBA(364.6,"ASEQ",IBFORM,IBPG,IBLN,IBCOL)) Q:IBCOL=""  S IBFLD=0 F  S IBFLD=$O(^IBA(364.6,"ASEQ",IBFORM,IBPG,IBLN,IBCOL,IBFLD)) Q:'IBFLD  D
 ..S IBOVRIDE=$O(^IBA(364.6,"APAR",IBCEXDA,IBFLD,""))
 ..S Z=0 F  S Z=$O(^IBA(364.7,"B",IBFLD,Z)) Q:'Z  S IBCNT=IBCNT+1 D SET($$FLDS($G(^IBA(364.6,IBFLD,0)),$G(^IBA(364.7,Z,0)),1,IBCNT),IBFLD)
 ..S IBOVRIDE=0 F  S IBOVRIDE=$O(^IBA(364.6,"APAR",IBCEXDA,IBFLD,IBOVRIDE)) Q:'IBOVRIDE  I IBFLD'=IBOVRIDE D
 ...S Z=0 F  S Z=$O(^IBA(364.7,"B",IBOVRIDE,Z)) Q:'Z  S IBCNT=IBCNT+1 D SET($$FLDS($G(^IBA(364.6,IBOVRIDE,0)),$G(^IBA(364.7,Z,0)),0,IBCNT),IBOVRIDE)
 I '$D(^TMP("IBCEFLD",$J)) S VALMCNT=2,IBCNT=2,^TMP("IBCEFLD",$J,1,0)=" ",^TMP("IBCEFLD",$J,2,0)="    No Fields Currently Defined For Form"
BLDQ Q
 ;
FLDS(IB0,IBDEF,ORIG,IBCNT) ; Set up display fields
 ; IB0 = the 0-node of the 364.6 entry
 ; IBDEF = the 0-node of the defining 364.7 entry
 ; ORIG = local flag - 1 if overridden by local field, 0 if not overridden
 ; IBCNT = line counter for line being set
 N X,Z
 S X=""
 S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 S X=$$SETFLD^VALM1(IBPG,X,"PAGE")
 S X=$$SETFLD^VALM1(IBLN,X,"LINE")
 S X=$$SETFLD^VALM1(IBCOL,X,"COLUMN")
 S X=$$SETFLD^VALM1($S(ORIG:"",1:"*")_$P(IB0,U,10),X,"DESCR")
 S Z=$$EXTERNAL^DILFD(364.7,.06,"",$P(IBDEF,U,6)) S:Z="" Z="BOTH"
 S X=$$SETFLD^VALM1(Z,X,"BTYPE")
 S Z=$E($$EXTERNAL^DILFD(364.7,.05,"",$P(IBDEF,U,5)),1,25) S:Z="" Z="ALL"
 S X=$$SETFLD^VALM1(Z,X,"INSCO")
 S X=$$SETFLD^VALM1($P(IB0,U,9),X,"LENGTH")
 S X=$$SETFLD^VALM1($P(IB0,U,6),X,"MAX")
 S X=$$SETFLD^VALM1($S($P(IB0,U,11):"NO",1:"YES"),X,"OUTPUT")
 Q X
 ;
FNL ; Clean up local form fields list
 K ^TMP("IBCEFLDDX",$J)
 D CLEAN^VALM10
 Q
 ;
SET(X,FLD) ; -- set arrays for local form list
 ; X = the display text for ien (FLD)
 W "."
 S VALMCNT=VALMCNT+1,^TMP("IBCEFLD",$J,VALMCNT,0)=X
 S ^TMP("IBCEFLD",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBCEFLDDX",$J,IBCNT)=VALMCNT_"^"_FLD
 Q
 ;
HDR ; Set up hdr
 N IB2
 Q:'$G(IBCEXDA)
 S IB2=$G(^IBE(353,IBCEXDA,2))
 S VALMHDR(1)=$E("Bill Form: "_$P($G(^IBE(353,IBCEXDA,0)),U)_$J("",33),1,33)
 S VALMHDR(1)=VALMHDR(1)_$S($P(IB2,U,5)&($P(IB2,U,5)'=IBCEXDA):"Associated With Nat. Form: "_$P($G(^IBE(353,$P(IB2,U,5),0)),U),1:"Not Associated With A National Form")
 Q
 ;
