RMIM3PST ;ALB/TMD ; FUNCTIONAL INDEPENDENCE INSTALL UTILITY ; 5/4/04 12:02pm
 ;;1.0;FUNCTIONAL INDEPENDENCE;**3**;Mar 12, 2003
 ;
ENV ;Main entry point for Environment check point
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
POST ;Main entry point for Post-init items
 D LAYGO
 D VERSION
 Q
 ;
LAYGO ;
 N RMDA         ;Option file #
 N RMOPTION     ;Option Name
 N RMIEN        ;Record IEN
 N RMFDA        ;fda_root array
 N RMMSG         ;msg_root array
 ;
 S RMOPTION="RMIM EDIT SITE PARAMETER",RMDA=19,RMIEN=""
 S RMIEN=$O(^DIC(19,"B",RMOPTION,RMIEN))_","
 I 'RMIEN D BMES^XPDUTL("****Could not locate "_RMOPTION_" option, update not completed") Q
 S RMFDA(RMDA,RMIEN,"20")="S DLAYGO=783.9"
 S RMFDA(RMDA,RMIEN,"15")="K DLAYGO"
 D FILE^DIE("","RMFDA","RMMSG")
 I $D(RMMSG("DIERR",1)) D BMES^XPDUTL("****"_RMOPTION_" option not updated - ERROR CODE "_RMMSG("DIERR",1)) Q
 D BMES^XPDUTL("****"_RMOPTION_" option successfully updated")
 Q
 ;
VERSION ;Update server version number
 N RMDA         ;Option file #
 N RMOPTION     ;Option Name
 N RMIEN        ;Record IEN
 N RMFDA        ;fda_root array
 N RMMSG         ;msg_root array
 ;
 S RMOPTION="RMIMFIM",RMDA=19,RMIEN=""
 S RMIEN=$O(^DIC(19,"B",RMOPTION,RMIEN))_","
 I 'RMIEN D BMES^XPDUTL("****Could not locate "_RMOPTION_" option, server version update not completed") Q
 S RMFDA(RMDA,RMIEN,"1")="RMIMFIM Context version 1.0.4.1"
 D FILE^DIE("","RMFDA","RMMSG")
 I $D(RMMSG("DIERR",1)) D BMES^XPDUTL("****Server version number not updated - ERROR CODE "_RMMSG("DIERR",1)) Q
 D BMES^XPDUTL("****Server version successfully updated to 1.0.4.1.")
 Q 
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("****")
 .D BMES^XPDUTL("Your programming variables are not set up properly.")
 .D BMES^XPDUTL("Installation aborted.")
 .S XPDABORT=2
 Q
