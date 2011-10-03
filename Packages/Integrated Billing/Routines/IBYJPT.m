IBYJPT ;ALB/ARH - PATCH IB*2*55 POST - INITIALIZATION ; 1-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**55**; 21-MAR-94
 ;
EN ; Patch IB*2*55 post initialization.
 ;
 D RNB ;     Add new reason not billable for non-billable clinics (356.8)
 D FLAG ;    Set PROGRAM flag on existing stop and clinic entries (352.3,352.4)
 D NBSTOP ;  Add entries for TP non-billable stops (352.3)
 D BMES^XPDUTL("   Post-Install Complete")
 Q
 ;
 ;
RNB ; Add to CLAIMS TRACKING NON-BILLABLE REASONS (356.8) a reason of NON-BILLABLE CLINIC
 N IBI,DINUM,DIC,Y
 I $D(^IBE(356.8,"B","NON-BILLABLE CLINIC")) D BMES^XPDUTL("   *** REASON NOT BILLABLE of 'NON-BILLABLE CLINIC' already exists in FILE #356.8, new entry NOT added.") Q
 D BMES^XPDUTL("   <<< Adding new REASON NOT BILLABLE of 'NON-BILLABLE CLINIC' to file #356.8")
 F IBI=19:1:999 I '$D(^IBE(356.8,IBI,0)) D  Q
 . S DINUM=IBI I '$D(^IBE(356.8,DINUM,0)) K DD,DO S DIC="^IBE(356.8,",DIC(0)="L",X="NON-BILLABLE CLINIC" D FILE^DICN
 I $G(Y)<1 D BMES^XPDUTL("   **** Unable to add new entry to FILE #356.8, contact Field Support ****")
 K DIC,DINUM,Y,DD,DO
 Q
 ;
FLAG ; insert program flag into existing entries in the two files
 ;
 ; add flag to clinic stops (352.3)
 D BMES^XPDUTL("   <<< Updating entries in NON-BILLABLE CLINIC STOP CODES (#352.3) file ")
 N IBI,IBX,DIE,DA,DR
 S IBI=0 F  S IBI=$O(^IBE(352.3,IBI)) Q:'IBI  D
 . S IBX=$G(^IBE(352.3,IBI,0)) I +$P(IBX,U,4) Q
 . S DIE="^IBE(352.3,",DA=IBI,DR=".04////1" D ^DIE K DIE,DA,DR
 ;
 ; add flag to clinic (352.4)
 D BMES^XPDUTL("   <<< Updating entries in NON-BILLABLE CLINICS (#352.4) file ")
 K IBI,IBX,DIE,DA,DR
 S IBI=0 F  S IBI=$O(^IBE(352.4,IBI)) Q:'IBI  D
 . S IBX=$G(^IBE(352.4,IBI,0)) I +$P(IBX,U,4) Q
 . S DIE="^IBE(352.4,",DA=IBI,DR=".04////1" D ^DIE K DIE,DA,DR
 Q
 ;
NBSTOP ; add entries for Third Party Non-Billable Stop Codes to NON-BILLABLE CLINIC STOP CODES (#352.3) file
 ; Since the MT non-billable flag has been used as a TP non-billable flag, duplicating all MT entries
 ; that exist for TP will result in the no change in the function
 ;
 D BMES^XPDUTL("   <<< Adding TP Non-billable Stops to NON-BILLABLE CLINIC STOP CODES (#352.3) file ")
 N IBI,IBX,IBY,X
 S IBI=0 F  S IBI=$O(^IBE(352.3,IBI)) Q:'IBI  D
 . S IBX=$G(^IBE(352.3,IBI,0)) I $P(IBX,U,4)>1 Q
 . K DD,DO S IBY=$P($G(^DIC(40.7,+IBX,0)),U,1) I IBY="" Q
 . I $D(^IBE(352.3,"AIVDTT2",+IBX,-$P(IBX,U,2))) Q
 . S DIC="^IBE(352.3,",DIC(0)="L",X=+IBX D FILE^DICN I Y<1 D BMES^XPDUTL("   *** Could not add entry "_IBI) Q
 . S DIE="^IBE(352.3,",DA=+Y,DR=".02////"_$P(IBX,U,2)_";.04////2;.05////"_$P(IBX,U,3) D ^DIE K DIC,X,DIE,DA,DR
 Q
