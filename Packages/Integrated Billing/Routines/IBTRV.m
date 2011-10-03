IBTRV ;ALB/AAS - CLAIMS TRACKING REVIEWS (UR) ; 27-JUN-1993
 ;;2.0;INTEGRATED BILLING;**40,121,124,250,277**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
EN ; -- main entry point for IBT REVIEW EDITOR from menu's
 ;
 I '$D(DT) D DT^DICRW
 K XQORS,VALMEVL,IBTRV,IBTRN,DFN,IBTRC,IBTRD,IBFASTXT,VALMQUIT
 G:$D(VALMQUIT) ENQ
 D PAT^IBCNSM I $D(VALMQUIT) G ENQ
 D TRAC I $D(VALMQUIT) G ENQ
 I '$G(IBTRPRF) S IBTRPRF="12"
 D EN^VALM("IBT REVIEW EDITOR")
ENQ K XQORS,VALMEVL,IBTRV,IBTRN,DFN,IBTRC,IBTRD,IBFASTXT,VALMQUIT,IBI,IBICD,IBTRND,VA,VAERR,VA200,VAINDT,X,Y,IBTRPRF,IBCNT,VALMBCK,OFFSET,I1,I3,IBNEW,IBDENT,IBOE,Z1,T,SDCNT
 K IBAMT,IBAPR,IBADG,IBDA,IBDGCR,IBDGCRU1,IBDV,IBETYP,IBETYPD,IBI,IBICD,IBLCNT,IBSEL,IBT,IBTEXT,IBTNOD,IBTSAV,VAUTD
 K IBAPEAL,IBCDFN,IBCNT,IBDEN,IBDENIAL,IBDENIAL,IBPARNT,IBPEN,IBPENAL,IBTCOD,IBTRDD,IBTRSV,IBTYPE,VAINDT,VA
 D KVAR^VADPT
 Q
 ;
HDR ; -- header code
 D PID^VADPT
 S VALMHDR(1)=" Hospital Review Entries for: "_$$PT^IBTUTL1(DFN)_"   ROI: "_$$EXPAND^IBTRE(356,.31,$P(^IBT(356,IBTRN,0),"^",31))
 S VALMHDR(2)="                         for: "_$$EXPAND^IBTRE(356,.18,$P(IBTRND,"^",18))_" on "_$$DAT1^IBOUTL($P(IBTRND,"^",6),"2P")
 Q
 ;
INIT ; -- init variables and list array
 S U="^",VALMCNT=0,VALMBG=1
 K ^TMP("IBTRV",$J),^TMP("IBTRVDX",$J),I,X,XQORNOD,DA,DR,DIE,DNM,DQ
 S IBTRND=$G(^IBT(356,+IBTRN,0)) D BLD Q
 ;
BLD ; -- Build list of Reviews
 K ^TMP("IBTRV",$J),^TMP("IBTRVDX",$J)
 N IBI,J,IBTRV,IBTRVD,IBUR
 S IBUR=$$IBUR(IBTRN)
 I IBUR'="" S VALMSG=IBUR
 S (IBTRV,IBCNT,VALMCNT)=0,IBI=""
 F  S IBI=$O(^IBT(356.1,"ATIDT",+IBTRN,IBI)) Q:'IBI  S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,"ATIDT",IBTRN,IBI,IBTRV)) Q:'IBTRV  D
 .W "."
 .S IBTRVD=$G(^IBT(356.1,+IBTRV,0))
 .Q:'+$P(IBTRVD,"^",21)  ;quit if inactive
 .N VAIN,VAINDT S VAINDT=$$VNDT(IBTRV) D INP^VADPT
 .I VAIN(4)="" S VAINDT=$P(IBTRND,"^",6) D INP^VADPT
 .S IBCNT=IBCNT+1
 .S X=""
 .S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 .S X=$$SETFLD^VALM1($$DAT1^IBOUTL(+IBTRVD,2),X,"RV DATE")
 .;S X=$$SETFLD^VALM1($P($G(^IBE(356.11,+$P(IBTRVD,"^",22),0)),"^"),X,"TYPE")
 .S X=$$SETFLD^VALM1($P($G(^IBE(356.11,+$P(IBTRVD,"^",22),0)),"^",3),X,"TYPE")
 .S X=$$SETFLD^VALM1($E($$EXPAND^IBTRE(356.1,.21,$P(IBTRVD,"^",21)),1,8),X,"STATUS")
 .S X=$$SETFLD^VALM1($P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^"),X,"SPEC")
 .S X=$$SETFLD^VALM1($J($P(IBTRVD,"^",3),2),X,"DAY")
 .S X=$$SETFLD^VALM1($$DAT1^IBOUTL($P(IBTRVD,"^",20),2),X,"NEXT")
 .S X=$$SETFLD^VALM1($P(VAIN(4),"^",2),X,"WARD")
 .S X=$$SETFLD^VALM1(VAIN(5),X,"BED")
 .S X=$$SETFLD^VALM1(IBUR,X,"RV REASON")
 .D SET(X)
 Q
 ;
SET(X) ; -- set arrays
 S VALMCNT=VALMCNT+1
 S ^TMP("IBTRV",$J,VALMCNT,0)=X
 S ^TMP("IBTRV",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBTRVDX",$J,IBCNT)=VALMCNT_"^"_IBTRV
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBTRV",$J),^TMP("IBTRVDX",$J)
 K IBTRV D CLEAN^VALM10 Q
 ;
TRAC ; -- Select tracking entry
 N X,Y,DIC,IBDFLT
 I '$D(DFN) S VALMQUIT="" G TRACQ
 ;S DIC("A")="Select VISIT: ",D="ADFN"_DFN
 ;S DIC("S")="I $P(^(0),U,20)"
 ;; Patch 40 custom look.
 ;S DIC("W")="S IBX=^(0) D PRINT^IBTRE20"
 ;S DIC="^IBT(356,",DIC(0)="EQS",X="???" D IX^DIC
 ;
 S IBDFLT=$$DEFV(DFN)
 D LIST(DFN,IBDFLT)
 ;
 S DIC("A")="Select VISIT: "
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,20)"
 S DIC="^IBT(356,",DIC(0)="AEQNM"
 I IBDFLT S DIC("B")=IBDFLT
 ; -- return IBY = Y as returned by dic
 D ^DIC S IBY=Y I +Y<1 S VALMQUIT="" G TRACQ
 S IBTRN=+Y
TRACQ Q
 ;
DEFV(DFN) ; -- compute default visit for patient
 N X,IBA,IBJ,IBX,IBY S X=""
 I '+$G(DFN) G DEFVQ
 I '$O(^IBT(356,"C",DFN,0)) G DEFVQ
 ; -- default = current inpt
 S IBA=+$G(^DPT(DFN,.105)),X="" I IBA S X=$P($G(^IBT(356,+$O(^IBT(356,"AD",+IBA,0)),0)),"^") I X G DEFVQ
 ;
 S IBX=0 F  S IBX=$O(^IBT(356,"ADFN"_DFN,IBX)) Q:'IBX  S IBY=$O(^IBT(356,"ADFN"_DFN,IBX,0)) I $P($G(^IBT(356,+IBY,0)),"^",20) D
 .I $P(^IBT(356,+IBY,0),"^",32),'$P(^(0),"^",5) S X=IBX
 .S IBJ=IBX
 I X G DEFVQ
 ;
 S IBX=0 F  S IBX=$O(^IBT(356,"ADM",DFN,IBX)) Q:'IBX  S IBY=$O(^IBT(356,"ADM",DFN,IBX,0)) D
 .I $P($G(^IBT(356,+IBY,0)),"^",20) S X=$P(^(0),"^")
 G:$L(X) DEFVQ
 S X=$G(IBJ)
 ;
DEFVQ Q X
VNDT(X) ; -- compute vaindt for call to inp^vadtp
 ; -- Input  x = internal entry of review
 N Y S Y=""
 S Y=+$G(^IBT(356.1,+$G(X),0)) S:$$TRTP(+$G(X))'=40 Y=Y+.24
 Q Y
 ;
TRTP(X) ; -- Compute Review type code
 ;    Input x = internal entry of review
 ;    output  = code for review from 356.11
 Q $P($G(^IBE(356.11,+$P($G(^IBT(356.1,+$G(X),0)),"^",22),0)),"^",2)
 ;
IBUR(IBTRN) ; -- reason for review
 N IBUR,IBTRND
 S IBUR="",IBTRND=$G(^IBT(356,+$G(IBTRN),0))
 S:$P(IBTRND,"^",25) IBUR="Random Sample" S:$P(IBTRND,"^",26) IBUR=IBUR_$S(IBUR="":"",1:"/")_$$EXPAND^IBTRE(356,.26,$P(IBTRND,"^",26))
 S:$P(IBTRND,"^",27) IBUR=IBUR_$S(IBUR="":"",1:"/")_"Local Addition"
 Q IBUR
 ;
LIST(DFN,DFLT) ; list 1 screen of most recent CT entries
 Q:'$G(DFN)  N IBX,IBY,IBA,IBCNT S IBCNT=0
 ;
 W !!,"Choose from:"
 S IBY="" F  S IBY=$O(^IBT(356,"C",DFN,IBY),-1) Q:'IBY  D  Q:IBCNT>17
 . I +$P($G(^IBT(356,+IBY,0)),U,20) S IBCNT=IBCNT+1,IBA(IBY)=""
 I '$O(IBA("")) W !,"   There are no Claims Tracking entries for this patient."
 I +IBY,+$O(^IBT(356,"C",DFN,IBY),-1) W !,"   ..."
 ;
 S IBY="" F  S IBY=$O(IBA(IBY)) Q:'IBY  S IBX=$G(^IBT(356,IBY,0)) W !,?3,$P(IBX,U,1) D PRINT^IBTRE20
 ;
 I $G(DFLT)'="" S IBY=+$O(^IBT(356,"B",DFLT,0)) I +IBY S IBX=$G(^IBT(356,+IBY,0)) W !!,?3,$P(IBX,U,1) D PRINT^IBTRE20
 W !
 Q
