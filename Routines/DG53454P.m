DG53454P ;ALB/CKN - Post Install for DG*5.3*454; 16 AUG 2002
 ;;5.3;Registration;**454**; Aug 13,1993
 ;
POST ; Entry point for post init
 ;
 D GMT,EGT
 Q
GMT ;
 ; Update MEANS TEST STATUS file (#408.32)
 D MES^XPDUTL("*** Updating MEANS TEST STATUS file(#408.32)***")
 N DIC,DA,DIE,X,Y,FILE,DATA,ADD,DGENDA
 S FILE="^DG(408.32,"
 ; Add entry #16
 D MES^XPDUTL("  - Adding entry #16")
 S DIC=FILE,DIC(0)="N",X=16 D ^DIC
 I Y'<0 D
 . S DIK=FILE,DA=16 D ^DIK K DA,DIK
 S DATA(.001)=16
 S DATA(.01)="GMT COPAY REQUIRED"
 S DATA(.019)=1,DATA(.02)="G",DATA(.03)="D"
 S ADD=$$ADD^DGENDBS(408.32,,.DATA,16)
 I 'ADD D MES^XPDUTL("    Error: Entry #16 not added") Q
 K WP
 S WP(1)="This status is assigned by the system or the user."
 S WP(2)="If a veteran's income is below the annual threshold for this category,"
 S WP(3)="the means test is assigned this status and subsequent category of care."
 S WP(4)="This is determined when the user completes the means test for a veteran."
 S WP(5)="This status can also be assigned by the user when adjudicating a means test."
 D WP^DIE(408.32,"16,",50,,"WP","ERR")
 K DATA
 S DATA(.01)=3020101,DATA(.02)=1,DGENDA(1)=16
 S ADD=$$ADD^DGENDBS(408.3275,.DGENDA,.DATA)
 Q
 ;
EGT ;Update Enrollment Group Thresholds file (# 27.16)
 D MES^XPDUTL("Updating Enrollment Group Threshold file (#27.16)")
 N EGTIEN,DGENFDA,ERR,DIE
 ; if EGT entry already exists, delete it before setting new one
 S EGTIEN=$$FINDCUR^DGENEGT()
 I EGTIEN I $$DELETE^DGENEGT(EGTIEN)
 S DGENFDA(27.16,"+1,",.01)=$$DT^XLFDT()
 S DGENFDA(27.16,"+1,",.02)=8
 S DGENFDA(27.16,"+1,",.03)=3
 S DGENFDA(27.16,"+1,",.04)=1
 S DGENFDA(27.16,"+1,",.06)=$$DT^XLFDT
 S DGENFDA(27.16,"+1,",25)="EGT set to 8c by patch DG*5.3*454"
 D UPDATE^DIE("","DGENFDA","","ERR")
 I $D(ERR) D MES^XPDUTL("   Could not set EGT entry in file #27.16")
 Q
