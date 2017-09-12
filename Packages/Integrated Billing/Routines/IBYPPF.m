IBYPPF ;ALB/ARH - IB*2*131 POST INIT: CPT 2000 REPLACEMENTS FOR RC V1 ; 05/25/00
 ;;2.0;INTEGRATED BILLING;**131**;21-MAR-94
 ; 
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*131 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D DEL2000^IBYPPF1 ; delete any existing RC charges for the new codes (site defined)
 D ADD2000^IBYPPF1 ; add charges for new CPT codes, replacements for inactivated CPT codes
 ;
 D PDDEL^IBYPPT1 ; delete all Provider Discount Sets and Links (363.34) for RC PROVIDER DISCOUNTS Special Group
 D PDADD^IBYPPT1 ; add new Provider Discount Sets and Links (363.34) for RC PROVIDER DISCOUNTS Special Group
 ;
 D CPTINA ; inactivate charges for inactive CPT codes
 ;
 S IBA(1)="",IBA(2)="    IB*2*131 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
CPTINA ; inactivate charges for Inactive CPTs
 N IBA,IBCNT S IBCNT=0
 S IBA(1)="",IBA(2)="    >> Inactivating Charges for Inactive CPT codes, Please Wait..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBCNT=$$INACTCPT^IBCREC(0) ; inactivate charges for inactive CPT codes
 ;
 S IBA(1)="       Done.  "_IBCNT_" Charges Inactivated." D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
 ;
MSG(X) ; 
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
