EAS1P24 ;ALB/TCK - Post Init for EAS*1.0*24 ;18 DEC 2002
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**24**;MAR 15, 2001
 ;
POST ; Entry point for post init
 ;
 ; Update LTC COPAY EXEMPTION file (#714.1)
 D MES^XPDUTL("*** Updating LTC COPAY EXEMPTION (File #714.1) ***")
 N DIC,DA,DIE,X,Y,FILE,DR
 ; Modify entry #11
 D MES^XPDUTL("  - Modifying entry #11")
 S FILE="^EAS(714.1,"
 S DIC=FILE,X=11 D ^DIC
 I Y<0 D MES^XPDUTL("    ERROR: Entry #11 not updated") Q
 S DIE=FILE,DA=11,DR=".01///LTC RELATED TO HOSPICE CARE"
 D ^DIE,MES^XPDUTL("  - Entry #11 Modified")
 Q
 ;
