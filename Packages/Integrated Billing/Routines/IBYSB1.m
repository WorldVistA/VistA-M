IBYSB1 ;ALB/ARH - IB*2.0*124 POST INIT: UPDATE FORM CODES ; 2/9/00
 ;;2.0;INTEGRATED BILLING;**124**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2.0*124 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D MUCODES^IBYSB2 ; form codes to MCCR Utility file (#399.1)
 D ADDPOS ;         add Place of Service Codes  (353.1)
 ;
 S IBA(1)="",IBA(2)="    IB*2.0*124 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
ADDPOS ; Add Place of Service Codes (353.1)
 N IBA,IBCNT,IBI,IBLN,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y S IBCNT=0
 ;
 F IBI=1:1 S IBLN=$P($T(POSF+IBI),";;",2) Q:IBLN=""  I $E(IBLN)'=" " D
 . ;
 . I $O(^IBE(353.1,"B",$P(IBLN,U,1),0)) Q
 . ;
 . K DD,DO S DLAYGO=353.1,DIC="^IBE(353.1,",DIC(0)="L",X=$P(IBLN,U,1) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02///"_$P(IBLN,U,2)_";.03///"_$P(IBLN,U,3)
 . S DIE="^IBE(353.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
POSQ S IBA(1)="      * "_$J(IBCNT,3)_"  HCFA 1500 Place of Service Codes added (353.1)"
 D MES^XPDUTL(.IBA)
 Q
 ;
POSF ;  Place of Service (353.1)
 ;; code ^ name ^ abbreviation
 ;;    
 ;;50^FEDERALLY QUALIFIED HEALTH CENTER^FED QUAL HLTH CTR
 ;;60^MASS IMMUNIZATION CENTER^MASS IMMUNIZATON CTR
 ;;
