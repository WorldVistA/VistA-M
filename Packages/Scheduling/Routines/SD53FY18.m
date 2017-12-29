SD53FY18 ;ALB/TXH - FY18 STOP CODE UPDATES;04/27/17
 ;;5.3;Scheduling;**663**;AUG 13, 1993;Build 2
 ;
 ; Post-init routine updating stop codes in CLINIC STOP file (#40.7)
 ; for FY2018 updates.
 ;
 Q
 ;
EN ; Update stop codes in Clinic Stop file 40.7
 ;
 D BMES^XPDUTL("SD*5.3*663 Post-Install starts...")
 D:$P($T(NEW+1),";;",2)'="QUIT" ADD      ; add new stop code
 D:$P($T(OFF+1),";;",2)'="QUIT" INACT    ; inactivate
 D:$P($T(CHG+1),";;",2)'="QUIT" CHGNM    ; change name
 D BMES^XPDUTL("SD*5.3*663 Post-Install is complete."),MES^XPDUTL("")
 ; 
 Q
 ;
ADD ; Add new stop code
 ; SDREC is in format: 
 ;       ;;stop code name^code #^restriction type^restriction date^CDR
 ;
 N SDI,SDREC,SDCODE,SDNM,SDRESTYP,SDFDA,SDADDERR,SDIEN,SDRESDT,SDCDR
 D BMES^XPDUTL(">>> Adding stop code to the CLINIC STOP (#40.7) file...")
 D BMES^XPDUTL(" [NOTE: These Stop Codes CANNOT be used UNTIL 10/1/2017]")
 ;
 ; load all new entries
 F SDI=1:1 S SDREC=$P($T(NEW+SDI),";;",2) Q:SDREC="QUIT"  D
 . S SDCODE=$P(SDREC,U,2)   ;code
 . S SDNM=$P(SDREC,U)       ;name
 . S SDRESTYP=$P(SDREC,U,3) ;restriction type
 . S SDRESDT=$P(SDREC,U,4)  ;restriction date
 . S SDCDR=$P(SDREC,U,5)    ;CDR #
 . ;
 . ; check if code already exists
 . S SDIEN=$$FIND1^DIC(40.7,"","MX",SDCODE,"","","SDADDERR")
 . I $D(SDADDERR) D  Q
 . . D BMES^XPDUTL("    >> ... Unable to add stop code "_SDCODE_" "_SDNM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(SDADDERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . K SDADDERR
 . ;
 . ; if code already exists, update it
 . I SDIEN D  Q
 . . D BMES^XPDUTL("     >> Code "_SDCODE_" already exists, update it.")
 . . S SDFDA(40.7,"+1,",.01)=SDNM
 . . S SDFDA(40.7,"+1,",1)=SDCODE
 . . S SDFDA(40.7,"+1,",4)=SDCDR
 . . S SDFDA(40.7,"+1,",5)=SDRESTYP
 . . S SDFDA(40.7,"+1,",6)=SDRESDT
 . . D FILE^DIE(,"SDFDA","SDADDERR")
 . . ; check if error
 . . I '$D(SDADDERR) D  Q
 . . . D BMES^XPDUTL("    >> Stop Code "_SDCODE_" "_SDNM_" updated, code already exists.")
 . . I $D(SDADDERR) D
 . . . D BMES^XPDUTL("    >> ... Unable to add stop code "_SDCODE_" "_SDNM_" to file.")
 . . . D MES^XPDUTL("    >> ... "_$G(SDADDERR("DIERR",1,"TEXT",1))_".")
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . ; if code does not exist, add new entry
 . ; set field values of new entry
 . S SDFDA(40.7,"+1,",.01)=SDNM
 . S SDFDA(40.7,"+1,",1)=SDCODE
 . S SDFDA(40.7,"+1,",4)=SDCDR
 . S SDFDA(40.7,"+1,",5)=SDRESTYP
 . S SDFDA(40.7,"+1,",6)=SDRESDT
 . ; add new entry
 . D UPDATE^DIE("E","SDFDA","","SDADDERR")
 . ; check if error
 . I '$D(SDADDERR) D  Q
 . . D BMES^XPDUTL("    >> Stop Code "_SDCODE_" "_SDNM_" added to file.")
 . I $D(SDADDERR) D
 . . D BMES^XPDUTL("    >> ... Unable to add stop code "_SDCODE_" "_SDNM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(SDADDERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 ;
 D BMES^XPDUTL(">>> Add new stop codes complete.")
 D MES^XPDUTL("")
 ;
 Q
 ;
INACT ; Inactivate stop code
 ; SDREC is in format: ;;code #^^inactivation date (in FileMan format)
 ;
 N SDI,SDREC,SDCODE,SDEXDT,SDINDT,SDNM,SDINTERR
 D BMES^XPDUTL(">>> Inactivating stop codes in CLINIC STOP (#40.7) file...")
 D BMES^XPDUTL(" [NOTE: These Stop Codes CANNOT be used AFTER the indicated inactivation date.]")
 ;
 ; load entries w/ inactivate date
 F SDI=1:1 S SDREC=$P($T(OFF+SDI),";;",2) Q:SDREC="QUIT"  D
 . S SDCODE=$P(SDREC,U)  ;code
 . ; get inactivate date and validate date passed in
 . I +$P(SDREC,U,3) D
 . . S X=$P(SDREC,U,3)
 . . S %DT="FTX"
 . . D ^%DT
 . . Q:Y<0
 . . S SDINDT=Y
 . . D DD^%DT
 . . S SDEXDT=Y
 . . ; check if code already exists
 . . S SDIEN=$$FIND1^DIC(40.7,"","MX",SDCODE,"","","SDINTERR")
 . . I 'SDIEN D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to find stop code: "_SDCODE)
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; check if error
 . . I $D(SDADDERR) D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to inactivate stop code "_SDCODE)
 . . . D MES^XPDUTL("    >> ... "_$G(SDINTERR("DIERR",1,"TEXT",1))_".")
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . ; if no error, check if active
 . . I $D(^DIC(40.7,SDIEN,0)) I $P(^(0),U,3)="" D
 . . . S SDNM=$P($G(^DIC(40.7,SDIEN,0)),U)   ;code name
 . . . ; set field value
 . . . K SDFDA
 . . . S SDFDA(40.7,SDIEN_",",2)=SDINDT
 . . . D FILE^DIE(,"SDFDA","SDINTERR")
 . . . ; check if error
 . . . I $D(SDINTERR) D  Q
 . . . . D BMES^XPDUTL("    >> ... Unable to inactivate stop code: "_SDCODE)
 . . . . D MES^XPDUTL("    >> ... "_$G(SDINTERR("DIERR",1,"TEXT",1))_".")
 . . . . D MES^XPDUTL("     >> ... Please contact support for assistance.")
 . . . I '$D(SDINTERR) D
 . . . . D BMES^XPDUTL("     >> Inactivated: "_+SDCODE_"   "_SDNM_" as of "_SDEXDT)
 ;
 D BMES^XPDUTL(">>> Inactivation complete.")
 K %,%DT,%H,%I,DIC,X,Y
 D MES^XPDUTL("")
 ;
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
 . S SDNM=$P(SDREC,U)      ;current name
 . S SDCODE=$P(SDREC,U,2)  ;code
 . S SDNEWNM=$P(SDREC,U,4) ;new name
 . ; check if code already exists
 . S SDIEN=$$FIND1^DIC(40.7,"","MX",SDCODE,"","","SDCHGERR")
 . ; check if error
 . I $D(SDINTERR) D  Q
 . . D BMES^XPDUTL("    >> ... Unable to inactivate stop code: "_SDCODE)
 . . D MES^XPDUTL("    >> ... "_$G(SDCHGERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . ; quit if no entry in file
 . I 'SDIEN D  Q
 . . D BMES^XPDUTL("    >> ... Unable to find stop code: "_SDCODE)
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . ; check if code is active
 . I $D(^DIC(40.7,SDIEN,0)) I $P(^(0),U,3)="" D
 . . K SDFDA
 . . S SDFDA(40.7,SDIEN_",",.01)=SDNEWNM
 . . D FILE^DIE(,"SDFDA","SDCHGERR")
 . . ; check if error
 . . I $D(SDCHGERR) D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to change name for stop code: "_SDCODE)
 . . . D MES^XPDUTL("    >> ... "_$G(SDCHGERR("DIERR",1,"TEXT",1))_".")
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . I '$D(SDCHGERR) D
 . . . D BMES^XPDUTL("    >> Stop Code "_SDCODE_" name changed from: "_SDNM)
 . . . D MES^XPDUTL("                                    to: "_SDNEWNM)
 ;
 D BMES^XPDUTL(">>> Changing code names complete.")
 ;
 Q
 ;
NEW ; codes to add - ;;stop code name^code #^restriction type^restriction date^CDR
 ;;CARDIOTHORACIC SURG^486^E
 ;;BARIATRIC SURG^487^E
 ;;SURG ONCOLOGY^488^E
 ;;SPINAL SURG^489^E
 ;;QUIT
 ;
OFF ; codes to be inactivated - ;;code #^^inactive date
 ;;295^^10/1/2017
 ;;412^^10/1/2017
 ;;416^^10/1/2017
 ;;422^^10/1/2017
 ;;426^^10/1/2017
 ;;431^^10/1/2017
 ;;433^^10/1/2017
 ;;571^^10/1/2017
 ;;572^^10/1/2017
 ;;QUIT
 ;
CHG ; Code name changes - ;;code name^code #^^new code name
 ;;PHARM/PHYSIO NMP STUDIES^145^^MYOCARD PERF STUDIES
 ;;CARDIAC STRESS TEST/ETT^334^^CARDIAC STRESS TEST
 ;;ENT^403^^OTOLARYNGOLOGY/ENT
 ;;ORTHOPEDICS^409^^ORTHO/JOINT SURG
 ;;PRE-SURG EVAL BY MD^432^^PRE-SURG EVAL
 ;;SF TH PRV SITE(SAMSTA)^695^^SF TH PRV SITE SAME DIV/STA
 ;;QUIT
 ;
