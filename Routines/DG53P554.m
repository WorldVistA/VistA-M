DG53P554 ;ALB/RBS - PATCH DG*5.3*554 INSTALL UTILITIES ; 3/16/06 2:55pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT)  ;checks programmer variables
 Q:$G(XPDABORT)
 ;
 I XPDABORT="" K XPDABORT
 ;
 ;Per KIDS documentation...XPDQUIT is used for multiple builds
 S XPDQUIT=""
 D TIUCHK(.XPDQUIT)   ;check for TIU Progress Note Title
 Q:$G(XPDQUIT)
 ;
 I XPDQUIT="" K XPDQUIT
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
 N DGACTDT  ;software activation date
 ;
 D POST1    ;link BEHAVIORAL Category I PRF to TIU PN
 ;
 D POST2    ;create new "C" index for Principal Investigator field
 ;           in the PRF Local Flag (#26.11) file.
 ;
 S DGACTDT="June 20, 2006"  ;PRF Phase 2 Software Activation date
 ;
 D POST3(DGACTDT)    ;create/update PRF PHASE 2 ACTIVATION (#6) field
 ;                    in the PRF PARAMETERS (#26.18) file.
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
 ;
TIUCHK(XPDQUIT) ;check for Category I (National) TIU Progress Note Title
 ;name setup in the TIU DOCUMENT DEFINITION file (#8925.1)
 ;Abort if not found.
 ;
 N DGTITLE
 S DGTITLE="PATIENT RECORD FLAG CATEGORY I"
 ;
 I '$$FIND1^DIC(8925.1,"","X",DGTITLE,"B") D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("The TIU Progress Note Title name 'PATIENT RECORD FLAG CATEGORY I' is not setup.")
 . D MES^XPDUTL("See patch TIU*1*165 for details.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDQUIT=1
 ;
 Q
 ;
 ;
POST1 ;link associated TIU PROGRESS NOTE TITLE IEN to
 ;the Category I (National) PRF BEHAVIORAL Flag
 ;
 ;warn installer if flag not found
 I '$D(^DGPF(26.15,"B","BEHAVIORAL")) D  Q
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("  'BEHAVIORAL' Category I (National) PRF Flag not defined...seek help!")
 . D MES^XPDUTL("*****")
 ;
 ;short circuit if flag TIU PN Title already exists
 I $D(^DGPF(26.15,"ATIU")) D  Q
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("  'BEHAVIORAL' Category I (National) PRF Flag already associated with a TIU Progress Note Title...No action taken.")
 . D MES^XPDUTL("*****")
 ;
 N DGFLAG  ;Category I (National) PRF name
 N DGIEN   ;IEN of National Flag record
 N DGFDA   ;filer FDA array
 N DGIENS  ;filer record IEN value
 N DGERR   ;filer error array
 N DGTITLE ;Category I (National) TIU Progress Note Title name
 ;
 ;Category I (National) PRF flag IEN record value
 S DGFLAG="BEHAVIORAL"
 S DGIEN=$O(^DGPF(26.15,"B",DGFLAG,0))
 S DGIENS=DGIEN_","
 ;
 ;set name equal to the nationaly released Category I Title that
 ;is setup in the TIU DOCUMENT DEFINITION file (#8925.1)
 S DGTITLE="PATIENT RECORD FLAG CATEGORY I"
 ;
 ;build FDA array
 S DGFDA(26.15,DGIENS,.07)=DGTITLE
 ;
 ;file link in new field (#.07) TIU PN TITLE
 D FILE^DIE("E","DGFDA","DGERR")
 ;
 ;check for errors and inform the installer of update status
 D BMES^XPDUTL("*****")
 I '$D(DGERR) D
 . D MES^XPDUTL("  'BEHAVIORAL' Category I (National) PRF Flag linked to associated TIU Progress Note Title successfully.")
 E  D
 . D MES^XPDUTL("  'BEHAVIORAL' Category I (National) PRF Flag link to associated TIU Progress Note Title failed!")
 D MES^XPDUTL("*****")
 Q
 ;
 ;
POST2 ;create new 'C' index for Principal Investigator field (multiple)
 ;-- PRF LOCAL FLAG (#26.11) file
 ;-- SUB-FILE (2) PRINCIPAL INVESTIGATOR(S) (#26.112), field (.01)
 ;
 Q:$D(^DGPF(26.11,"C"))  ;already setup
 ;
 N DA,DIC,DIK,DGIEN,X
 ;
 S DGIEN=0
 F  S DGIEN=$O(^DGPF(26.11,DGIEN)) Q:'DGIEN  D
 . K DA,DIC,DIK,X
 . S DIK=$$ROOT^DILFD(26.112,","_DGIEN_",")
 . S DIK(1)=".01^C"
 . S DA(1)=DGIEN
 . D ENALL^DIK
 ;
 Q
 ;
 ;
POST3(DGACTDT) ;create/update PRF PHASE 2 ACTIVATION (#6) field of the
 ;PRF PARAMETERS (#26.18) file entry at IEN "1"
 ;
 ;  Input:
 ;    DGACTDT - (required) software activation date in external format
 ;
 ;  Output:
 ;    none
 ;
 N DGERR     ;error array
 N DGFDA     ;FDA array
 N DGRESULT  ;return var
 ;
 Q:($G(DGACTDT)="")
 ;
 ;existing file entry
 Q:'$D(^DGPF(26.18,1,0))
 ;
 ;convert external date to internal FM date
 D CHK^DIE(26.18,6,"",DGACTDT,.DGRESULT,"DGERR")
 Q:$D(DGERR)
 Q:'$G(DGRESULT)
 ;
 S DGACTDT=DGRESULT
 ;
 S DGFDA(26.18,"1,",6)=DGACTDT
 ;
 D FILE^DIE("","DGFDA","DGERR")
 ;
 Q
