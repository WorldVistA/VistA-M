IBYPSM ;ALB/ARH - IB*2.0*390 POST INIT: REASONABLE CHARGES V3.1 ; 25-JAN-2008
 ;;2.0;INTEGRATED BILLING;**390**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 Q
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    Reasonable Charges v3.1 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D CHGINA("") ; inactivate all RC charges in #363.2
 ;
 S IBA(1)="",IBA(2)="    Reasonable Charges v3.1 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
 ;
 ;
CHGINA(VERS) ; inactive charges from previous versions of Reasonable Charges
 ; VERS = version to begin inactivations with (1, 1.1, 1.2, ...)
 ; - Inactive date added is the first RC Version Inactive date after the effective date of the charge
 ; - if the charge already has an inactive date less than the Version Inactive Date then no change is made
 ;
 N IBA,IBI,IBX,IBSTART,IBENDATE,IBCS,IBCS0,IBBR0,IBXRF,IBITM,IBNEF,IBCI,IBCI0,IBCIEF,IBCIIA,IBNEWIA
 N DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y,IBCNT S IBCNT=0
 ;
 S IBA(1)="      >> Inactivating Existing Reasonable Charges, Please Wait..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBSTART="" I $G(VERS)'="" S IBSTART=$$VERSDT^IBCRHBRV(VERS)
 S IBENDATE=$$VERSEND^IBCRHBRV
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)) Q:IBCS0=""
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)) I $E(IBBR0,1,3)'="RC " Q
 . ;
 . S IBXRF="AIVDTS"_IBCS
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. S IBNEF="" F  S IBNEF=$O(^IBA(363.2,IBXRF,IBITM,IBNEF)) Q:IBNEF=""  Q:-IBNEF<IBSTART  D
 ... ;
 ... S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,IBNEF,IBCI)) Q:'IBCI  D
 .... S IBCI0=$G(^IBA(363.2,IBCI,0)) Q:IBCI0=""
 .... S IBCIEF=$P(IBCI0,U,3),IBCIIA=$P(IBCI0,U,4),IBNEWIA=""
 .... ;
 .... F IBI=2:1 S IBX=+$P(IBENDATE,";",IBI) S IBNEWIA=IBX Q:'IBX  Q:IBCIEF'>IBX
 .... ;
 .... I 'IBNEWIA Q
 .... I +IBCIIA,IBCIIA'>IBNEWIA Q
 .... ;
 .... S DR=".04////"_+IBNEWIA,DIE="^IBA(363.2,",DA=+IBCI D ^DIE K DIE,DIC,DA,DR,X,Y S IBCNT=IBCNT+1
 ;
 S IBA(1)="         Done.  "_IBCNT_" existing charges inactivated " D MES^XPDUTL(.IBA) K IBA
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
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
