IB20P217 ;ISP/TJH - ENVIRONMENT CHECK WITH PRE-INIT CODE for IB*2.0*217 ;04/02/2003
 ;;2.0;INTEGRATED BILLING;**217**;21-MAR-94
 ;
ENV ; environment check
 ; No special environment check at this time.
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("SUP","SUP^IB20P217")
 Q
 ;
SUP ; set new value into SUPRESS BULLETIN field of IBCE MESSAGES SERVER option
 ; change the value from NO to YES.  Resolves NOIS SBY-0403-30897
 D BMES^XPDUTL("Updating SUPRESS BULLETIN value for IBCE MESSAGES SERVER option.")
 N DA,IBFL,IBROOT,IBERR
 S DA=""
 I $D(^DIC(19,"B","IBCE MESSAGES SERVER")) S DA=$O(^DIC(19,"B","IBCE MESSAGES SERVER",""))
 I DA=""  D ERRMSG("IBCE MESSAGES SERVER option not found") G EXIT
 S IBFL="",IBROOT(19,DA_",",224)="Y"
 D FILE^DIE(IBFL,"IBROOT","IBERR")
 I $D(IBERR("DIERR")) D ERRMSG(IBERR("DIERR",1,"TEXT",1)) G EXIT
 D BMES^XPDUTL("Pre-init completed successfully.")
EXIT Q
 ;
ERRMSG(TXT) ; Write error message
 D BMES^XPDUTL("Update failed.  "_TXT)
 Q
