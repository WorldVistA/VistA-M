DG53105P ;ALB/MLI - Post-Installation to cleanup PAF file ; Oct 1, 1996
 ;;5.3;Registration;**105**;Aug 13, 1993
 ;
 ; This patch will loop through the 10/1/96 census PAF records and
 ; ensure the LOCATION field is properly defined.
 ;
EN ; start process
 N DGCOUNT
 S DGCOUNT=0
 D BMES^XPDUTL("Starting Cleanup of PAF file (#45.9)...")
 D CLEAN
 D BMES^XPDUTL("Cleanup complete..."_DGCOUNT_" records altered")
 Q
 ;
 ;
CLEAN ; loop through 10/1/96 semi-annual assessments and check location field
 N DA,DGDATE,DGIEN,DGLOC,DIE,DR
 S DGDATE=2960900
 S DIE="^DG(45.9,"
 F  S DGDATE=$O(^DG(45.9,"AP",2,DGDATE)) Q:'DGDATE  D
 .  S DGIEN=""
 .  F  S DGIEN=$O(^DG(45.9,"AP",2,DGDATE,DGIEN)) Q:'DGIEN  D
 .  .  S DGLOC=$P($G(^DG(45.9,DGIEN,"R")),"^",1)
 .  .  I $P(DGLOC,";DIC(42,",2,999)']"" Q  ; no extra charcters
 .  .  S DGLOC=+DGLOC_";DIC(42,",DGCOUNT=DGCOUNT+1
 .  .  S DA=DGIEN,DR="70////^S X=DGLOC"
 .  .  D ^DIE
 Q
