IBCEP7 ;ALB/TMP - Functions for fac level PROVIDER ID MAINT ;11-07-00
 ;;2.0;INTEGRATED BILLING;**137,232,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
HDR ; -- hdr code
 I '$D(^TMP("IBCE_PRVFAC_MAINT",$J)) D INIT
 N IBINS,PCF,PCDISP,IBPARAM,IBEFTFL
 K VALMHDR
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBEFTFL=$P(IBPARAM,U)  ; Electronic Form type flag
 S IBINS=+$P(IBPARAM,U,2)  ; Insurance co
 S PCF=$P($G(^DIC(36,+IBINS,3)),U,13),PCDISP=$S(PCF="P":"(Parent)",1:"")
 S VALMHDR(1)="Insurance Co: "_$P($G(^DIC(36,+IBINS,0)),U)_PCDISP
 S VALMHDR(1)=VALMHDR(1)_$S(IBEFTFL="E":"   Billing Provider Secondary IDs",IBEFTFL="A":"   Additional Billing Provider Sec. IDs",IBEFTFL="LF":"   VA-Lab/Facility Secondary IDs",1:"")
 I IBEFTFL="LF" S VALMHDR(2)="VA-Lab/Facility Primary ID: Federal Tax ID"
 Q
 ;
INIT ; Initialize
 N IBCT,IBD,Z,Z0,Z00,Z1,IBS,IBX,IBDIV,IBEFTFL,IBINS,IBPARAM,IBLCT,IBCU
 K ^TMP("IBCE_PRVFAC_MAINT",$J)
 S (IBLCT,IBCT)=0
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBEFTFL=$P(IBPARAM,U)  ; Electronic Form type flag
 S IBINS=+$P(IBPARAM,U,2)  ; Insurance co
 ;
 I IBEFTFL="A" D
 . K VALM("PROTOCOL")
 . S Y=$$FIND1^DIC(101,,,"IBCE PRVFAC ADDIDS MAINT")
 . I Y S VALM("PROTOCOL")=+Y_";ORD(101,"
 ;
 I IBEFTFL="LF" D
 . S VALM("TITLE")="VA-Lab/Facility IDs"
 . K VALM("PROTOCOL")
 . S Y=$$FIND1^DIC(101,,,"IBCE PRVFAC VALF MAINT")
 . I Y S VALM("PROTOCOL")=+Y_";ORD(101,"
 ;
 ; Compile the appropriate list of IDs
 S Z=0 F  S Z=$O(^IBA(355.92,"B",IBINS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:'$P(Z0,U,6)!($P(Z0,U,7)="")  ; Quit if no provider id or id type
 . Q:'($P(Z0,U,8)=IBEFTFL)
 . ;Q:$S($P(IBPARAM,U,3)=1:'$P($G(^IBE(355.97,+$P(Z0,U,6),1)),U,9),1:$P($G(^IBE(355.97,+$P(Z0,U,6),1)),U,9))
 . S Z1=$G(^IBE(355.97,+$P(Z0,U,6),0))
 . S IBS(+$P(Z0,U,5),+$P(Z0,U,3),+$P(Z1,U,2)_";"_Z,$P(Z1,U))=+$P(Z0,U,6)_U_$P(Z0,U,7)_U_Z
 ;
 S IBD="" F  S IBD=$O(IBS(IBD)) Q:IBD=""  D
 . D:IBCT SET1(.IBLCT," ",IBCT+1)
 . D SET1(.IBLCT,"Division: "_$$DIV(IBD),IBCT+1)
 . S IBCU="" F  S IBCU=$O(IBS(IBD,IBCU)) Q:IBCU=""  D
 .. I IBCU D SET1(.IBLCT,"  Care Unit: "_$$EXTERNAL^DILFD(355.92,.03,"",IBCU),IBCT+1)
 .. S Z="" F  S Z=$O(IBS(IBD,IBCU,Z),-1) Q:Z=""  D
 ... S Z0="" F  S Z0=$O(IBS(IBD,IBCU,Z,Z0)) Q:Z0=""  S IBX=IBS(IBD,IBCU,Z,Z0) D
 .... S IBCT=IBCT+1
 .... I $P(Z,";",2) D  Q
 ..... S Z00=$G(^IBA(355.92,+$P(Z,";",2),0))
 ..... S Z1=$E(IBCT_$J("",3),1,3)_"  "_$E(Z0_$J("",25),1,25)_"   "_$E($S($P(IBX,U,2)'="":$P(IBX,U,2),1:$$IDNUM^IBCEP7A(+IBX))_$J("",15),1,15)_"  "_$P("BOTH^UB04^1500^RX",U,$P(Z00,U,4)+1)
 ..... D SET1(.IBLCT,Z1,IBCT)
 ..... S ^TMP("IBCE_PRVFAC_MAINT",$J,"ZIDX",IBCT)=+$P(Z,";",2)
 ;
 I 'IBLCT D
 . D SET1(1," ")
 . N TEXT
 . I IBEFTFL="E" S TEXT="No Billing Provider Secondary IDs found"
 . I IBEFTFL="A" S TEXT="No Billing Provider Additional IDs found"
 . I IBEFTFL="LF" S TEXT="No VA Lab/Facility IDs found"
 . D SET1(2,TEXT)
 . S IBLCT=2
 S VALMBG=1,VALMCNT=IBLCT
 Q
 ;
SET1(IBLCT,TEXT,IBCT) ;
 S IBLCT=IBLCT+1 D SET^VALM10(IBLCT,TEXT,$G(IBCT))
 Q
 ;
DIV(IBD) ; Returns 'ALL/DEFAULT' or div NAME whose ien=IBD
 N MAIN
 I IBD Q $$EXTERNAL^DILFD(355.92,.05,"",IBD)
 S MAIN=$$MAIN^IBCEP2B()
 S MAIN=$$EXTERNAL^DILFD(355.92,.05,"",MAIN)
 S MAIN=MAIN_"/Default for All Divisions"
 Q MAIN
 ;
EDIT1 ;
 N IBFUNC,IBINS,IBDA,Z,DIR,X,Y,DTOUT,DUOUT,DP,IBPARAM,IBEFTFL
 D FULL^VALM1
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBEFTFL=$P(IBPARAM,U)  ; Electronic Form type flag
 S IBINS=+$P(IBPARAM,U,2)  ; Insurance co
 S IBFUNC="E"
 D SEL
 I $G(IBDA) S Z=$$EDITFAC(IBDA,IBFUNC,IBEFTFL) I Z D INIT
 ;
EDIT1Q S VALMBCK="R"
 Q
EXPND ;
 Q
HELP ;
 Q
EXIT ;
 N IBPARAM,IBEFTFL
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBEFTFL=$P(IBPARAM,U)  ; Electronic Form type flag
 I IBEFTFL="A" D COPYPROV^IBCEP5A(0)
 ;
 S (IBLCT,IBCT)=0
 K ^TMP("IBCE_PRVFAC_MAINT",$J),^TMP("IBCE_PRVFAC_MAINT_INS",$J)
 D CLEAN^VALM10
 Q
SEL ;
 N Z
 K IBDA
 D FULL^VALM1,EN^VALM2($G(XQORNOD(0)),"OS")
 S Z=+$O(VALMY(0)) Q:'Z
 ; fac/ins co default
 S IBDA=$G(^TMP("IBCE_PRVFAC_MAINT",$J,"ZIDX",Z))
 Q
 ;
EDITFAC(IBDA,IBFUNC,IBEFTFL) ; edits ins co facility id (355.92), entry IBDA
 N IBRBLD,Z,Z0,DIK,DIE,DP,DA,DR,DIR,X,Y,IBDA0,IBDIV,IBITYP,IBFORM,IBCAREUN,NEXTONE
 S IBRBLD=0 S:$G(IBDA) IBDA0=$G(^IBA(355.92,+IBDA,0))
 ; "E"diting 355.92 entry
 I IBFUNC="E" D
 . S Z0=$TR(IBDA0,U)
 . Q:'$$FACFLDS^IBCEP7C(IBDA,IBINS,.IBITYP,.IBFORM,.IBDIV,"E",.IBCAREUN,IBEFTFL)
 . S DIE="^IBA(355.92,",DA=IBDA
 . S DR=".03////"_$S($G(IBCAREUN)]""&($G(IBCAREUN)'="*N/A*"):IBCAREUN,1:"")_";.04////"_IBFORM_$S(IBDIV:";.05////"_IBDIV,1:"")_";.06////"_IBITYP_";"
 . S DR=DR_".07"_$S(IBEFTFL="E"!(IBEFTFL="A"):"Billing Provider Secondary ID",1:"VA Lab or Facility Secondary ID")
 . I IBEFTFL="A" D
 .. S NEXTONE=$$NEXTONE()
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE)=IBDA_U_"MOD"_U_355.92
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE,"OLD0")=^IBA(355.92,IBDA,0)
 . D ^DIE
 . I IBEFTFL="A" S ^TMP("IB_EDITED_IDS",$J,NEXTONE,0)=^IBA(355.92,IBDA,0)
 . I $TR($G(^IBA(355.92,IBDA,0)),U)'=Z0 S IBRBLD=1
 ;
 ; "D"eleting 355.92 entry
 I IBFUNC="D" D
 . W !!," Insurance Co: ",$P($G(^DIC(36,+IBDA0,0)),U)
 . W !,"     Division: ",$$DIV($P(IBDA0,U,5))
 . W:$P(IBDA0,U,3)]"" !,"    Care Unit: ",$$EXTERNAL^DILFD(355.92,.03,"",$P(IBDA0,U,3))
 . W !," ID Qualifier: ",$$EXTERNAL^DILFD(355.92,.06,"",$P(IBDA0,U,6))
 . W !,"    Form Type: ",$$EXTERNAL^DILFD(355.92,.04,"",$P(IBDA0,U,4))
 . W !,"           ID: ",$P(IBDA0,U,7),!
 . S DIR(0)="YA",DIR("A")="ARE YOU SURE YOU WANT TO DELETE THIS ID RECORD?: ",DIR("B")="NO" D ^DIR K DIR
 . S DIR("A")="NOTHING DELETED - PRESS RETURN TO CONTINUE: "
 . I Y=1 D
 .. S DIK="^IBA(355.92,",DA=IBDA
 .. D ^DIK
 .. I IBEFTFL="A" D
 ... N NEXTONE
 ... S NEXTONE=$$NEXTONE()
 ... S ^TMP("IB_EDITED_IDS",$J,NEXTONE)=IBDA_U_"DEL"_U_355.92
 ... S ^TMP("IB_EDITED_IDS",$J,NEXTONE,0)=IBDA0
 .. S DIR("A")="ID DELETED - PRESS RETURN TO CONTINUE: ",IBRBLD=1
 .. S DIR(0)="EA" W ! D ^DIR K DIR
 ;
 Q IBRBLD
 ;
FACID(Y) ;
 N Z,Z1,Z2
 S Z=U_$P($G(^IBE(355.97,+Y,0)),U,3)_U,Z1=$$SUB2^IBCEF73(1),Z2=$$SUB2^IBCEF73(2)
 I Z1[Z!(Z2[Z) Q 1
 Q 0
 ;
ADD1 ;
 N IBFUNC,IBINS,IBDA,Z,DIR,X,Y,DTOUT,DUOUT,DP,IBPARAM,IBEFTFL,IBINS
 D FULL^VALM1
 ;
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBEFTFL=$P(IBPARAM,U)  ; Electronic Form type flag
 S IBINS=+$P(IBPARAM,U,2)  ; Insurance co        ;
 ;
 S Z=$$ADDFAC^IBCEP7A(IBINS,IBEFTFL) I Z D INIT
 ;
ADD1Q S VALMBCK="R"
 Q
 ;
DEL1 ;
 N IBFUNC,IBINS,IBDA,Z,DIR,X,Y,DTOUT,DUOUT,DP,IBPARAM,IBEFTDL,IBINS
 D FULL^VALM1
 ;       
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBEFTFL=$P(IBPARAM,U)  ; Electronic Form type flag
 S IBINS=+$P(IBPARAM,U,2)  ; Insurance co
 ;
 S IBFUNC="D"
 D SEL
 I $G(IBDA) S Z=$$EDITFAC(IBDA,IBFUNC,IBEFTFL) I Z D INIT
 ;
DEL1Q S VALMBCK="R"
 Q
 ;
 ; Get the next number so that the edits can be replicated in order for other providers/insurance companies
NEXTONE() ;
 Q $O(^TMP("IB_EDITED_IDS",$J,""),-1)+1
