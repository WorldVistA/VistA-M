IBCEXTR2 ;ALB/JEH - IB EXTRACT STATUS MANAGEMENT  ;01/14/00
 ;;2.0;INTEGRATED BILLING;**137,155**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This routine contains the action items to cancel,clone and authorize
 ;claims held in a ready for extract statue due to EDI/MRA parameters
 ;being turned off.
 ;
CANCEL ;Cancel bill
 N IBIFN,IBDA,IB364,IBCEAUTO
 S IBCEAUTO=1
 ;
 ; Check for security key
 I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CANCELQ
 . D FULL^VALM1
 . W !!?5,"You don't hold the proper security key to access this function."
 . W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(0)),IBIFN=+$G(IBDA(+IBDA)),IB364=$P($G(IBDA(+IBDA)),U,2)
 I 'IBIFN G CANCELQ
 D CANCEL^IBCEM3(.IBDA,IBIFN,IB364)
 D PAUSE^VALM1
CANCELQ S VALMBCK="R"
 I $G(IBDA)'="" D BLD^IBCEXTR1
 Q
 ;
CPYCLN ;Cancel/clone/authorize bill
 N IBIFN,IBDA,IB364,IBCEAUTO,IBNIEN,IBYY
 S IBCEAUTO=1
 ;
 ; Check for security key
 I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CPYCLNQ
 . D FULL^VALM1
 . W !!?5,"You don't hold the proper security key to access this function."
 . W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 ;
 D SEL(.IBDA,1)
 S IBDA=$O(IBDA(0)),IBIFN=+$G(IBDA(+IBDA)),IB364=$P($G(IBDA(+IBDA)),U,2)
 I 'IBIFN G CPYCLNQ
 D COPYCLON^IBCECOB2(IBIFN,IB364,.IBDA) ;Cancel/copy bill
 I '$G(IBNIEN) D PAUSE^VALM1 G CPYCLNQ
 S IBIFN=IBNIEN
 S DIE="^DGCR(399,",DA=IBIFN,DR="[IB STATUS]",IBYY="@902" D ^DIE K DIE,DA,DR,IBNIEN ;Authorize bill quietly
 W !,"Authorizing bill..."
 D ARONLY^IBCB1(IBIFN) ;Pass to AR as new bill
 D PAUSE^VALM1
 ;
CPYCLNQ ;
 S VALMBCK="R"
 K IBCEAUTO
 Q
 ;
SEL(IBDA,ONE) ;Select entry from List Manager
 ;D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBDA(IBDA)=$P($G(^TMP("IBCERP61",$J,IBDA)),U,2,3)
 Q
