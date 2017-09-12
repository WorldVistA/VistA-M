IB20P160 ;ALB/ARH - IB*2*160 POST INIT: ORIGINAL RX IN CT ; 07/11/01
 ;;2.0;INTEGRATED BILLING;**160**;21-MAR-94
 ; 
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*160 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D RXABBR ; update Prescription Refill Abbreviation (356.6,.02)
 ;
 S IBA(1)="",IBA(2)="    IB*2*160 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
RXABBR ; change the Prescription Refill abbreviation from 'RxRefill' to 'RxFill' (356.6,.02)
 N IBA,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 ;
 S IBFN=$O(^IBE(356.6,"B","PRESCRIPTION REFILL",0))
 I $P($G(^IBE(356.6,+IBFN,0)),U,3)'=3 S IBFN=""
 ;
 I +IBFN S DR=".02///RxFill",DIE="^IBE(356.6,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
 S IBA(1)="    >> Prescription Abreviation "_$S('IBFN:"NOT ",1:"")_"updated (#356.6,.02)" D MES^XPDUTL(.IBA) K IBA
 Q
