DG53P847 ;ALB/RC - PRE-INSTALL DG*5.3*847 ; 4/26/12
 ;;5.3;Registration;**847**;Aug 13, 1993;Build 6
 Q
EN ;Post install entry point
 N DGX,Y
 F DGX="DEL" D
 .S Y=$$NEWCP^XPDUTL(DGX,DGX_"^DG53P847")
 .I 'Y D BMES^XPDUTL("ERROR creating "_DGX_" checkpoint.")
 Q
DEL ;Delete trigger on field .119, .1311, .1313, .137 of file 2.
 N DGFILE,DGFIELD,DGREF
 F DGFIELD=.119,.1311,.1313,.137 S DGFILE=2,DGREF=1 D
 . D DELIX^DDMOD(DGFILE,DGFIELD,DGREF)
 Q
