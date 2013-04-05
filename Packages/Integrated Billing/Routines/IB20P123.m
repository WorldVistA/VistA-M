IB20P123 ;ALB/RB - DM PHASE IV POST-INIT ; 18-AUG-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
 D ADD ; Adds new entries to file 356.8 - REASONS NOT BILLABLE
 ;
 D DIS ; Disables data extraction for MCCR/UR Summary Report.
 ;
 D REM ; Removes Days Denied Report from Utilization Mgmt. Reports menu.
 ;
 D DMM ; Update IBJ DIAGNOSTIC MEASURES MENU and IBJD DM EXTRACT MENU options
 ;       with Entry Points.
 Q
 ;
ADD ; - Add new entries to file #356.8
 N DIC,DINUM,DD,DO,X,X0,X1,X2,X3
 ;
 D BMES^XPDUTL("Adding new entries to file 356.8 - REASONS NOT BILLABLE")
 ;
 S X0="" F X=1:1 Q:$P(X0,U,7)  I '$D(^IBE(356.8,X,0)) S X0=X0_X_U
 F X1=1:1:7 D
 . S X2=$P($T(ENT+X1),";;",2),X3=X1
 . I '$D(^IBE(356.8,"B",X2)) D
 . . K DD,DO S DIC="^IBE(356.8,",DIC(0)="L"
 . . S DINUM=$P(X0,U,X3),X=X2
 . . D FILE^DICN
 ;
 Q
 ;
DIS ; - Disable data extraction for MCCR/UR Summary Report.
 N DA,DIE,DR
 ;
 D BMES^XPDUTL("Disabling the data extraction for MCCR/UR Summary Report")
 ;
 S DA=$O(^IBE(351.7,"B","MCCR/UR SUMMARY REPORT",0))
 I DA,'$P($G(^IBE(351.7,DA,0)),U,2) S DIE=351.7,DR=".02////1" D ^DIE
 ;
 Q
 ;
REM ; - Remove Days Denied Report from Utilization Mgmt. Reports menu.
 N DA,DIK,X
 ;
 D BMES^XPDUTL("Removing Days Denied Report from Utilization Mgmt Report Menu")
 ;
 S DA(1)=$O(^DIC(19,"B","IBJD UTILIZATION REPORTS",0)) G:'DA(1) QREM
 S X=$O(^DIC(19,"B","IBT OUTPUT DENIED DAYS REPORT",0)) G:'X QREM
 S DA=$O(^DIC(19,DA(1),10,"B",X,0)) G:'DA QREM
 S DIK="^DIC(19,"_DA(1)_",10," D ^DIK
 ;
QREM Q
 ;
DMM ; - Update the Diagnotic Measures menu entry point: MSG^IBJDE1
 N DA,DIE,DR
 ;
 D BMES^XPDUTL("Updating Diagnostic Measures Menu Options - Entry Points")
 ;
 S DA=$O(^DIC(19,"B","IBJ DIAGNOSTIC MEASURES MENU",""))
 I DA S DIE=19,DR="20////D MSG^IBJDE1" D ^DIE
 ;
 ; - Update the Diagnostic Measures Extract Menu entry point: CHK^IBJDE1
 S DA=$O(^DIC(19,"B","IBJD DM EXTRACT MENU",""))
 I DA S DIE=19,DR="20////D CHK^IBJDE1" D ^DIE
 Q
 ;
ENT ; - File entries.
 ;;CREDENTIALING ISSUE
 ;;INSUFFICIENT DOCUMENTATION
 ;;NO DOCUMENTATION
 ;;NON-BILLABLE PROVIDER (RESID.)
 ;;NON-BILLABLE PROVIDER (OTHER)
 ;;OTHER COMPLIANCE
 ;;OUT OF NETWORK (PPO)
