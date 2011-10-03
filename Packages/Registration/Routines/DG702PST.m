DG702PST ;BAY/JAT;
 ;;5.3;Registration;**702**;Aug 13,1993
 ;
 ; This is a post-init routine for DG*5.3*702
 ; The purpose is to relink File #2 and File #20 records
 ;
 ; do environment check
ENV S XPDABORT=""
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
PROGCHK(XPDABORT) ; checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .S XPDABORT=2
 Q
 ;
CLEANUP  ;
 D BMES^XPDUTL("Synchronize Patient file records with file #20")
 N DGIEN,DG20IEN,DG2PTR,DG2NAME,DG20PTR,DG20NAME,FDATA,DIERR,DGSTUFF,DA,DIK,CNT
 S CNT=0
 S DGIEN=0
 F  S DGIEN=$O(^VA(20,"BB",2,.01,DGIEN)) Q:'DGIEN  D
 .Q:DGIEN'[",0,"
 .S DG20IEN=$O(^VA(20,"BB",2,.01,DGIEN,0))
 .S DG2PTR=$P(DGIEN,",")
 .S DG2NAME=$P($G(^DPT(DG2PTR,0)),U)
 .S DG20PTR=$P($G(^DPT(DG2PTR,"NAME")),U)
 .S DG20NAME=$P(^VA(20,DG20IEN,1),U)_","_$P(^VA(20,DG20IEN,1),U,2)
 .I $P(^VA(20,DG20IEN,1),U,3)'="" S DG20NAME=DG20NAME_" "_$P(^VA(20,DG20IEN,1),U,3)
 .I $P(^VA(20,DG20IEN,1),U,5)'="" S DG20NAME=DG20NAME_" "_$P(^VA(20,DG20IEN,1),U,5)
 .I DG2NAME'=DG20NAME Q
 .;repoint the Patient file record to the good file 20 record
 .K FDATA,DIERR
 .S FDATA(2,DG2PTR_",",1.01)=DG20IEN
 .D FILE^DIE("","FDATA","DIERR")
 .K FDATA,DIERR
 .;kill the bad file 20 record - MUST KILL BEFORE REPOINTING THE OTHER 
 .S DA=DG20PTR
 .S DIK="^VA(20,"
 .D ^DIK
 .K DA,DIK
 .;repoint the good file 20 record to the Patient file record
 .S DGSTUFF=DG2PTR_","
 .S FDATA(20,DG20IEN_",",.03)=DGSTUFF
 .D FILE^DIE("","FDATA","DIERR")
 .K FDATA,DIERR
 .D MES^XPDUTL("Patient file DFN "_DG2PTR_" synchronized with file #20 record IEN "_DG20IEN)
 .S CNT=CNT+1
 D BMES^XPDUTL("Total number of Patient file records synchronized: "_CNT)
 Q
