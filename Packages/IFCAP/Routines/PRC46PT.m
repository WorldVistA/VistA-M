PRC46PT ;WIRMFO/DHH-CLEAN UP FILE 410.1 ;1/17/02  11:01 AM
V ;;5.1;IFCAP;**46**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
QUIT Q
 ;
CLEAN ;
 ; clean up file 410.1
 ; if entry is no longer in 442 then delete 1358 entry in 410.1
 ;
 D MES^XPDUTL(">>>Starting clean up of file 410.1.<<<")
 D MES^XPDUTL("  ")
 N PAT
 S PAT="" F  S PAT=$O(^PRCS(410.1,"B",PAT)) Q:PAT=""  D
 . ;check for pattern match X?3N1"-"6AN
 . Q:'(PAT?3N1"-"6AN)
 . ;check to see if transaction exists in 442
 . Q:$D(^PRC(442,"B",PAT))
 . N DA
 . S DA=$O(^PRCS(410.1,"B",PAT,0))
 . Q:'$D(^PRCS(410.1,DA,0))
 . D MES^XPDUTL("   >>>Deleting entry - "_PAT)
 . S DIK="^PRCS(410.1," D ^DIK
 . K DIK,X
 D MES^XPDUTL("  ")
 D MES^XPDUTL(">>>Clean up of file 410.1 COMPLETED.")
 Q
