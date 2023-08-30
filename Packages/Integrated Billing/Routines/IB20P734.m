IB20P734 ;SAB/EDE - IB*2.0*734 POST INSTALL;07/25/22 12:35pm
 ;;2.0;Integrated Billing;**734**;Mar 20, 1995;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*734
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*734")
 D NEWCREAS
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*734")
 Q
 ;
NEWCREAS ; New Cancellation Reasons
 N LOOP,LIEN,IBDATA,IBCNNM
 N X,Y,DIE,DA,DR,DTOUT,DATA,IBDATAB,DIK
 ; 
 N CANIEN,UPDIEN,SVCIEN,CHGIEN
 ;
 ; Grab all of the entries to update
 D MES^XPDUTL("     -> Adding new Cancellation Reason to the IB CHARGE REMOVE REASON file (350.3).")
 S Y=-1
 F LOOP=1:1 S IBDATA=$T(REASDAT+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . S DR=""
 . ;Extract the new ACTION TYPE to be added.
 . ;Store in array for adding to the file (#350.1).
 . Q:IBDATA=""    ;go to next entry if Category is not to be updated.
 . ;
 . S IBCNNM=$P(IBDATA,";",3)
 . S LIEN=$O(^IBE(350.3,"B",IBCNNM,""))
 . ; File the update along with inactivate the ACTION TYPE
 . S DLAYGO=350.3,DIC="^IBE(350.3,",DIC(0)="L",X=IBCNNM
 . I '+LIEN D FILE^DICN S LIEN=+Y K DIC,DINUM,DLAYGO
 . S DR=".02////"_$P(IBDATA,";",4)   ; ABBREVIATION
 . S DR=DR_";.03////"_$P(IBDATA,";",5)  ; LIMIT
 . S DR=DR_";.04///"_$P(IBDATA,";",6)  ; Can Cancel UC
 . ;Not needed for this round of Cancellation Reason Creations.
 . ;S DR=DR_";.05////"_$P(IBDATA,";",7)  ; UC Visit Processing
 . ;
 . S DIE="^IBE(350.3,",DA=LIEN
 . D ^DIE
 . K DR
 Q
 ;
REASDAT ; Fee Service to inactivate
 ;;REGISTRY EXAM;REXAM;3;N
 ;;END
 Q
  ;
