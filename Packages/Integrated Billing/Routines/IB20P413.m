IB20P413 ;ALB/SBW - Pre and Post install APIs ;16 June 2009
 ;;2.0;INTEGRATED BILLING;**413**;21-MAR-94;Build 9
 ;
DELB ;Delete the existing traditional "B" x-ref which will be updated to be
 ;a New Style Index of Regular Type for all 40 characters of the Name 
 ;(#.01) field in the TYPE OF PLAN (#355.1) file.
 N ERRMSG
 D BMES^XPDUTL("Traditionl 'B' cross-reference on TYPE OF PLAN (#355.1) file will be removed.")
 D DELIX^DDMOD(355.1,.01,1,"K",,"ERRMSG")
 I $D(ERRMSG) D
 . D BMES^XPDUTL("Error occured when removing Old 'B' cross-reference.")
 . D BMES^XPDUTL($G(ERRMSG("DIERR",1,"TEXT",1)))
 . D BMES^XPDUTL("Contact National Help Desk for assistances.")
 ;
 Q
REINDEX ;Re-index 355.1 "B" x-ref. X-ref was updated from being limited
 ;to the first 30 characters of the 40 character .01 field to using 
 ;the entire 40 characters for the x-ref.
 ;
 ;write message to user about cross-reference re-indexing
 D BMES^XPDUTL("New 'B' cross-reference on TYPE OF PLAN (#355.1) file will be re-indexed")
 N DIK
 S DIK="^IBE(355.1,",DIK(1)=".01^B"
 D ENALL^DIK
 D BMES^XPDUTL("Re-index completed")
 Q
