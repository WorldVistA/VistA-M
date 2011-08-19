IBYPSK ;ALB/ARH - IB*2.0*370 POST INIT: RC V3.0 DELETE PROVIDER DISCOUNTS ; 01-FEB-2007
 ;;2.0;INTEGRATED BILLING;**370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 Q
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    Reasonable Charges v3.0 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D PDDEL ; delete all RC Provider Discounts, except Zero Charge
 ;
 S IBA(1)="",IBA(2)="    Reasonable Charges v3.0 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
 ;
PDDEL ; delete all RC Provider Discounts (except Zero Charge)
 N IBA,IBC,IBSG,IBCNT,IBPD0,IBPDFN,DA,DIK,DIC,DIE,X,Y S IBCNT=0
 S IBC="Delete Reasonable Charges Provider Discounts:" D MSG(IBC)
 ;
 S IBSG=$O(^IBE(363.32,"B","RC PROVIDER DISCOUNTS",0))
 I 'IBSG S IBC="** Error, Discounts Not Deleted: Special Group Not Found, Contact Support" D MSG(IBC) G PDDELQ
 ;
 S IBPDFN=0 F  S IBPDFN=$O(^IBE(363.34,IBPDFN)) Q:'IBPDFN  D
 . S IBPD0=$G(^IBE(363.34,IBPDFN,0))
 . ;
 . I +$P(IBPD0,U,2)'=IBSG Q
 . I $P(IBPD0,U,1)="ZERO CHARGE" Q
 . ;
 . S DA=IBPDFN,DIK="^IBE(363.34," D ^DIK K DIK,DA S IBCNT=IBCNT+1
 . ;
 . S IBC=">> Discount Deleted: "_$P(IBPD0,U,1) D MSG(IBC)
 ;
PDDELQ S IBC=IBCNT_" Provider Discount Groups Deleted (#363.34)" D MSG(IBC)
 D MES^XPDUTL(.IBA) K IBA
 ;
 S IBC=0,IBPD0="" F  S IBPD0=$O(^IBE(363.34,"B",IBPD0)) Q:IBPD0=""  I IBPD0'="ZERO CHARGE" S IBC=1
 I +IBC S IBA(1)="",IBA(2)="    ** Provider Discount Groups still exist, Contact Support." D MES^XPDUTL(.IBA)
 Q
 ;
 ;
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
MSG(X) ;
 N IBX S IBX=+$O(IBA(999999),-1) S IBX=IBX+1
 S IBA(IBX)="    "_$G(X)
 Q
