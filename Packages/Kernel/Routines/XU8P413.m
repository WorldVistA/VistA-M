XU8P413 ;SFISC/SO- POST INSTALL KILL OFF 'AD' XREF;10:31 AM  9 Mar 2006
 ;;8.0;KERNEL;**413**;Jul 10, 1995;Build 2
 D MES^XPDUTL("Resolving STATE(#5) pointers...")
 N IEN
 S IEN=0
 F  S IEN=$O(^XIP(5.12,IEN)) Q:'IEN  D
 . N CPTR,STPTR,CSTPTR
 . ; CTPR = Pointer value to 5.13
 . ; STPTR = Pointer value to 5 in 5.12
 . ; CSTPTR = Pointer value to 5 in 5.13
 . S CPTR=+$P(^XIP(5.12,IEN,0),U,3) I 'CPTR D ERR1 Q
 . S STPTR=+$P(^XIP(5.12,IEN,0),U,4) I 'STPTR D ERR1 Q
 . S CSTPTR=+$P(^XIP(5.13,CPTR,0),U,3) I 'CSTPTR D ERR2 Q
 . I STPTR=CSTPTR Q  ;We're in sync
 . N DIE S DIE="^XIP(5.12,"
 . N DA S DA=IEN
 . N DR S DR="3////^S X=CSTPTR"
 . D ^DIE
 . Q
 D MES^XPDUTL("Finished resolving pointers.")
 D MES^XPDUTL("Deleting ""AD"" Cross Reference")
 K ^XIP(5.12,"AD")
 D MES^XPDUTL("Finished Deleting the ""AD"" Cross Reference")
 Q
 ;
ERR1 ;
 D MES^XPDUTL("POSTAL CODE(#5.12) Record: "_IEN_" has a broken COUNTY(#2) pointer.") Q
 ;
ERR2 ;
 D MES^XPDUTL("COUNTY CODE(#5.13) Record: "_CPTR_" has a broken STATE(#2) pointer") Q
