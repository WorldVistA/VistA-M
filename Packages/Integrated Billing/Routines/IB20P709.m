IB20P709 ;SAB/EDE - IB*2.0*709 POST INSTALL;03/10/20 2:10pm
 ;;2.0;Integrated Billing;**709**;Mar 20, 1995;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POSTINIT ;Post Install for IB*2.0*709
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*709")
 D SETPARAM
 D NEWCREAS
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*709")
 Q
 ;
SETPARAM ; set default value for IB site parameter 350.9/71.02
 N DA,DIE,DR,X,Y
 D MES^XPDUTL("Setting default start date for COMPACT ACT Benefit in IB SITE PARAMETER file...")
 S DA=1,DIE=350.9,DR="71.02///^S X=3210901" D ^DIE
 D MES^XPDUTL("Done.")
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
 . S DR=DR_";.05////"_$P(IBDATA,";",7)  ; UC Visit Processing
 . ;
 . S DIE="^IBE(350.3,",DA=LIEN
 . D ^DIE
 . K DR
 Q
 ;
REASDAT ; Fee Service to inactivate
 ;;COMPACT;CMPCT;3;Y;1
 ;;END
 Q
 ;
