DVBA169P ;ALB/SBW/EF - PATCH DVBA*2.7*169 PRE/POST INSTALL UTILITIES ; 24/MAY/2011
 ;;2.7;AMIE;**169**;Apr 10, 1995;Build 5
 ;
 ;No direct entry allowed
 Q
 ;
PRE ;Main entry point for Pre-install items
 ;
 N DVBVERSS,DVBVERSN
 D BMES^XPDUTL("***** PRE-INSTALL PROCESSING *****")
 ; Get Template Patch Version Suffix
 D GETPATV(.DVBVERSS,.DVBVERSN)
 ; Deactivate older versions of CAPRI templates
 D DEACT(DVBVERSN)
 ;
 Q
 ;
POST ;Main entry point for Post-install items
 ;
 N DVBVERSS,DVBVERSN
 D BMES^XPDUTL("***** POST-INSTALL PROCESSING *****")
 ; Get Template Patch Version Suffixes
 D GETPATV(.DVBVERSS,.DVBVERSN)
 ; Rename/Activate CAPRI templates that were loaded by the patch
 D ACTIVATE(DVBVERSS,DVBVERSN)
 ; updates for the AMIE EXAM (#396.6) file 
 D AMIE
 Q
 ;
GETPATV(DVBVERSS,DVBVERSN) ;Get Patch Version Suffix to be used
 ;
 ;OUTPUT:
 ;  DVBVERSS - Incoming Patch Version Suffix (e.g. 999F)
 ;  DVBVERSN - Rename Patch Version Suffix (e.g. 999 or 999T1)
 ;    Version Suffix will be as follows:
 ;      New entry to be renamed is Patch Number with a "F" (e.g 999F)
 ;      Released patch will be just Patch Number (e.g 999)
 ;      Test Patch will be Patch Number with a "T" and Test Patch 
 ;         Version Number (e.g. 999T1)
 ;    Note that the Patch Version is appended to the Template Name with
 ;    a "~" delimeter between name and version (e.g. DBQ Template 
 ;    Example~999T1).
 N DVBPAT,DVBATVER
 ;
 ; Update the following variable to be the patch number
 ; ****** Change to the appropriate patch number *****
 S DVBPAT="169"
 ; ****** End user modification ******
 ;
 ; The Patch Version Suffix for new incoming CAPRI Template entries
 ; should be patch number followed by "F"
 S DVBVERSS=DVBPAT_"F"
 ;
 ; The Patch Version Suffix which will be appended for the Name
 ; (#.01) Field in the CAPRI Template Definition (#396.18) file
 ; entry to allow for template versioning.
 S:$D(^XTMP("XPDI",$G(XPDA),"BLD",$G(XPDBLD),6))>0 DVBATVER=$P($G(^XTMP("XPDI",$G(XPDA),"BLD",$G(XPDBLD),6)),U,1)
 S DVBVERSN=DVBPAT_$S($G(DVBATVER)>0:"T"_DVBATVER,1:"")
 Q
 ;
DEACT(DVBVERSN) ;De-activate older versions of CAPRI templates
 ;
 ;Used to disable older versions of a template for those templates
 ;being exported with the patch based on the data in CAPRITXT
 ;subroutine.
 ; - Make sure to that all entries in the CAPRITXT subroutine are 
 ;   accurate.
 ; - This must be called as a pre-init or else it will disable the
 ;   templates that are being loaded by the patch.
 ;INPUT
 ;  DVBVERSN - Rename Patch Version Suffix (e.g. 999 or ~999)
 ;    See GETPATV Subroutine comments for Version Suffix descriptions
 ;
 N DVBACTR,DVBAI,DVBLINE
 S DVBACTR=0
 ;
 D BMES^XPDUTL(" Disabling CAPRI templates...")
 D MES^XPDUTL("")
 ;
 F DVBAI=1:1 S DVBLINE=$P($T(CAPRITXT+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 . N DVBAMSG
 . D DISABLE^DVBAUTLP($P(DVBLINE,";",1),DVBVERSN,.DVBACTR,.DVBAMSG)
 . ; Display status message returned if any
 . D:$D(DVBAMSG)>0 MES^XPDUTL(.DVBAMSG)
 ;
 D BMES^XPDUTL("    Number of CAPRI templates disabled:  "_DVBACTR)
 Q
 ;
 ;
ACTIVATE(DVBVERSS,DVBVERSN) ;Activate CAPRI templates that were loaded 
 ;by the patch and updates Patch Version Suffix for versioning control.
 ;
 ;Used to activate/rename templates that were loaded by the patch.
 ; - Make sure to that all entries in the CAPRITXT subroutine are
 ;   accurate.
 ; - Must be called as a post-init in order to rename those
 ;   templates being loaded by the patch.
 ;
 ;INPUT
 ;  DVBVERSS - Incoming Patch Version Suffix (e.g. 999F)
 ;  DVBVERSN - Rename Patch Version Suffix (e.g. 999 or 999T1)
 ;    Version Suffix will be as follows:
 ;    See GETPATV Subroutine comments for Version Suffix descriptions
 ;
 N DVBACTR,DVBAI,DVBLINE
 ;
 S DVBACTR=0
 ;
 D BMES^XPDUTL(" Activating CAPRI templates...")
 D MES^XPDUTL("")
 ;
 F DVBAI=1:1 S DVBLINE=$P($T(CAPRITXT+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 . N DVBAMSG
 . D RENAME^DVBAUTLP($P(DVBLINE,";",1),DVBVERSS,DVBVERSN,.DVBACTR,.DVBAMSG)
 . ; Display status message returned if any
 . D:$D(DVBAMSG)>0 MES^XPDUTL(.DVBAMSG)
 ;
 D BMES^XPDUTL("    Number of CAPRI templates activated:  "_DVBACTR)
 Q
 ;
 ;
AMIE ;Updates for the AMIE EXAM (#396.6) file
 ;
 ;Used to inactivate old entries and create new entries for
 ;designated worksheet updates
 ;
 D BMES^XPDUTL(" Update to AMIE EXAM (#396.6) file...")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing AMIE EXAM (#396.6) file") Q
 I $D(^DVB(396.6)) D
 . D INACT
 . D NEW
 Q
 ;
 ;
INACT ;Inactivate old (current) exams
 ;
 N DVBAI,DVBLINE,DVBIEN,DVBEXM
 ;
 D BMES^XPDUTL(" Inactivating AMIE EXAM (#396.6) file entries...")
 D MES^XPDUTL("")
 F DVBAI=1:1 S DVBLINE=$P($T(AMIEOLD+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 . N DVBAMSG
 . S DVBIEN=$P(DVBLINE,";",1)
 . S DVBEXM=$P(DVBLINE,";",2)
 . D INACTEXM^DVBAUTLP(DVBIEN,DVBEXM,.DVBAMSG)
 . ; Display status message returned if any
 . D:$D(DVBAMSG)>0 MES^XPDUTL(.DVBAMSG)
 . D MES^XPDUTL("")
 Q
 ;
 ;
NEW ;Add new exam entries
 ;
 N DVBAI,DVBLINE,DVBIEN,DVBEXM,DVBPNM,DVBBDY,DVBROU,DVBSTAT,DVBWKS
 ;
 D BMES^XPDUTL(" Adding new AMIE EXAM (#396.6) file entries...")
 F DVBAI=1:1 S DVBLINE=$P($T(AMIENEW+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 . N DVBAMSG
 . S DVBIEN=$P(DVBLINE,";",1)  ;ien
 . S DVBEXM=$P(DVBLINE,";",2)  ;exam name
 . S DVBPNM=$P(DVBLINE,";",3)  ;print name
 . S DVBBDY=$P(DVBLINE,";",4)  ;body system
 . S DVBROU=$P(DVBLINE,";",5)  ;routine name
 . S DVBSTAT=$P(DVBLINE,";",6) ;status
 . S DVBWKS=$P(DVBLINE,";",8)  ;worksheet number
 . D BMES^XPDUTL("  Attempting to add Entry #"_DVBIEN_"...")
 . D NEWEXAM^DVBAUTLP(DVBIEN,DVBEXM,DVBPNM,DVBBDY,DVBROU,DVBSTAT,DVBWKS,.DVBAMSG)
 . ; Display status message returned if any
 . D:$D(DVBAMSG)>0 MES^XPDUTL(.DVBAMSG)
 Q
 ;
 ;
 ; CAPRI TEMPLATE DEFINITIONS (#396.18) file entries to Dectivate
 ; and/or Rename. If old versions of the Templates exist they will
 ; be De-Activated. No harm is done if Template doesn't currently
 ; exist but it should still be included here in case multiple test
 ; versions are done which would required previous test patch 
 ; version to be De-Activated.
 ; Only entries that are Versioned as ~###F (# = Patch Version 
 ; Number) will be Renamed 
 ;
 ; Data should be in internal format. 
 ; Format: Template Name (250 chars) 
 ;    Note - Do not include Version Portion of name (i.e ~999T or ~999)
CAPRITXT ;
 ;;DBQ AMYOTROPHIC LATERAL SCLEROSIS (LOU GEHRIG'S DISEASE)
 ;;DBQ ISCHEMIC HEART DISEASE
 ;;DBQ HAIRY CELL AND OTHER B CELL LEUKEMIAS
 ;;DBQ HEARING LOSS AND TINNITUS
 ;;DBQ HEMATOLOGIC AND LYMPHATIC CONDITIONS, INCLUDING LEUKEMIA
 ;;DBQ KIDNEY CONDITIONS (NEPHROLOGY)
 ;;DBQ LEUKEMIA
 ;;DBQ MALE REPRODUCTIVE SYSTEM CONDITIONS
 ;;DBQ PARKINSONS
 ;;DBQ PROSTATE CANCER
 ;;DBQ SKIN DISEASES
 ;;QUIT
 ;
 ; AMIE EXAM (#396.6) file exam(s) to deactivate. Data should be in
 ; internal format. 
 ; Format: ien;exam name (60 chars);
AMIEOLD ;
 ;;315;DBQ HEARING LOSS AND TINNITUS
 ;;325;DBQ HEMIC AND LYMPHATIC CONDITIONS INCLUDING LEUKEMIA
 ;;316;DBQ KIDNEY CONDITIONS (NEPHROLOGY)
 ;;302;DBQ LEUKEMIA
 ;;317;DBQ MALE REPRODUCTIVE SYSTEM CONDITIONS
 ;;323;DBQ PROSTATE CANCER
 ;;336;DBQ SKIN DISEASES
 ;;QUIT
 ;
 ; AMIE EXAM (#396.6) file exam(s) to activate (create or update).
 ; Data should be in internal format.
 ; format: ien;exam name (60 chars);print name (25 chars);body system;routine;status;;wks#
AMIENEW ;
 ;;351;DBQ HAIRY CELL AND OTHER B CELL LEUKEMIAS;DBQ HAIRY&OTHR BCELL LEUK;22;DVBCQBC5;A; ; ;
 ;;352;DBQ HEARING LOSS AND TINNITUS;DBQ HEARING LOSS AND TINNITUS;3;DVBCQHL4;A; ; ;
 ;;353;DBQ HEMIC AND LYMPHATIC CONDITIONS INCLUDING LEUKEMIA;DBQ HEMIC AND LYMPHATIC;22;DVBCQHA7;A; ; ;
 ;;331;DBQ KIDNEY CONDITIONS (NEPHROLOGY);DBQ KIDNEY CONDITIONS;8;DVBCQKC3;A; ; ;
 ;;330;DBQ MALE REPRODUCTIVE SYSTEM CONDITIONS;DBQ MALE REPRO SYSTEM;8;DVBCQMR4;A; ; ;
 ;;350;DBQ PROSTATE CANCER;DBQ PROSTATE CANCER;8;DVBCQPC5;A; ; ;
 ;;402;DBQ SKIN DISEASES;DBQ SKIN DISEASES;11;DVBCQSK4;A; ; ; 
 ;;QUIT
