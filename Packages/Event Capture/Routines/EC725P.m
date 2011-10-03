EC725P ;BIR/CML,JPW-Post Updates in Files 725 and 723 ;28 Aug 96
 ;;2.0; EVENT CAPTURE ;**2,4,5,10**;8 May 96
 ;
 ;
EN ;- Entry point for post-init
 ;
 D CRESPEC^EC725P()
 Q
 ;
 ;
CRESPEC(LABEL) ;patch 5 - add new records to file #723
 ;
 ;- Added LABEL parameter for patch EC*2*10 so code can be reused in future
 N DIC,X,Y,J,ERR,MSG,CNT,BAD,SAVEY,GOOD
 S CNT=0,BAD=1
 S LABEL=$G(LABEL)
 S MSG="Adding entries to Medical Specialty file (#723)......"
 D BMES^XPDUTL(MSG)
 ;
 ;- If LABEL not defined, use MEDSPEC line tag as default
 S:(LABEL="") LABEL="MEDSPEC"
 ;
 ;check for existing exact match; don't add if there already
 F J=1:1 S X=$P($T(@LABEL+J),";;",2) Q:X="END"  D
 . K Y
 . S DIC="^ECC(723,"
 . S DIC(0)="X"
 . D ^DIC
 . S SAVEY=+Y
 . I SAVEY>0 D
 .. S MSG=">>> You already have a "_X_" record. New entry not created."
 .. D BMES^XPDUTL(MSG)
 .. S BAD=BAD+1,ERR(BAD)=X
 . I SAVEY=-1 D
 .. K DD,DO,Y
 .. D FILE^DICN
 .. I Y=-1 S BAD=BAD+1,ERR(BAD)=X
 .. I +Y>0 S CNT=CNT+1,GOOD(CNT)=$P(Y,"^",2)
 ;
 ;- Let the user know what happened
 D MES^XPDUTL("")
 ;
 ;- Display entries which weren't created
 I $D(ERR) D
 .S ERR(1)="The following entries could not be created in file #723:"
 .D BMES^XPDUTL(.ERR)
 ;
 ;- Display entries successfully added
 I CNT>0 D
 . D MES^XPDUTL("")
 . S MSG="Completed...... a total of "_CNT_" entries were added to file #723."
 . D BMES^XPDUTL(MSG)
 . S MSG="The following entries have been added:"
 . D BMES^XPDUTL(MSG)
 . D BMES^XPDUTL(.GOOD)
 D MES^XPDUTL("")
 Q
 ;
 ;
MEDSPEC ;- New medical specialties to be added
 ;;NURSING
 ;;RADIOLOGY
 ;;END
 ;
 ;
NEW723 ;#.01 fields for new records
 ;;OUTPATIENT CLINIC
 ;;C&P REQUESTS
 ;;VETERAN CENTER
 ;;DAY TREATMENT CENTER
 ;;PAIN CLINIC
 ;;EMPLOYEE HEALTH
 ;;NUTRITION AND FOOD SERVICE
