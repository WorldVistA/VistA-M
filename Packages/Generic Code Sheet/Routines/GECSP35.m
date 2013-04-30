GECSP35 ;WOIFO/SAB - PATCH INSTALL ROUTINE ;4/3/2012
 ;;2.0;GCS;**35**;MAR 14, 1995;Build 2
 ; 
 ; ICRs
 ;  #2051   $$FIND1^DIC
 ;  #2053   FILE^DIE
 ;  #2054   CLEAN^DILF
 ;  #10141  BMES^XPDUTL, MES^XPDUTL, $$NEWCP^XPDUTL
 ;
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N GECX,Y
 F GECX="UPD" D
 . S Y=$$NEWCP^XPDUTL(GECX,GECX_"^GECSP35")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_GECX_" Checkpoint.")
 Q
 ;
UPD ; update file
 N GECNM
 D BMES^XPDUTL("    Updating GENERIC CODE SHEET TRANSACTION TYPE/SEGMENT file...")
 ;
 ; inactivate code sheets
 F GECNM="994.00","994.01","994.02","994.10","994.90" D INACT(GECNM)
 ;
 D MES^XPDUTL("    Done.")
 Q
 ;
INACT(GECNM) ; inactivate entry
 N GECFDA,GECI
 S GECI=$$FIND1^DIC(2101.2,,"X",GECNM)
 I GECI D
 . S GECFDA(2101.2,GECI_",",1)="N"
 . D FILE^DIE("","GECFDA")
 . D CLEAN^DILF
 Q
 ;
 ;GECSP35
