DG53P650 ;ALB/KCL - PATCH DG*5.3*650 INSTALL UTILITIES ; 7/12/06 09:12am
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 QUIT
 ;
 ;--------------------------------------------------------------
 ;Patch DG*5.3*650: Environment, Pre-Install, and Post-Install
 ;entry points.
 ;--------------------------------------------------------------
 ;
ENV ;Main entry point for Environment check point
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
PRE ;Main entry point for Pre-Install items
 ;
 D PRE1   ;rename security key
 D PRE2   ;delete obsolete security keys
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 ;
 D POST1  ;set query try limit parameter
 D POST2  ;enable primary site for PRF Assignment ownership
 D POST3  ;build "AOWN" index on file #26.13
 Q
 ;
 ;
PROGCHK(XPDABORT) ;Checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
PRE1 ;Rename security keys
 ;
 N DGI,DGOLD,DGNEW
 ;
 S DGOLD(1)="DGPF RECORD FLAG ASSIGNMENT" ;old name
 S DGNEW(1)="DGPF ASSIGNMENT"             ;new name
 ;
 S DGOLD(2)="DGPF LOCAL FLAG EDIT"        ;old name
 S DGNEW(2)="DGPF MANAGER"                ;new name
 ;
 D BMES^XPDUTL("*****")
 D MES^XPDUTL("Attempting to rename security keys...")
 ;
 ;loop through keys
 S DGI=0
 F  S DGI=$O(DGOLD(DGI)) Q:'DGI  D  ;drops out of DO block on failure
 . ;
 . ;quit if key already renamed
 . I +$$LKUP^XPDKEY(DGNEW(DGI)) D  Q
 . . D MES^XPDUTL("Security key "_DGOLD(DGI)_" already renamed to "_DGNEW(DGI)_".")
 . ;
 . ;attempt to rename key
 . I '$$RENAME^XPDKEY(DGOLD(DGI),DGNEW(DGI)) D  Q
 . . D MES^XPDUTL("Could not rename "_DGOLD(DGI)_" security key.")
 . ;
 . D MES^XPDUTL("Security key "_DGOLD(DGI)_" renamed to "_DGNEW(DGI)_".")
 ;
 D MES^XPDUTL("*****")
 Q
 ;
PRE2 ;Delete obsolete security keys
 ;
 N DGIEN,DGNAME
 ;
 D BMES^XPDUTL("*****")
 D MES^XPDUTL("Attempting to delete obsolete security keys...")
 ;
 ;loop thru obsolete keys
 F DGNAME="DGPF PRF ACCESS","DGPF PRF CONFIG" D
 . ;
 . ;lookup key
 . S DGIEN=$$LKUP^XPDKEY(DGNAME)
 . ;
 . ;quit with msg if key lookup fails
 . I '+$G(DGIEN) D  Q
 . . D MES^XPDUTL("Security key "_DGNAME_" already deleted.")
 . ;
 . ;delete key
 . D DEL^XPDKEY(+$G(DGIEN))
 . D MES^XPDUTL("Security key "_DGNAME_" deleted. IEN="_DGIEN_".")
 ;
 D MES^XPDUTL("*****")
 Q
 ;
POST1 ;set query try limit parameter
 ;
 N DGERR    ;XPAR error result
 N DGPARM   ;parameter name
 N DGRETRY  ;# of retries
 ;
 S DGPARM="DGPF QUERY TRY LIMIT"
 S DGRETRY=5
 D EN^XPAR("PKG",DGPARM,1,DGRETRY,.DGERR)
 D BMES^XPDUTL("*****")
 I '$G(DGERR) D
 . D MES^XPDUTL(DGPARM_" parameter set to "_DGRETRY_" SUCCESSFULLY")
 E  D
 . D MES^XPDUTL(DGPARM_" parameter set FAILED")
 D MES^XPDUTL("*****")
 ;
 Q
 ;
POST2 ;enable primary site for PRF Assignment ownership
 ;
 N DGDIV   ;pointer to MEDICAL CENTER DIVISION (#40.8) file
 N DGSITE  ;$$SITE results
 ;
 S DGSITE=$$SITE^VASITE()
 S DGDIV=+$O(^DG(40.8,"AD",+DGSITE,0))
 D BMES^XPDUTL("*****")
 I DGDIV,$$STODIV^DGPFDIV1(DGDIV,1) D
 . D MES^XPDUTL($P(DGSITE,U,2)_" enabled for PRF Assignment ownership SUCCESSFULLY")
 E  D
 . D MES^XPDUTL("Attempt to enable primary site for PRF Assignment ownership FAILED")
 D MES^XPDUTL("*****")
 ; 
 Q
 ;
POST3 ;populate "AOWN" index of PRF ASSIGNMENT (#26.13) file
 ;
 N DIK
 ;
 S DIK="^DGPF(26.13,"
 S DIK(1)=".04^AOWN"
 D ENALL^DIK
 ;
 Q
