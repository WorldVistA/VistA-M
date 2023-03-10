SD53MY21 ;ALB/TXH - FY21 MID-YEAR STOP CODE UPDATES; SEP 22, 2020@10:40
 ;;5.3;Scheduling;**770**;AUG 13, 1993;Build 4
 ;
 ; Post-install routine updating stop codes in CLINIC STOP file
 ; (#40.7) for FY21 mid-year updates - effective 04/01/2021.
 ;
 ; References to $$FIND1^DIC supported by ICR# 2051
 ; References to FILE^DIE supported by ICR# 2053
 ; References to BMES^XPDUTL supported by ICR# 10141
 ; References to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ; Update stop codes in Clinic Stop file 40.7
 ;
 D BMES^XPDUTL("SD*5.3*770 Post-Install starts...")
 D:$P($T(ACT+1),";;",2)'="QUIT" REACT    ; reactivate code
 D:$P($T(CHG+1),";;",2)'="QUIT" CHGNM    ; change name
 D BMES^XPDUTL("SD*5.3*770 Post-Install complete.")
 D MES^XPDUTL("")
 K SDIEN,%H,%I,DIC,X,Y
 Q
 ;
REACT ; Reactivate code
 ; SDREC is in format: ;;code #^
 ;
 N SDDA,SDX,SDXX,DA,DIE,DR,SDERR
 D BMES^XPDUTL(">>> Reactivating Clinic Stop in CLINIC STOP (#40.7) file...")
 ;
 ; Load entries
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(ACT+SDX),";;",2) Q:SDXX="QUIT"  D
 . S SDDA=+$O(^DIC(40.7,"C",+SDXX,0))
 . ; Check if inactive
 . I $P($G(^DIC(40.7,SDDA,0)),U,3)'="" D
 . . K SDFDA
 . . S SDFDA(40.7,SDDA_",",2)=""
 . . D FILE^DIE(,"SDFDA","SDERR")
 . . ; check if error
 . . I '$D(SDERR) D BMES^XPDUTL("     Reactivated: "_+SDXX_"     "_$P($G(^DIC(40.7,SDDA,0)),"^"))
 . . I $D(SDERR) D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to reactivate stop code: "_SDDA)
 . . . D MES^XPDUTL("    >> ... "_$G(SDERR("DIERR",1,"TEXT",1))_".")
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . . K SDERR
 D BMES^XPDUTL(">>> Reactivating code completed.")
 Q
 ;
CHGNM ; Change code names
 ; SDREC is in format: ;;code name^code #^^new code name
 ;
 N SDI,SDCODE,SDIEN,SDNEWNM,SDNM,SDREC,SDCHGERR
 D BMES^XPDUTL(">>> Changing code names in CLINIC STOP (#40.7) file...")
 ;
 ; load entries
 F SDI=1:1 S SDREC=$P($T(CHG+SDI),";;",2) Q:SDREC="QUIT"  D
 . S SDCODE=$P(SDREC,U,2)  ;code
 . S SDNEWNM=$P(SDREC,U,4) ;new name
 . ;
 . ; check if code already exists
 . S SDIEN=$$FIND1^DIC(40.7,"","MX",SDCODE,"","","SDCHGERR")
 . ;
 . ; check if error
 . I $D(SDCHGERR) D  Q
 . . D BMES^XPDUTL("    >> ... Unable to change name of the stop code: "_SDCODE)
 . . D MES^XPDUTL("    >> ... "_$G(SDCHGERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . ; clean out error array b4 processing next code
 . . K SDCHGERR
 . ;
 . ; quit if no entry in file
 . I 'SDIEN D  Q
 . . D BMES^XPDUTL("    >> ... Unable to find stop code: "_SDCODE)
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . ;
 . ; check if code is active
 . I $D(^DIC(40.7,SDIEN,0)) I $P(^(0),U,3)="" D
 . . ; get current name
 . . S SDNM=$P(^DIC(40.7,SDIEN,0),U,1)
 . . K SDFDA
 . . S SDFDA(40.7,SDIEN_",",.01)=SDNEWNM
 . . D FILE^DIE(,"SDFDA","SDCHGERR")
 . . ; check if error
 . . I $D(SDCHGERR) D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to change name for stop code: "_SDCODE)
 . . . D MES^XPDUTL("    >> ... "_$G(SDCHGERR("DIERR",1,"TEXT",1))_".")
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . . ; clean out error array b4 processing next code
 . . . K SDCHGERR
 . . I '$D(SDCHGERR) D
 . . . D BMES^XPDUTL("    >> Stop Code "_SDCODE_" name changed from: "_SDNM)
 . . . D MES^XPDUTL("                                    to: "_SDNEWNM)
 . . . I SDNM=SDNEWNM D
 . . . . D BMES^XPDUTL("       Stop Code "_SDCODE_" name has already changed.")
 ;
 D BMES^XPDUTL(">>> Changing code names complete.")
 D MES^XPDUTL("")
 Q
 ;
ACT ; Code to be reactivated - ;;number^
 ;;306^
 ;;QUIT
 ;
CHG ; Code name changes - ;;code name^code #^^new code name
 ;;^306^^DIABETES CLINIC
 ;;QUIT
