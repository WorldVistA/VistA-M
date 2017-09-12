IBYPPH ;ALB/ARH - IB*2*169 POST INIT: REASONABLE CHARGES V1.3 ; 01/06/02
 ;;2.0;INTEGRATED BILLING;**169**;21-MAR-94
 ; 
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*169 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D RVD^IBYPPH2 ; delete existing Revenue Code - CPT Links (#363.33)
 D RVL^IBYPPH2 ; add new/updated Revenue Code - CPT Links (#363.33)
 ;
 D CHGINA^IBYPPH1("") ; inactivate all RC charges in #363.2
 ;
 D CSEMPTY ; delete Charge Sets with no charges assigned
 ;
 S IBA(1)="",IBA(2)="    IB*2*169 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
CSEMPTY ; delete Charges Sets with no Charges assigned
 N IBA,IBCNT S IBCNT=0
 S IBA(1)="",IBA(2)="    >> Removing Charges Sets that have no Charges Assigned..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBCNT=$$CSEMPTY^IBCRED() ; delete Charge Sets that have no charges
 ;
 S IBA(1)="       Done.  "_IBCNT_" Charges Sets Removed." D MES^XPDUTL(.IBA) K IBA
 Q
