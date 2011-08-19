DG53P784 ;ALB/RC - PRE-INSTALL DG*5.3*784 ; 6/12/08 12:17pm
 ;;5.3;Registration;**784**;Aug 13, 1993;Build 16
 Q
EN ;Post install entry point
 N DGX,Y
 F DGX="DEL" D
 .S Y=$$NEWCP^XPDUTL(DGX,DGX_"^DG53P784")
 .I 'Y D BMES^XPDUTL("ERROR creating "_DGX_" checkpoint.")
 Q
DEL ;Delete trigger on field 2 of subfile 45.02 for file 45.
 N DGFILE,DGFIELD,DGREF
 S DGFILE=45.02,DGFIELD=2,DGREF=1
 D DELIX^DDMOD(DGFILE,DGFIELD,DGREF)
 Q
