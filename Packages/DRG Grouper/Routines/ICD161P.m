ICD161P ;ALB/JDS - DRG GROUPER 16 PRE-INSTALL ; 09-DEC-98
 ;;16.0;DRG Grouper;**1**;Jan 15, 1999
 ;
 ;  This routine makes modifications to ICD files
 ;
 ;  These files must be reloaded upon completion of the
 ;  patch installation.
 ;
EN ;
 N I,XPDIDTOT,ICDX,ENTRY,DA,DIC,MDC22,DIE,DIK,DR,PROC,X
 S MDC22=$P($T(MDC22),";;",2)
 D BMES^XPDUTL(">>>> Updating MDC 22 Diagnosis Codes")
 F I=1:1:$L(MDC22,U) D
 .S ENTRY=$P(MDC22,U,I)
 .S DA=+$O(^ICD9("BA",ENTRY_" ",0)) Q:'DA
 .S DR="2///b;Q;2///@;61///510;60///511;5///22"
 .S DIE="^ICD9(" D ^DIE
 ;MDC 1
 D BMES^XPDUTL(">>>> Updating MDC 1 Procedure Codes")
 F PROC=38.7,83.92,83.93 S ENTRY=+$O(^ICD0("BA",PROC_" ",0)) I ENTRY D
 .I $D(^ICD0(ENTRY,"MDC",1)) S DIK="^DIK(ENTRY,""MDC"",",DA=1,DA(1)=ENTRY D ^DIK
 .I '$D(^ICD0(ENTRY,"MDC",0)) S ^(0)="^80.12PA"
 .S DIC="^ICD0(ENTRY,""MDC"",",X=1,DIC("DR")="1///7;2///8",DIC(0)="LM",DA(1)=ENTRY D ^DIC
 ;MDC 5
 D BMES^XPDUTL(">>>> Updating MDC 5 Procedure Codes")
 S ENTRY=+$O(^ICD0("BA","86.06 ",0)) I ENTRY D
 .I $D(^ICD0(ENTRY,"MDC",5)) S DIK="^ICD0(ENTRY,""MDC"",",DA=5,DA(1)=ENTRY D ^DIK
 .I '$D(^ICD0(ENTRY,"MDC",0)) S ^(0)="^80.12PA"
 .S DIC="^ICD0(ENTRY,""MDC"",",X=5,DIC("DR")="1///120",DA(1)=ENTRY,DIC(0)="LM" D ^DIC
 ;MDC 4
 D BMES^XPDUTL(">>> Updating MDC 4 Procedure Codes")
 S ENTRY=+$O(^ICD0("BA","39.50 ",0)) I ENTRY D
 .I $D(^ICD0(ENTRY,"MDC",4)) S DIK="^ICD0(ENTRY,""MDC"",",DA=4,DA(1)=ENTRY D ^DIK
 .I '$D(^ICD0(ENTRY,"MDC",0)) S ^(0)="^80.12PA"
 .S DIC="^ICD0(ENTRY,""MDC"",",X=4,DIC("DR")="1///76;2///77",DA(1)=ENTRY,DIC(0)="LM" D ^DIC
 D BMES^XPDUTL(">>> Changing Diagnostic Code as Valid Principal Diagnoses")
 S DA=+$O(^ICD9("BA","V71.9 ",0))
 I DA S DIE="^ICD9(",DR="101///1;Q;101///@" D ^DIE
 Q
MDC22 ;;948.90^948.80^948.70^948.60^948.50^948.40^948.30^948.20^948.10^948.00
