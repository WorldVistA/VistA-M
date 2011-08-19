PFXIP12 ;WOIFO/MJE-PATCH INSTALL ROUTINE ;11/19/2001
 ;;3.0;PATIENT FUNDS;**12**;JUNE 1, 1989
 Q
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N PFX,Y
 F PFX="UPDPRPF" D
 .S Y=$$NEWCP^XPDUTL(PFX,PFX_"^PFXIP12")
 .I 'Y D BMES^XPDUTL("ERROR Creating "_PFX_" Checkpoint.")
 Q
 ;
UPDPRPF ;Update selected Personal Funds records 
 N X,Y,DA,DR,DIE,DIK,IENX,IENY,NEWIEN,PFF1,PFX
 D BMES^XPDUTL("    Updating Personal Funds files 470.1,470.2")
 ; check for the existence of bad pfunds form if not present quit routine
 D:'$D(^PRPF(470.2,"B","PICKLO, JOSEPH")) MES^XPDUTL("    Update of the Personal Funds Forms file not required.")
 Q:'$D(^PRPF(470.2,"B","PICKLO, JOSEPH"))
 ; check for the form that will be pointed to if updates are made, if not present quit routine
 D:'$D(^PRPF(470.2,"B","10-1083")) MES^XPDUTL("    Problem: Form 10-1083 not found! Update aborted, please refer to installation instructions.")
 Q:'$D(^PRPF(470.2,"B","10-1083"))
 D:'$D(^PRPF(470.1)) MES^XPDUTL("    Problem: Patient Funds Master Transaction file does not exist, Update Aborted")
 Q:'$D(^PRPF(470.1,0))
 ;search files 470.1 for records that need to be re-pointed
 S (IENX,IENY,NEWIEN)=0
 S NEWIEN=$O(^PRPF(470.2,"B","10-1083",0))
 F  S IENX=$O(^PRPF(470.2,"B","PICKLO, JOSEPH",IENX)) Q:'IENX  D
 .F  S IENY=$O(^PRPF(470.1,IENY)) Q:'IENY  D
 ..I $P(^PRPF(470.1,IENY,0),"^",11)=IENX D
 ...S DR="10////^S X=NEWIEN",DIE="^PRPF(470.1,",DA=IENY
 ...L +^PRPF(470.1,IENY):0 I $T D
 ....D ^DIE L -^PRPF(470.1,IENY)
 ...E  I '$D(PFF1) D
 ....D BMES^XPDUTL("  Error: Could not lock file 470.1, rerun patch")
 ....S PFF1=1
 .;if no lock errors flagged then delete bad pfunds form entry
 .I '$D(PFF1) S DIK="^PRPF(470.2,",DA=IENX D ^DIK D MES^XPDUTL("    Update Successful")
 Q
 ;PFXIP12
