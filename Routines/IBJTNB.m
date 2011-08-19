IBJTNB ;ALB/ARH - TPI INSURANCE POLICY/AB SCREENS/ACTIONS ; 2/14/95
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
HDRP ; -- IBJT NS VIEW EXP POL LIST TEMPLATE:  policy header code
 S VALMHDR(1)="Expanded Policy Information" N IBI,IBX
 I $D(IBPPOL) D HDR^IBCNSP,PST(1)
 Q
INITP ; -- IBJT NS VIEW EXP POL LIST TEMPLATE:  policy init code
 K ^TMP("IBCNSVP",$J),^TMP("IBCNSVPD",$J)
 I '$G(IBIFN) D PRTCL^IBJU1("IBJT SHORT MENU")
 I IBJPOL>0 S IBPPOL="^2^"_DFN_"^"_+IBJPOL_"^"_$G(^DPT(DFN,.312,+IBJPOL,0)) D INIT^IBCNSP K VALMHDR Q
 S VALMCNT=0 D BLD("Insurance data incomplete, cannot find policy.")
 Q
EXITP D EXIT^IBCNSP K ^TMP("IBCNSVP",$J),^TMP("IBCNSVPD",$J) Q
HELPP D HELP^IBCNSP Q
 ;
VP(REDISP) ; -- IBJT NS VIEW EXP POL SCREEN ACTION: patient policy info screen
 ;     user can select policy if more than one for bill, REDISP set if screen to be rebuilt for different policy
 ;
 I '$G(REDISP) N IBX,IBVIEW,IBCHANGE,IBCNS,IBCPOL,IBPPOL,IBJPOL,IBCDFN,IBI,IBLCNT,IBPR,IBPRD
 I '$G(IBIFN)!'$G(DFN) G VPQ
 D FULL^VALM1
 S IBX=$$PST^IBJTU31(IBIFN) I 'IBX S VALMBCK="R" G VPQ
 S IBJPOL=IBX
 I '$G(REDISP) D EN^VALM("IBJT NS VIEW EXP POL") G VPQ
 D INITP S VALMBCK="R"
VPQ Q
 ;
 ;
HDRA ; -- IBJT NS VIEW AN BEN LIST TEMPLATE: annual benefits header code
 S VALMHDR(1)="Annual Benefits Information",IBCGN=$G(IBCGN),IBYE=$G(IBYE)
 I +$G(IBCPOL)>0 D HDR^IBCNSA("Annual Benefits") D PST(1)
 Q
INITA ; -- IBJT NS VIEW AN BEN LIST TEMPLATE: annual benefits init code
 ;    allow select of other benefit years, after first display of policy
 N IBJMSG K IBYR S VALMCNT=0 I +IBJPOL<0 S IBJMSG="Insurance data incomplete, cannot find policy." G IA1
 S IBCPOL=+$P(IBJPOL,U,20) I 'IBCPOL S IBJMSG="No Policy found." G IA1
 I '$O(^IBA(355.4,"APY",+IBCPOL,"")) S IBJMSG="Policy has No Annual Benefits Records." G IA1
 I +$G(IBIFN),'$D(IBJAB(IBCPOL)),$G(IBJMSG)="" D  S IBJAB(IBCPOL)=""
 . S IBEVDT=$E(+$G(^DGCR(399,+IBIFN,"U")),1,7),IBDT=-IBEVDT-.01
 . S IBDT=$O(^IBA(355.4,"APY",IBCPOL,IBDT))
 . I 'IBDT!($$FMDIFF^XLFDT(IBEVDT,-IBDT)>365) S IBJMSG="No Annual Benefits cover begin date of bill ("_$$DATE^IBJU1(IBEVDT)_")." Q
 . S IBYR=-IBDT,IBCAB=$O(^IBA(355.4,"APY",IBCPOL,IBDT,""))
 . I 'IBCAB S IBJMSG="No Annual Benefits record found."
IA1 I '$G(IBIFN) D PRTCL^IBJU1("IBJT SHORT MENU")
 I $G(IBJMSG)'="" K ^TMP("IBCNSA",$J) D BLD(IBJMSG) K VALMHDR Q
 D INIT^IBCNSA I '$D(VALMQUIT) K VALMHDR
 Q
EXITA D EXIT^IBCNSA K IBJAB,^TMP("IBCNSA",$J) Q
HELPA D HELP^IBCNSA Q
 ;
AB(REDISP) ; -- IBJT NS VIEW AN BEN SCREEN ACTION: patient policy annual benefits for year which contains the bill's
 ;     Statement From Date, once the annual benefits of the policy that covers the bill's year has been
 ;     displayed, the user will be allowed to pick other AB years for the policy
 ;     user can select policy if more than one on bill, REDISP set if screen to be rebuilt for different policy
 ;
 I '$G(REDISP) N IBEVDT,IBDT,IBYR,IBCAB,IBX,IBVIEW,IBCHANGE,IBCNS,IBCPOL,IBPPOL,IBCGN,IBYE,IBJPOL,IBI,IBDUZ,IBDA,IBCNT,OFFSET,START
 I '$G(IBIFN)!'$G(DFN) G ABQ
 D FULL^VALM1
 S IBX=$$PST^IBJTU31(IBIFN) I 'IBX S VALMBCK="R" G ABQ
 S IBJPOL=IBX
 I '$G(REDISP) D EN^VALM("IBJT NS VIEW AN BEN") G ABQ
 D INITA S VALMBCK="R"
ABQ Q
 ;
 ;
BLD(MSG) D KILL^VALM10(),SET^IBCNSP(1,1,""),SET^IBCNSP(2,1,MSG) Q
PST(X) S IBI=$P(IBJPOL,U,2),IBX=$S(IBI=1:"Primary",IBI=2:"Secondary",IBI=3:"Tertiary",1:""),VALMHDR(X)=$E(VALMHDR(X),1,68)_$J("",(79-$L(VALMHDR(X))-$L(IBX)))_IBX Q
