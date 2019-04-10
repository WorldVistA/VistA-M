SPN7P ;ALB/JLG - POST INSTALL FOR Spinal Cord Dysfunction Decommissioning ;Nov 08, 2018@16:13
 ;;3.0;Spinal Cord Dysfunction;**7**;Nov 08, 2018;Build 18
 ;
 ; DBIA#   SUPPORTED
 ; -----   --------------------------------------
 ; 10013   ^DIK
 ; 10014   EN^DIU2
 ;
 ; SCD (SPINAL CORD) REGISTRY (file 154)
 ; SCD NLOI CATEGORY          (file 154.01)
 ; ETIOLOGY                   (file 154.03)
 ; OUTCOMES                   (file 154.1)
 ; FUNCTIONAL STATUS LEVEL    (file 154.11)
 ; SCD DISPOSITION CODES      (file 154.12)
 ; SCD KURTZKE-EDSS           (file 154.2)
 ; OUTCOME SCORE TYPES        (file 154.3)
 ; PHYSICAL FACILITY          (file 154.7)
 ; AD HOC MACRO               (file 154.8)
 ; SCD SITE PARAMETERS        (file 154.91)
 ; SCD FILTER                 (file 154.92)
 ; SPN ADMISSIONS             (file 154.991)
 ;
 D EN ;
 D ROUT ;
 Q
EN ; start post install
 W !,"  Starting post-install of SPN*3.0*7",!
 N SPNFLST,SPNI,DIU
 ;
 S SPNFLST="154,154.01,154.03,154.1,154.11,154.12,154.2,154.3,154.7,154.8,154.91,154.92,154.991"
 F SPNI=1:1:13 D 
 .S DIU=$P(SPNFLST,",",SPNI),DIU(0)="DE" D EN^DIU2
 .W !,"Removing global..... ^SPNL("_DIU_")" K DIU
 ;
 Q
ROUT ; remove routines from ^DIC(9.8
 N SPNRTN,SPNI,DA,DIK
 S SPNRTN="SPN"
 F  S SPNRTN=$O(^DIC(9.8,"B",SPNRTN)) Q:$E(SPNRTN,1,3)'="SPN"  D
 .S SPNI=0 S SPNI=$O(^DIC(9.8,"B",SPNRTN,SPNI)) Q:'SPNI
 .K DA,DIK S DA=SPNI,DIK="^DIC(9.8," D ^DIK
 .W !,"Removing routine..... "_SPNRTN
 W !
 K DA,DIK
 Q
 ;
