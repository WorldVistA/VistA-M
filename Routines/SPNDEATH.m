SPNDEATH ;SAN/WDE/Main Driver for date of death
 ;;2.0;Spinal Cord Dysfunction;**14**;01/02/1997
 ; called from the protocal being released with
 ;DG patch 273  DG VERSION 5.3
 ;
EN ;
 Q:'$D(DFN)
 Q:'$D(^SPNL(154,DFN,0))
 ;Place a check if they are removing the date of death...
 ;they will be passing some value that you can check.
 ;If date of death is being deleted from file 2 I will send an 
 ;email to the SCI coordinator.
 S DIE="^SPNL(154,",DA=DFN,DR=".03///X"
 D ^DIE
 K DIE,DA,DR
 Q
DELETE ;
 ;Date of death has been deleted from the patient file
 ;send a message to the coordinator to update the registry.
 S SPNTXT(1)="The date of death for "_$$GET1^DIQ(2,DFN_",",.01)_" has"
 S SPNTXT(2)="been deleted from the patient file."
 S SPNTXT(3)="The Registration Status needs to be up-dated in the"
 S SPNTXT(4)="Spinal Cord Registry."
 S XMSUB="Date of death deleted for "_$$GET1^DIQ(2,DFN_",",.01)
 S XMTEXT="SPNTXT("
 S XMY=("G.SPNL SCD COORDINATOR")
 D ^XMD
 K SPNTXT,XMY,XMSUB
 Q
