DG53P425 ;ALB/RPM - PATCH DG*5.3*425 INSTALL UTILITIES ; 8/21/03 4:52pm
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
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
 S DGACTDT="Sep 25, 2003"  ;National PRF Software Activation date
 ;
 D POST1(DGACTDT)          ;create/update PRF PARAMETERS (#26.18) file
 D POST2                   ;load BEHAVIORAL Category I PRF
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
POST1(DGACTDT) ;create PRF PARAMETERS (#26.18) file entry at IEN "1"
 ;
 ;  Input:
 ;    DGACTDT - (optional) software activation date in external format
 ;                         [default="May 01, 2003"  ;used at test sites]
 ;
 ;  Output:
 ;    none
 ;
 N DGACT  ;type of file activity (add/update)
 N DGFDA  ;FDA array
 N DGFLD  ;field #
 N DGERR  ;error array
 N DGIEN  ;IEN array
 N DGIENS
 N DGPARM  ;parameter record
 ;
 I $G(DGACTDT)="" S DGACTDT="May 01, 2003"  ;date for test sites
 ;
 ;existing file entry
 I $D(^DGPF(26.18,1,0))#2 D
 . N DGERR
 . S DGIENS="1,"
 . S DGACT="update"
 E  D
 . S DGIENS="+1,"
 . S DGACT="add"
 ;
 ;retrieve existing record
 S DGPARM=$G(^DGPF(26.18,1,0))
 ;
 ;provide values for any missing parameters
 I $P(DGPARM,U,1)="" S DGFDA(26.18,DGIENS,.01)=1
 I $P(DGPARM,U,2)="" S DGFDA(26.18,DGIENS,1)=DGACTDT   ;activation date
 I $P(DGPARM,U,3)="" S DGFDA(26.18,DGIENS,2)="ACTIVE"  ;ORU HL7 interface
 I $P(DGPARM,U,4)="" S DGFDA(26.18,DGIENS,3)="DIRECT"  ;QRY HL7 interface
 I $P(DGPARM,U,6)="" S DGFDA(26.18,DGIENS,5)=7  ;HL7 Auto Retrans Days
 ;
 ;short-circuit when there are no missing parameters
 I '$D(DGFDA) D  Q
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("  PRF PARAMETERS (#26.18) file values previously defined...no action taken.")
 . D MES^XPDUTL("*****")
 Q:'$D(DGFDA)
 D UPDATE^DIE("ES","DGFDA","DGIEN","DGERR")
 ;
 ;check for errors and inform the installer of update status
 I '$D(DGERR) D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("The '1' entry in the PRF PARAMETERS (#26.18) file was "_DGACT_$S(DGACT="add":"ed",1:"d")_" successfully.")
 . ;
 . ;display updated field list and values
 . I DGACT="update" D
 . . S DGFLD=0
 . . F  S DGFLD=$O(DGFDA(26.18,DGIENS,DGFLD)) Q:'DGFLD  D
 . . . D MES^XPDUTL("The "_$$GET1^DID(26.18,DGFLD,"","LABEL")_" (#"_DGFLD_") field was set to '"_DGFDA(26.18,DGIENS,DGFLD)_"'.")
 . D MES^XPDUTL("*****")
 E  D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("The attempt to "_DGACT_" the '1' entry in the PRF PARAMETERS (#26.18) file failed.")
 . D MES^XPDUTL($G(DGERR("DIERR",1,"TEXT",1)))
 . D MES^XPDUTL("*****")
 ;
 Q
 ;
POST2 ;create BEHAVIORAL Category I PRF
 ;
 ;short circuit if flag already exists
 I $D(^DGPF(26.15,"B","BEHAVIORAL")) D  Q
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("  'BEHAVIORAL' Category I flag previously defined...no action taken.")
 . D MES^XPDUTL("*****")
 ;
 N DGDESC  ;description word-processing array
 N DGFDA   ;FDA array
 N DGIEN   ;IEN array
 ;
 ;flag description
 S DGDESC(1,0)="The purpose of this National Patient Record Flag is to alert VHA medical"
 S DGDESC(2,0)="staff and employees of patients whose behavior or characteristics may pose"
 S DGDESC(3,0)="a threat either to their safety, the safety of other patients, or"
 S DGDESC(4,0)="compromise the delivery of quality health care."
 S DGDESC(5,0)="Application of National Patient Record Flags is coordinated through the"
 S DGDESC(6,0)="Chief of Staff."
 S DGDESC(7,0)="This is a nationally distributed flag."
 ;
 ;build FDA array
 S DGFDA(26.15,"+1,",.01)="BEHAVIORAL"
 S DGFDA(26.15,"+1,",.02)="ACTIVE"
 S DGFDA(26.15,"+1,",.03)="BEHAVIORAL"
 S DGFDA(26.15,"+1,",.04)=730
 S DGFDA(26.15,"+1,",.05)=60
 S DGFDA(26.15,"+1,",.06)="DGPF BEHAVIORAL FLAG REVIEW"
 S DGFDA(26.15,"+1,",1)="DGDESC"
 ;
 ;ask for IEN = 1
 S DGIEN(1)=1
 ;
 ;store record
 D UPDATE^DIE("E","DGFDA","DGIEN","DGERR")
 ;
 ;check for errors and inform the installer of update status
 D BMES^XPDUTL("*****")
 I $D(^DGPF(26.15,"B","BEHAVIORAL")),'$D(DGERR) D
 . D MES^XPDUTL("  'BEHAVIORAL' Category I Patient Record Flag created successfully.")
 E  D
 . D MES^XPDUTL("  'BEHAVIORAL' Category I Patient Record Flag creation failed!")
 D MES^XPDUTL("*****")
 Q
