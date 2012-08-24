DG53456P ;ALB/CKN - Post Install for DG*5.3*454; 16 AUG 2002
 ;;5.3;Registration;**456**; Aug 13,1993
 ;
POST ; Entry point for post init
 ; Update MEANS TEST STATUS file (#408.32)
 D MES^XPDUTL("*** Updating MEANS TEST STATUS file(#408.32)***")
 N DIC,DA,DIE,X,Y,FILE,DATA,UPD,DGENDA
 ; Modify entry #4
 D MES^XPDUTL("  - Modifying entry #4")
 S FILE="^DG(408.32,"
 S DIC=FILE,DIC(0)="N",X=4 D ^DIC
 I Y<0 D MES^XPDUTL("    ERROR: Entry #4 not updated")
 E  D
 . S DATA(.01)="MT COPAY EXEMPT",DGENDA=4
 . S UPD=$$UPD^DGENDBS(408.32,DGENDA,.DATA)
 ; Modify entry #6
 D MES^XPDUTL("  - Modifying entry #6")
 S X=6 D ^DIC
 I Y<0 D MES^XPDUTL("    ERROR: Entry #6 not updated")
 E  D
 . S DATA(.01)="MT COPAY REQUIRED",DGENDA=6
 . S UPD=$$UPD^DGENDBS(408.32,DGENDA,.DATA)
 Q
