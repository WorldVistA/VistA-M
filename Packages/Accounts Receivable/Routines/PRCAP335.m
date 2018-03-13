PRCAP335 ;OAK/ELZ - Pre-install routine for patch PRCA*4.5*335 ;11/15/2017
 ;;4.5;Accounts Receivable;**335**;Mar 20, 1995;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This pre-install is a double check that an old AR file that should have been deleted
 ; a long time ago is actually not there before install of a new file (same number 430.7)
 ; 
 ;
PRE ; Entry point to check for an old file and if there remove it
 ; before the install starts
 ;
 N PRCAX
 I $P($G(^PRCA(430.7,0)),"^")="AR BILLING ERROR HANDLING" D
 . N DU,DA,DIK
 . D MES^XPDUTL("  It appears you have an old 430.7 file that shouldn't be there.")
 . D MES^XPDUTL("  - deleting before install.")
 . ; just because the data clean up doesn't work well, there are not that many entries anyway
 . S PRCAX=0 F  S PRCAX=$O(^PRCA(430.7,PRCAX)) Q:'PRCAX  S DIK="^PRCA(430.7,",DA=PRCAX D ^DIK
 . S DU="^PRCA(430.7,",DU(0)="DET"
 . D EN^DIU2
 . D MES^XPDUTL("  Finished old file cleaned up.")
 S PRCAX=$O(^PRCA(430.7,0)) I PRCAX,'$G(^PRCA(430.7,PRCAX,0)) D
 . D MES^XPDUTL("  Need to clean up some old data...")
 . K ^PRCA(430.7)
 . S ^PRCA(430.7,0)="AR DEBT COLLECTOR DATA^430.7D^^0"
 . D MES^XPDUTL("  Finished cleaning up old data.")
 Q
