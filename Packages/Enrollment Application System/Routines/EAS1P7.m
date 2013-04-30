EAS1P7 ;ALB/LBD - Post Init for EAS*1.0*7 ;12 MAR 2002
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**7**;Mar 15, 2001
 ;
POST ; Entry point for post init
 ;
 ; Update LTC COPAY EXEMPTION file (#714.1)
 D MES^XPDUTL("*** Updating LTC COPAY EXEMPTION (File #714.1) ***")
 N DIC,DA,DIE,X,Y,FILE
 ; Modify entry #2
 D MES^XPDUTL("  - Modifying entry #2")
 S FILE="^EAS(714.1,"
 S DIC=FILE,DIC(0)="N",X=2 D ^DIC
 I Y<0 D MES^XPDUTL("    ERROR: Entry #2 not updated")
 E  S DIE=FILE,DA=2,DR=".01///INCOME (LAST YEAR) BELOW LTC THRESHOLD" D ^DIE
 ; Add entry #12
 D MES^XPDUTL("  - Adding entry #12")
 K DO
 S DIC=FILE,DIC(0)="F",(DA,DINUM)=12
 S X="INCOME (CURRENT YEAR) BELOW LTC THRESHOLD",DIC("DR")=".02////1"
 D FILE^DICN
 Q
