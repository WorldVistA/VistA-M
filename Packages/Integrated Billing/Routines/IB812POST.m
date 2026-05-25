IB812POST ;AITC/PD - Post-install for IB*2.0*812 ;05/15/2025
 ;;2.0;INTEGRATED BILLING;**812**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Post-install to loop through the GROUP INSURANCE PLAN file (#355.3).
 ; If the DATE LAST MATCHED field (#1.07) exists and the PLAN ID field (#6.01)
 ; does not exist, enter a stock comment into the new field DELETE REASON (#3.01).
 Q
 ;
EN ;
 ;
 D MES^XPDUTL(" Starting pre-install of IB*2.0*812")
 ;
 ; Update delete reasons in GROUP INSURANCE PLAN file #355.3
 D GRPINSPLN
 ;
 D MES^XPDUTL(" Finished pre-install of IB*2.0*812")
 ;
 Q
 ;
GRPINSPLN ; Update Group Insurance Plan with Delete Reason
 ;
 N DA,DIE,DR,IBCNT,IBIEN
 ;
 D MES^XPDUTL("   - Updating GROUP INSURANCE PLAN")
 ;
 S IBCNT=0
 S IBIEN=0
 F  S IBIEN=$O(^IBA(355.3,IBIEN)) Q:'IBIEN  D
 . ; If Date Last Matched exists and Plan ID does not, add the delete reason
 . I $$GET1^DIQ(355.3,IBIEN,1.07)'="",$$GET1^DIQ(355.3,IBIEN,6.01)="" D
 . . ; Make sure a Delete Reason does not already exist.  If this post install
 . . ; is run more than once, it could overwrite actual user-entered comments.
 . . ; This check prevents that from happening.
 . . I $$GET1^DIQ(355.3,IBIEN,3.01)'="" Q
 . . ; logic to add comment
 . . S DIE=355.3
 . . S DA=IBIEN
 . . S DR="3.01////Plan deleted prior to comment being required"
 . . D ^DIE
 . . S IBCNT=IBCNT+1
 ;
 D MES^XPDUTL("     - "_IBCNT_" entries updated")
 D MES^XPDUTL("   - Done with GROUP INSURANCE PLAN")
 D MES^XPDUTL(" ")
 ;
 Q
