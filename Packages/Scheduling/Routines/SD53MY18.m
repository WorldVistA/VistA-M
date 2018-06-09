SD53MY18 ;ALB/TXH - MID-FY18 STOP CODE UPDATES;10/18/17
 ;;5.3;Scheduling;**677**;AUG 13, 1993;Build 14
 ;
 ; Post-init routine updating stop codes in CLINIC STOP file (#40.7)
 ; for Mid-FY2018 updates - effective 04/01/2018.
 ;
 Q
 ;
POST ; Update stop codes in Clinic Stop file 40.7
 ;
 D BMES^XPDUTL("SD*5.3*677 Post-Install starts...")
 D:$P($T(NEW+1),";;",2)'="QUIT" ADD      ; add new stop code
 D:$P($T(OFF+1),";;",2)'="QUIT" INACT    ; inactivate
 D:$P($T(CHG+1),";;",2)'="QUIT" CHGNM    ; change name
 D:$P($T(RT+1),";;",2)'="QUIT" CHGRT     ; change restriction data
 D MES^XPDUTL("SD*5.3*677 Post-Install is complete."),MES^XPDUTL("")
 K SDIEN,%H,%I,DIC,X,Y
 ; 
 Q
 ;
ADD ; Add new stop code
 ; SDREC is in format: 
 ;   ;;stop code name^code #^restriction type^restriction date^CDR
 ;
 N SDI,SDREC,SDCODE,SDNM,SDRESTYP,SDFDA,SDADDERR,SDIEN,SDCDR,SDRESIN,SDRESEX
 D BMES^XPDUTL(">>> Adding stop code to the CLINIC STOP (#40.7) file...")
 D BMES^XPDUTL("    [NOTE: These Stop Codes CANNOT be used UNTIL 04/01/2018]")
 ;
 ; load all new entries
 F SDI=1:1 S SDREC=$P($T(NEW+SDI),";;",2) Q:SDREC="QUIT"  D
 . S SDCODE=$P(SDREC,U,2)   ;code
 . S SDNM=$P(SDREC,U)       ;name
 . S SDRESTYP=$P(SDREC,U,3) ;restriction type
 . S (SDRESIN,SDRESEX)=""
 . ; restriction date
 . I +$P(SDREC,U,4) D
 . . S X=$P(SDREC,U,4)
 . . S %DT="FTX"
 . . D ^%DT
 . . I Y<0 S SDRESIN="" Q
 . . S SDRESIN=Y
 . . D DD^%DT
 . . S SDRESEX=Y
 . S SDCDR=$P(SDREC,U,5)    ;CDR #
 . ;
 . ; check if code already exists in file 40.7
 . S SDIEN=$$FIND1^DIC(40.7,"","MX",SDCODE,"","","SDADDERR")
 . ; quit if error
 . I $D(SDADDERR) D  Q
 . . D BMES^XPDUTL("       >> ... Unable to add stop code "_SDCODE_" "_SDNM_" to file.")
 . . D MES^XPDUTL("        >> ... "_$G(SDADDERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("        >> ... Please contact support for assistance...")
 . . K SDADDERR
 . ;
 . ; If code already exists, update it.
 . I SDIEN D  Q
 . . K SDADDERR
 . . S SDFDA(40.7,SDIEN_",",.01)=SDNM
 . . S SDFDA(40.7,SDIEN_",",1)=SDCODE
 . . S SDFDA(40.7,SDIEN_",",4)=SDCDR
 . . S SDFDA(40.7,SDIEN_",",5)=SDRESTYP
 . . S SDFDA(40.7,SDIEN_",",6)=SDRESIN
 . . D FILE^DIE(,"SDFDA","SDADDERR")
 . . ; check if error
 . . I '$D(SDADDERR) D  Q
 . . . D BMES^XPDUTL("     >> Stop Code "_SDCODE_" "_SDNM_" already exists.")
    . . I $D(SDADDERR) D
    . . . D BMES^XPDUTL("         ... Unable to add stop code "_SDCODE_" "_SDNM_" to file.")
    . . . D MES^XPDUTL("         ... "_$G(SDADDERR("DIERR",1,"TEXT",1))_".")
    . . . D MES^XPDUTL("         ... Please contact support for assistance.")
    . . . K SDADDERR
 . ; if code does not exist, add new entry
 . ; set field values of new entry
 . S SDFDA(40.7,"+1,",.01)=SDNM
 . S SDFDA(40.7,"+1,",1)=SDCODE
 . S SDFDA(40.7,"+1,",4)=SDCDR
 . S SDFDA(40.7,"+1,",5)=SDRESTYP
 . S SDFDA(40.7,"+1,",6)=SDRESIN
 . ; add new entry
 . D UPDATE^DIE("E","SDFDA","","SDADDERR")
 . ; check if error
 . I '$D(SDADDERR) D
 . . D BMES^XPDUTL("    >> Stop Code "_SDCODE_" "_SDNM_" added to file.")
 . I $D(SDADDERR) D
 . . D BMES^XPDUTL("    >> ... Unable to add stop code "_SDCODE_" "_SDNM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(SDADDERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; clean out error array b4 processing next code
 . . K SDADDERR
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
 D BMES^XPDUTL("  [NOTE: These Stop Codes CANNOT be used AFTER the indicated inactivation date.]")
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
 . . ; quit if unable to find code in 40.7
 . . I 'SDIEN D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to find stop code: "_SDCODE)
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; check if error
 . . I $D(SDINTERR) D  Q
 . . . D BMES^XPDUTL("    >> ... Unable to inactivate stop code "_SDCODE)
 . . . D MES^XPDUTL("    >> ... "_$G(SDINTERR("DIERR",1,"TEXT",1))_".")
 . . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . . ; clean out error array b4 processing next code
 . . . K SDINTERR
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
 . . . . ; clean out error array b4 processing next code
 . . . . K SDINTERR
 . . . I '$D(SDINTERR) D
 . . . . D BMES^XPDUTL("     >> Inactivated: "_+SDCODE_"   "_SDNM_" as of "_SDEXDT)
 ;
 D BMES^XPDUTL(">>> Inactivation complete.")
 D MES^XPDUTL("")
 K %,%DT,%H,%I,DIC,X,Y
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
 . I $D(SDCHGERR) D  Q
 . . D BMES^XPDUTL("    >> ... Unable to inactivate stop code: "_SDCODE)
 . . D MES^XPDUTL("    >> ... "_$G(SDCHGERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . ; clean out error array b4 processing next code
 . . K SDCHGERR
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
 . . . ; clean out error array b4 processing next code
 . . . K SDCHGERR
 . . I '$D(SDCHGERR) D
 . . . D BMES^XPDUTL("    >> Stop Code "_SDCODE_" name changed from: "_SDNM)
 . . . D MES^XPDUTL("                                    to: "_SDNEWNM)
 . . . I SDNM=SDNEWNM D BMES^XPDUTL("    >> Stop Code "_SDCODE_" name not changed.")
 ;
 D BMES^XPDUTL(">>> Changing code names complete.")
 D MES^XPDUTL("")
 ;
 Q
 ;
CHGRT ; Change restriction data
 ; SDREC is in format: ;;code name^code #^restriction type^restriction date
 N SDI,SDREC,SDNM,SDNUM,SDRTERR,SDIEN,SDOLDRT,SDRD,SDRT,SDX,SDINDT,SDEXRD
 D BMES^XPDUTL(">>> Changing restriction data in CLINIC STOP (#40.7) file...")
 ; load entry
 F SDI=1:1 S SDREC=$P($T(RT+SDI),";;",2) Q:SDREC="QUIT"  D
 . S SDNM=$P(SDREC,U)       ; code name
 . S SDNUM=$P(SDREC,U,2)    ; code #
 . S SDRT=$P(SDREC,U,3)     ; restriction type
 . S SDRD=$P(SDREC,U,4)     ; restriction date
 . ;
 . ; check if code already exists and get code IEN
 . S SDIEN=$$FIND1^DIC(40.7,"","MX",SDNUM,"","","SDRTERR")
 . ; check if error
 . I $D(SDRTERR) D  Q
 . . D BMES^XPDUTL("    >> ... Unable to inactivate stop code: "_SDNUM)
 . . D MES^XPDUTL("    >> ... "_$G(SDRTERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance...")
 . . ; clean out error array b4 processing next code
 . . K SDRTERR
 . I 'SDIEN D  Q
 . . D BMES^XPDUTL("    >> ... Unable to find stop code: "_SDNUM)
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . ; find current restriction type and date
 . I $D(^DIC(40.7,SDIEN,0)) I $P(^(0),U,3)="" D
 . . S SDOLDRT=$P(^DIC(40.7,SDIEN,0),U,6)
 . . S SDEXRD=""
 . . S X=$P(^DIC(40.7,SDIEN,0),U,7)
 . . S %DT="FTX" D ^%DT Q:Y<0
 . . S SDINDT=Y D DD^%DT S SDEXRD=Y
 . ; set field value
 . K SDFDA
 . S SDFDA(40.7,SDIEN_",",5)=SDRT
 . S SDFDA(40.7,SDIEN_",",6)=SDRD
 . D FILE^DIE(,"SDFDA","SDRTERR")
 . D BMES^XPDUTL("    >> Stop Code "_SDNUM_" restriction type changed from: "_SDOLDRT)
 . D MES^XPDUTL("                                                to: "_SDRT)
 . D MES^XPDUTL("    >>               restriction date changed from: "_SDEXRD)
 . D MES^XPDUTL("                                                to: "_SDRD)
 D BMES^XPDUTL(">>> Changing restriction data complete.")
 D MES^XPDUTL("")
    K %,%DT,%H,%I,DIC,X,Y
    K SDFDA
 Q
 ;
NEW ; codes to add - ;;stop code name^code #^restriction type^restriction date^CDR
 ;;WHEELCHAIR & ADVAN MOBILITY^241^E^
 ;;ENVIRON HEALTH REG EXAM^499^S^4/1/2018
 ;;QUIT
 ;
OFF ; codes to be inactivated - ;;code #^^inactive date
 ;;306^^4/1/2018
 ;;547^^4/1/2018
 ;;548^^4/1/2018
 ;;610^^4/1/2018
 ;;QUIT
 ;
CHG ; Code name changes - ;;code name^code #^^new code name
 ;;ENTEROSTOMAL WOUND/SKIN CARE^142^^WOUND TREAT & OSTOMY CARE
 ;;PHYS EXTND NP (NRS PRCNR) 2ND^185^^NURSE PRACTITIONER
 ;;PHYS EXTND PA (PHYS ASST) 2ND^186^^PHYSICIAN ASSISTANT
 ;;PHYS EXTND CNS (CLN RN SPC)2ND^187^^CLINICAL NURSE SPECIALIST
 ;;PHYSICAL MED & REHAB SVC^201^^PM&RS PHYSICIAN
 ;;ENDO./METAB (EXCEPT DIABETES)^305^^ENDOCRINOLOGY
 ;;RT CLIN VD TH PRV SITE(SAMSTA)^692^^CVT PRV SITE SAME DIV/STA
 ;;CVT SAME STA SERVICES^699^^CVT EMERGENCY CONSULT
 ;;QUIT
 ;
RT ; Change Restriction - ;;stop code name^CODE #^rest type^rest date
 ;;WOUND TREAT & OSTOMY CARE^142^E^
 ;;QUIT
