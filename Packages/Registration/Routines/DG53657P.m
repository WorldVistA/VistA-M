DG53657P ;BAJ - Patch DG*5.3*657 Pre-Install Utility Routine ; 10/24/2006
 ;;5.3;Registration;**657**;AUG 13, 1993;Build 19
 Q
 ;
 ;
EN N XPDABORT
 D LKUP(61,"MISSING PHONE NUMBER DATA","C")
 ;2 - consistency check not there, 3 - consistency check is wrong
 I ($G(XPDABORT)=2)!($G(XPDABORT)=3) Q  ;Find file 38.6 entry
 D LKUP(87,"SC ELIG BUT NO RD CODES","A")
 Q:$G(XPDABORT)=3
 D POSTN ;Modify file 38.6 entry
 D CREATE ;add the 87 consistency check
 D COMPILE
 Q
 ;
LKUP(RULE,FIELD01,MODE) ; Update entry in INCONSISTENT DATA ELEMENTS file (#38.6)
 ;MODE = 'C' change
 ;MODE = 'A' add
 N ERR,DA,DIE,DR,X
 K XPDABORT
 D BMES^XPDUTL("Checking entry #"_RULE_" in 38.6 file.")
 S DIE=38.6,DA=$$FIND1^DIC(DIE,"","X",RULE)
 I 'DA,MODE="C" D  Q
 . S XPDABORT=2
 . D MES^XPDUTL("    *** Entry not found! ***")
 . D BMES^XPDUTL("    *** Please contact EVS for assistance ***")
 . D BMES^XPDUTL("    *** INSTALLATION ABORTED ***")
 . D BMES^XPDUTL("")
 . Q
 S X=""
 I $G(DA)'="" S X=$G(^DGIN(38.6,DA,0))
 I X'="",$P(X,"^",1)'=FIELD01 D  Q
 . S XPDABORT=3
 . D MES^XPDUTL("    *** Field #.01 should be "_FIELD01_"! ***")
 . D BMES^XPDUTL("    *** Please contact EVS for assistance ***")
 . D BMES^XPDUTL("    *** INSTALLATION ABORTED ***")
 . D BMES^XPDUTL("")
 . Q
 Q
POSTN ; Update entry in INCONSISTENT DATA ELEMENTS file (#38.6)
 N FILE,IENS,FIELD,DGWP,ERRORS,FDA
 D BMES^XPDUTL("Updating Consistency #61")
 ;FDA_ROOT(FILE#,"IENS",FIELD#)="VALUE"
 S FILE=38.6,IENS="61,",FIELD=50
 S DGWP(1,0)="Inconsistency results if the patient's Employment Status is EMPLOYED FULL"
 S DGWP(2,0)="TIME, EMPLOYED PART TIME, or SELF EMPLOYED and the PHONE NUMBER [WORK] has"
 S DGWP(3,0)="not been entered."
 S FDA(FILE,IENS,FIELD)="DGWP"
 D FILE^DIE("K","FDA","ERRORS(1)")
 I $D(ERRORS) D  Q
 . D MES^XPDUTL("    *** Error filing Data Dictionary update! ***")
 . D BMES^XPDUTL("    *** Please contact EVS for assistance ***")
 . D BMES^XPDUTL("    *** INSTALLATION ABORTED ***")
 . D BMES^XPDUTL("")
 . Q
 D MES^XPDUTL("    *** Update Complete ***")
 D BMES^XPDUTL("")
 Q
 ;
CREATE ;Post-Install
 N MSGROOT,FDAWP,FDAROOT,IENROOT,IEN,X,ERR,LN,LN2
 S X=$G(^DGIN(38.6,87,0))
 I $L(X),$P(X,"^",1)'="SC ELIG BUT NO RD CODES" D  Q
 . D BMES^XPDUTL("An entry already exists in file 38.6 for consistency #87.")
 . D MES^XPDUTL("Cannot add SC ELIG BUT NO RD CODES.")
 . Q
 I $L(X),$P(X,"^",1)="SC ELIG BUT NO RD CODES" Q
 D BMES^XPDUTL("Adding Consistency #87")
 S IEN="+1,"
 S FDAROOT(38.6,IEN,.01)="SC ELIG BUT NO RD CODES"
 S FDAROOT(38.6,IEN,2)="SC ELIGIBILITY BUT NO RATED DISABILITY CODES"
 S FDAROOT(38.6,IEN,50)="FDAWP"
 S FDAWP(1,0)="Inconsistency results if the PRIMARY ELIGIBILITY CODE"
 S FDAWP(2,0)="is a 1 (SERVICE CONNECTED 50% TO 100%) or a 3 (SC LESS THAN 50%)"
 S FDAWP(3,0)="and no rated disabilities are present."
 S FDAROOT(38.6,IEN,3)="NO KEY REQUIRED"
 S FDAROOT(38.6,IEN,5)="CHECK"
 S IENROOT(1)=87
 D UPDATE^DIE("E","FDAROOT","IENROOT","MSGROOT")
 I $D(MSGROOT("DIERR")) D  Q
 . S (ERR,LN2)=0
 . D ERR
 . D BMES^XPDUTL(.X)
 . Q
 D MES^XPDUTL("    *** CC #87 Added ***")
 D BMES^XPDUTL("")
 Q
ERR F  S ERR=+$O(MSGROOT("DIERR",ERR)) Q:'ERR  D LN
 Q
LN S LN=0
 F  S LN=+$O(MSGROOT("DIERR",ERR,"TEXT",LN)) Q:'LN  D
 . S LN2=LN2+1
 . S X(LN2)=MSGROOT("DIERR",ERR,"TEXT",LN)
 . Q
 Q
COMPILE ;compile screen 7
 D BMES^XPDUTL("Re-compiling input template DG LOAD EDIT SCREEN 7 of PATIENT FILE(#2)")
 N X,Y,DMAX
 S Y=$O(^DIE("B","DG LOAD EDIT SCREEN 7",""))
 I Y'="" D
 . S X=$G(^DIE(Y,"ROU")) I $E(X)="^" S X=$E(X,2,99)
 . S DMAX=$$ROUSIZE^DILF
 . D EN^DIEZ
 . Q
 D BMES^XPDUTL("Re-compiling input template DVBHINQ UPDATE of PATIENT FILOE(#2)")
 S Y=$O(^DIE("B","DVBHINQ UPDATE",""))
 I Y'="" D
 . S X=$G(^DIE(Y,"ROU")) I $E(X)="^" S X=$E(X,2,99)
 . S DMAX=$$ROUSIZE^DILF
 . D EN^DIEZ
 . Q
 Q
