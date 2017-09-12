ECX135PT ;ALB/BP - PATCH ECX*3.0*135 Post-Init Rtn ; 11/24/09 2:11pm
 ;;3.0;DSS EXTRACTS;**135**;Dec 22, 1997;Build 7
 ;
 ;Post-init routine to add new entries to:
 ;       
 ;           NATIONAL CLINIC file (#728.441)
 ;
 ;
 Q
EN ;Routine Entry Point
 D POST1 ;Add new Clinic codes
 D POST2 ;Change short description of existing clinic code
 Q
 ;
 ;
POST1 ;- Add new entry to file 728.441
 ;      ECXREC is in format: code^short description
 ;
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I
 D BMES^XPDUTL(">>> Adding entry to the NATIONAL CLINIC (#728.441) file...")
 ;
 ;- Get NATIONAL CLINIC record
 F I=1:1 S ECXREC=$P($T(NATCLIN+I),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;- National Clinic code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;- Quit w/error message if entry already exists in file #728.441
 .I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  not added, entry already exists.")
 ..D BMES^XPDUTL(">>> Delete entries and reinstall patch if entries were not created by a")
 ..D MES^XPDUTL(">>> previous installation of this patch.")
 .;
 .;- Setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;- Add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_"  "_$P(ECXREC,U,2)_" to file.")
 ;
 Q
 ;
POST2 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,I
 F I=1:1 S ECXREC=$P($T(NATCLIND+I),";;",2) Q:ECXREC="QUIT"  D
 .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
 .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
 .S DIE="^ECX(728.441,",DA=ECXIEN,DR="1///^S X=ECXDESC"
 .D ^DIE
 ;
NATCLIN ;- Contains the NATIONAL CLINIC entry to be added
 ;;ACUP^Acupuncture
 ;;BIOF^Biofeedback
 ;;CBHT^Cognitive Behavioral Therapy
 ;;CHAP^Chaplain
 ;;DEMT^Dementia-MH Therapist
 ;;DEPS^Dementia-Psychologist
 ;;ECOE^Epilepsy Center of Excellence
 ;;GIMA^Guided Imagery
 ;;HYPN^Hypnotherapy
 ;;MANT^Mantram Repetition
 ;;MBSR^Mindfulness-Based Stress Reduction
 ;;MDTN^Meditation
 ;;MHMT^Mental Health-MH Therapist
 ;;MHPS^Mental Health-Psychologist
 ;;MMMT^Multiple CoMorbidities-MH Therapist
 ;;MMPS^Multiple CoMorbidities-Psychologist
 ;;MSCE^MS Center of Excellence
 ;;MSGT^Massage therapy
 ;;NAHL^Native American healing
 ;;NDTR^Nutrition Diet Tech Registered
 ;;NUDT^Nutrition Diet Tech
 ;;NUTR^Nutrition Staff
 ;;PADR^PADRECC
 ;;PILA^Pilates
 ;;PLMT^Palliative Care-MH Therapist
 ;;PLPS^Palliative Care-Psychologist
 ;;RFLX^Reflexology
 ;;RLXT^Relaxation techniques
 ;;TAIC^Tai chi
 ;;TPHT^Therapeutic or healing touch
 ;;YOGA^Yoga
 ;;DTMV^Diet Tech-MOVE
 ;;NUMV^Nutritionist-MOVE
 ;;RDMV^Registered Dietitian-MOVE
 ;;RDNU^Nutrition Registered Dietitian
 ;;QUIT
NATCLIND ;- Contains the NATIONAL CLINIC entry description to be updated
 ;;CNSZ^E-Consult
 ;;CPRZ^SCAN-ECHO
 ;;QUIT
