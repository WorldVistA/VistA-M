DVBAP232 ;ALB/TH - 2507 SPECIAL CONSIDERATIONS FILE UPDATE ; Mar 24, 2021@09:22:10
 ;;2.7;AMIE;**232**;Apr 10, 1995;Build 1
 ;
 ; This routine is used as a post-install in a KIDS build to modify 
 ; the 2507 SPECIAL CONSIDERATIONS file (#396.25).
 ;
 ; Reference to $$FIND1^DIC supported by ICR# 2051
 ; Reference to UPDATE^DIE supported by ICR# 2053
 ; Reference to BMES^XPDUTL supported by ICR# 10141
 ; Reference to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ; Update Special Considerations in 2507 SPECIAL CONSIDERATIONS file (#396.25)
 ;
 D BMES^XPDUTL("DVBA*2.7*232 Post-Install starts...")
 D:$P($T(NEW+1),";;",2)'="QUIT" ADD      ; add new special consideration reason
 D MES^XPDUTL("DVBA*2.7*232 Post-Install is complete."),MES^XPDUTL("")
 K DVBAIEN,%H,%I,DIC,X,Y
 Q
 ;
ADD ; Add new Special Considerations
 ; DVBAREC is in format: 
 ;   ;;Special Consideration name
 ;
 D BMES^XPDUTL(">>> Adding Special Consideration to the 2507 SPECIAL CONSIDERATIONS file...")
 ;
 N DVBAI,DVBANM,DVBAREC,DVBFDA
 ; load all new entries
 F DVBAI=1:1 S DVBAREC=$P($T(NEW+DVBAI),";;",2) Q:DVBAREC="QUIT"  D
 . S DVBANM=$P(DVBAREC,U)       ;name
 . ;
 . ; check if code already exists in file 396.25
 . S DVBAIEN=$$FIND1^DIC(396.25,"","MX",DVBANM,"","","DVBAERR")
 . I DVBAIEN D  Q
 . . D BMES^XPDUTL("    >> New Special Consideration "_DVBANM_" already exists.")
 . ; quit if error
 . I $D(DVBAERR) D  Q
 . . D BMES^XPDUTL("       >> ... Unable to add Special Consideration "_DVBANM_" to file.")
 . . D MES^XPDUTL("        >> ... "_$G(DVBAERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("        >> ... Please contact support for assistance...")
 . . K DVBAERR
 . ;
 . ; if new reason does not exist, add new entry
 . ; set field values of new entry
 . S DVBFDA(396.25,"+1,",.01)=DVBANM
 . ; add new entry
 . D UPDATE^DIE("E","DVBFDA","","DVBAERR")
 . ; check if error
 . I '$D(DVBAERR) D
 . . D BMES^XPDUTL("    >> Special Consideration "_DVBANM_" added to file.")
 . I $D(DVBAERR) D
 . . D BMES^XPDUTL("    >> ... Unable to add Special Consideration "_DVBANM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(DVBAERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; clean out error array b4 processing next code
 . . K DVBAERR
 ;
 D BMES^XPDUTL(">>> Add new Special Consideration complete.")
 D MES^XPDUTL("")
 Q
 ;
NEW ; codes to add - ;;Special Consideration name^
 ;;VICAP^
 ;;QUIT
 ;
