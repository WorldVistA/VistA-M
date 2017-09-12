DVBA181P ;ALB/RPM - PATCH DVBA*2.7*181 POST-INSTALL ;5/14/2012
 ;;2.7;AMIE;**181**;Apr 10, 1995;Build 38
 ;
 Q  ;NO DIRECT ENTRY
 ;
ENV ;Main entry point for Environment check point.
 ;
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1  ;Populate Virtual VA parameter definitions
 D POST2  ;Edit AMIE EXAM file DBQ entries
 Q
 ;
POST1 ;Populate new Virtual VA parameter definitions
 ;
 N DVBERR
 D BMES^XPDUTL("*************************")
 D MES^XPDUTL("Start Parameter Updates")
 D MES^XPDUTL("*************************")
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VIRTUALVA PROD URL","https://vbaphi8popp.vba.domain.ext:7002/VABFI/services/vva")
 D UPDMSG("DVBAB CAPRI VIRTUALVA PROD URL",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VIRTUALVA TEST URL","https://vbaphi5topp.vba.domain.ext:7002/VABFI/services/vva")
 D UPDMSG("DVBAB CAPRI VIRTUALVA TEST URL",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VVA USER","CAPRI")
 D UPDMSG("DVBAB CAPRI VVA USER",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VVA TEST PASSWD","XXXXX")
 D UPDMSG("DVBAB CAPRI VVA TEST PASSWD",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VVA PROD PASSWD","Passw0rd1")
 D UPDMSG("DVBAB CAPRI VVA PROD PASSWD",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VVA TEST TOKEN","Username-1")
 D UPDMSG("DVBAB CAPRI VVA TEST TOKEN",DVBERR)
 ;
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VVA PROD TOKEN","Username-1")
 D UPDMSG("DVBAB CAPRI VVA PROD TOKEN",DVBERR)
 ;
 D MES^XPDUTL("*************************")
 D MES^XPDUTL("End Parameter Updates")
 D MES^XPDUTL("*************************")
 Q
 ;
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;Update Parameter values
 ;
 ;  Input:
 ;    DVBENT - Parameter Entity
 ;    DVBPAR - Parameter Name
 ;    DVBVAL - Parameter Value
 ;
 ;  Output:
 ;    Function value - returns "0" on success;
 ;                     otherwise returns error#^errortext
 ;
 N DVBERR
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBERR)
 Q DVBERR
 ;
UPDMSG(DVBPAR,DVBERR) ;display update message
 ;
 ;  Input:
 ;    DVBPAR - Parameter Name
 ;    DVBERR - Parameter Update result
 ;
 ;  Output: none
 ; 
 I DVBERR D
 . D MES^XPDUTL(DVBPAR_" update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D MES^XPDUTL(DVBPAR_" update SUCCESS.")
 Q
 ;
POST2 ;Edit AMIE EXAM file DBQ entries
 ;
 ;Update active DBQ worksheet updates
 ;
 ;
 D BMES^XPDUTL(" *** RENAMING ACTIVE DBQ AMIE EXAM FILE ENTRIES ***")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing AMIE EXAM (#396.6) file") Q
 I $D(^DVB(396.6)) D STARTRN
 Q
 ;
 ;
STARTRN ;Rename existing DBQ exam file entries
 ;
 N DVBAI,DVBLINE,DVBIEN,DVBEXMO,DVBEXMN
 ;
 D BMES^XPDUTL("Renaming AMIE EXAM (#396.6) file entries...")
 F DVBAI=1:1 S DVBLINE=$P($T(EXOLDNEW+DVBAI),";;",2) Q:DVBLINE="QUIT"  D 
 . S DVBIEN=$P(DVBLINE,";",1)  ;ien
 . S DVBEXMO=$P(DVBLINE,";",2)  ;old exam name
 . S DVBEXMN=$P(DVBLINE,";",3)  ;new exam name
 . D RENEXAM
 Q
 ;
RENEXAM ;
 ;Quit if critical variables missing
 I $G(DVBIEN)'>0!($G(DVBEXMO)']"")!($G(DVBEXMN)']"") D  Q
 . D BMES^XPDUTL("Insufficient data to process change at #"_DVBIEN_")")
 ;
 ; Update existing entry
 ;
 N DVBAERR,DVBAFDA
 ;
 ; Check for existing entry 
 I $G(^DVB(396.6,DVBIEN,0))']"" D  Q
 . D BMES^XPDUTL("No entry found at #"_DVBIEN)
 ;
 ; Check for previous update
 I $P(^DVB(396.6,DVBIEN,0),"^",1)=DVBEXMN D  Q
 . D BMES^XPDUTL("Entry at ien #"_DVBIEN_" has previously been updated")
 ;
 ; Check for correct entry NAME to update
 I $P(^DVB(396.6,DVBIEN,0),"^",1)'=DVBEXMO D  Q
 . D BMES^XPDUTL("Entry at ien #"_DVBIEN_" does not match expected name "_DVBEXMO_" No updating will take place")
 ;
 ; Update entry
 S DVBAFDA(396.6,+DVBIEN_",",.01)=$G(DVBEXMN)
 D FILE^DIE("","DVBAFDA","DVBAERR")
 ;
 ; Report sucessful update
 ;
 I $D(DVBAERR("DIERR"))'>0 D  Q
 . D BMES^XPDUTL("Renamed entry #"_DVBIEN_" from "_DVBEXMO_" to "_DVBEXMN)
 ;
 ; Report update error
 ;
 I $D(DVBAERR("DIERR"))>0 D
 . D BMES^XPDUTL("   *** Warning - Unable to update entry #"_DVBIEN_" *** ")
 . D MSG^DIALOG()
 Q
 ;
 ; ****************************************************************************
 ; AMIE EXAM (#396.6) file exam(s) to rename. Data should be in internal format. 
 ; Format: ;;ien;"old" exam name(up to 60 chars);"new" exam name(up to 60 chars)
 ;
 ; ****************************************************************************
EXOLDNEW ;
 ;;377;DBQ ENDOCRINE DISEASES OTHER THAN DIABETES;DBQ ENDO Endocrine miscellaneous
 ;;378;DBQ THYROID & PARATHYROID;DBQ ENDO Thyroid & parathyroid
 ;;379;DBQ CRANIAL NERVES;DBQ NEURO Cranial nerves
 ;;380;DBQ NARCOLEPSY;DBQ NEURO Narcolepsy
 ;;381;DBQ FIBROMYALGIA;DBQ NEURO Fibromyalgia
 ;;382;DBQ SEIZURE DISORDERS (EPILEPSY);DBQ NEURO Seizure disorders (Epilepsy)
 ;;383;DBQ URINARY TRACT AND BLADDER;DBQ GU Urinary tract (bladder and urethra)
 ;;384;DBQ ABDOMINAL, INGUINAL, AND FEMORAL HERNIAS;DBQ GEN SURG Hernia inguinal, femoral & abdom (not hiatal)
 ;;385;DBQ HIV-RELATED ILLNESS;DBQ INFECT HIV related illness
 ;;386;DBQ INFECTIOUS DISEASES;DBQ INFECT Infectious diseases
 ;;387;DBQ SYSTEMATIC LUPUS ERYTHEMATOUS (SLE) & OTHER IMMUNE DISOR;DBQ RHEUM Systemic lupus erythematosus
 ;;388;DBQ NUTRITIONAL DEFICIENCIES;DBQ NUTRI Nutritional deficiencies
 ;;389;DBQ ORAL AND DENTAL;DBQ DENTAL Dental & oral (other than TMJ)
 ;;390;DBQ LOSS OF SENSE OF SMELL AND TASTE;DBQ ENT Loss of sense of smell & taste
 ;;391;DBQ SINUSITIS/RHINITIS AND OTHER DISEASE OF THE NOSE, THROAT;DBQ ENT Sinusitis, rhinitis & other ENT conditions
 ;;392;DBQ RESPIRATORY CONDITIONS;DBQ RESP Respiratory conditions
 ;;393;DBQ CHRONIC FATIGUE SYNDROME;DBQ RHEUM Chronic fatigue syndrome
 ;;394;DBQ INITIAL EVALUATION OF RESIDUALS OF TBI (I-TBI);DBQ NEURO TBI Initial
 ;;395;DBQ REVIEW EVALUATION OF RESIDUALS OF TBI (R-TBI);DBQ NEURO TBI Review
 ;;396;DBQ GENERAL MEDICAL EXAM - COMPENSATION;DBQ General Medical Compensation
 ;;397;DBQ GENERAL PENSION EXAM;DBQ General Medical Pension
 ;;398;DBQ COLD INJURY RESIDUALS;DBQ Cold injury residuals
 ;;399;DBQ PRISONER OF WAR PROTOCOL;DBQ Prisoner of War (POW)
 ;;400;DBQ GULF WAR GENERAL MEDICAL EXAMINATION;DBQ General Medical Gulf War
 ;;401;DBQ AMPUTATIONS;DBQ MUSC Amputations
 ;;403;DBQ AMYOTROPHIC LATERAL SCLEROSIS (LOU GEHRIG'S DISEASE);DBQ NEURO Amyotrophic lateral sclerosis
 ;;404;DBQ ANKLE CONDITIONS;DBQ MUSC Ankle
 ;;405;DBQ ARTERY AND VEIN CONDITIONS;DBQ CARDIO Arteries & veins (vascular)
 ;;406;DBQ BACK (THORACOLUMBAR SPINE) CONDITIONS;DBQ MUSC Back (thoracolumbar spine)
 ;;407;DBQ BREAST CONDITIONS AND DISORDERS;DBQ GYN Breast conditions and disorders
 ;;408;DBQ CENTRAL NERVOUS SYSTEM DISEASES;DBQ NEURO Central nervous system
 ;;409;DBQ DIABETES MELLITUS;DBQ ENDO Diabetes mellitus
 ;;410;DBQ DIABETIC SENSORY-MOTOR PERIPHERAL NEUROPATHY;DBQ NEURO Diabetic sensory-motor peripheral neuropathy
 ;;411;DBQ EAR CONDITIONS;DBQ ENT Ear conditions
 ;;412;DBQ EATING DISORDERS;DBQ PSYCH Eating disorders
 ;;413;DBQ ELBOW AND FOREARM CONDITIONS;DBQ MUSC Elbow & forearm
 ;;414;DBQ ESOPHAGEAL CONDITIONS;DBQ GI Esophagus (including GERD & hiatal hernia)
 ;;415;DBQ EYE CONDITIONS;DBQ OPHTH Eye
 ;;416;DBQ FLATFOOT (PES PLANUS);DBQ MUSC Flatfoot (pes planus)
 ;;417;DBQ FOOT MISCELLANEOUS (OTHER THAN FLATFOOT PES PLANUS);DBQ MUSC Foot miscellaneous
 ;;418;DBQ GALLBLADDER AND PANCREAS CONDITIONS;DBQ GI Gallbladder & pancreas
 ;;419;DBQ GYNECOLOGICAL CONDITIONS;DBQ GYN Gynecological conditions
 ;;420;DBQ HAIRY CELL AND OTHER B CELL LEUKEMIAS;DBQ HEM Hairy Cell & other B-cell leukemias
 ;;421;DBQ HAND AND FINGER CONDITIONS;DBQ MUSC Hand & finger
 ;;422;DBQ HEADACHES (INCLUDING MIGRAINE HEADACHES);DBQ NEURO Headaches (including migraine headaches)
 ;;423;DBQ HEARING LOSS AND TINNITUS;DBQ AUDIO Hearing loss & tinnitus
 ;;424;DBQ HEART CONDITIONS;DBQ CARDIO Heart
 ;;425;DBQ HEMIC AND LYMPHATIC CONDITIONS INCLUDING LEUKEMIA;DBQ HEM Hemic & lymphatic, including leukemia
 ;;426;DBQ HEPATITIS, CIRRHOSIS AND OTHER LIVER CONDITIONS;DBQ GI Liver conditions Hepatitis, cirrhosis & other liver
 ;;427;DBQ HIP AND THIGH CONDITIONS;DBQ MUSC Hip & thigh
 ;;428;DBQ HYPERTENSION;DBQ CARDIO Hypertension
 ;;429;DBQ INFECTIOUS INTESTINAL DISORDERS;DBQ GI Intestines (infectious)
 ;;430;DBQ INITIAL PTSD;DBQ PSYCH PTSD Initial
 ;;431;DBQ INTESTINAL (OTHER THAN SURGICAL OR INFECTIOUS);DBQ GI Intestines (other than surgical or infectious)
 ;;432;DBQ INTESTINAL SURGERY (RESECTION, COLOSTOMY, ILEOSTOMY);DBQ GI Intestines (surgical)
 ;;433;DBQ ISCHEMIC HEART DISEASE;DBQ CARDIO Ischemic heart disease
 ;;434;DBQ KIDNEY CONDITIONS (NEPHROLOGY);DBQ GU Kidney (nephrology)
 ;;435;DBQ KNEE AND LOWER LEG CONDITIONS;DBQ MUSC Knee & lower leg
 ;;436;DBQ MALE REPRODUCTIVE SYSTEM CONDITIONS;DBQ GU Male reproductive system
 ;;437;DBQ MEDICAL OPINION 1;DBQ Medical Opinion 1
 ;;438;DBQ MEDICAL OPINION 2;DBQ Medical Opinion 2
 ;;439;DBQ MEDICAL OPINION 3;DBQ Medical Opinion 3
 ;;440;DBQ MEDICAL OPINION 4;DBQ Medical Opinion 4
 ;;441;DBQ MEDICAL OPINION 5;DBQ Medical Opinion 5
 ;;442;DBQ MENTAL DISORDERS (EXCEPT PTSD AND EATING DISORDERS);DBQ PSYCH Mental disorders
 ;;443;DBQ MULTIPLE SCLEROSIS (MS);DBQ NEURO Multiple sclerosis
 ;;444;DBQ MUSCLE INJURIES;DBQ MUSC Muscle injuries
 ;;445;DBQ NECK (CERVICAL SPINE) CONDITIONS;DBQ MUSC Neck (cervical spine)
 ;;446;DBQ NON-DEGENERATIVE ARTHRITIS;DBQ RHEUM Arthritis: non-degen (inflam, imm, cryst, infect)
 ;;447;DBQ OSTEOMYELITIS;DBQ MUSC Osteomyelitis
 ;;448;DBQ PARKINSONS;DBQ NEURO Parkinsons disease
 ;;449;DBQ PERIPHERAL NERVES (EXCLUDING DIABETIC NEUROPATHY);DBQ NEURO Peripheral nerves
 ;;450;DBQ PERITONEAL ADHESIONS;DBQ GI Peritoneal adhesion
 ;;451;DBQ PERSIAN GULF AND AFGHANISTAN INFECTIOUS DISEASES;DBQ INFECT South West Asia Infectious diseases
 ;;452;DBQ PROSTATE CANCER;DBQ GU Prostate cancer
 ;;453;DBQ RECTUM AND ANUS CONDITIONS;DBQ GEN SURG Rectum & anus (including hemorrhoids)
 ;;454;DBQ REVIEW PTSD;DBQ PSYCH PTSD Review
 ;;455;DBQ SCARS DISFIGUREMENT;DBQ DERM Scars
 ;;456;DBQ SHOULDER AND ARM CONDITIONS;DBQ MUSC Shoulder & arm
 ;;457;DBQ SKIN DISEASES;DBQ DERM Skin
 ;;458;DBQ SLEEP APNEA;DBQ RESP Sleep apnea
 ;;459;DBQ STOMACH AND DUODENAL CONDITIONS;DBQ GI Stomach & duodenum
 ;;460;DBQ TEMPOROMANDIBULAR JOINT (TMJ) CONDITIONS;DBQ MUSC Temporomandibular joint
 ;;461;DBQ TUBERCULOSIS;DBQ INFECT Tuberculosis
 ;;462;DBQ WRIST CONDITIONS;DBQ MUSC Wrist
 ;;QUIT
