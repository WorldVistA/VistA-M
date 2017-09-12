PX10164P ;HERN/BDB - Post-init routine for PX*1.0*164 ;11/10/2005
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**164**;Aug 12, 1996
 ;
 Q
EN ;This patch will update the Visit Tracking Parameters File for
 ;the Order Entry/Results Reporting Package
 ;
 N DIC,X,Y
 D BMES^XPDUTL(">>> Updating Order Entry/Results Reporting entry")
 D MES^XPDUTL("       in the Visit Tracking Parameters file.")
 S DIC="^DIC(150.9,1,3,",DA(1)=1,DIC(0)="L",X="ORDER ENTRY/RESULTS REPORTING"
 D ^DIC
 I +Y'>0 G ERROR
 N DIE,DA
 S DIE="^DIC(150.9,1,3,",DA(1)=1,DA=+Y,DR="4////1"
 D ^DIE
 D BMES^XPDUTL("   Order Entry/Results Reporting package updated")
 D MES^XPDUTL("       in Visit Tracking Parameters file.")
 Q
ERROR ;
 D BMES^XPDUTL(">>> Order Entry/Result Reporting failed to be added to the")
 D MES^XPDUTL("     Visit Tracking Parameters file.  Please contact IRM.")
 Q
VTFQ ;
 D BMES^XPDUTL(">>> Done")
 Q
