DG832P1 ;ALB/RGB - PRE-INSTALL DG*5.3*832 ; 6/24/10 12:17pm
 ;;5.3;Registration;**832**;Aug 13, 1993;Build 9
 Q
EN ;Pre install entry point
 N DGX,Y
 S DGX="DEL"
 S Y=$$NEWCP^XPDUTL(DGX,DGX_"^DG832P1")
 I 'Y D BMES^XPDUTL("ERROR creating "_DGX_" checkpoint.")
 Q
DEL ;Delete trigger on field=FLD, XREF#=XREF of file 405.
 N DGFILE,DGFIELD,DGREF,DGKEY
 S DGFILE=405
 F DGKEY=".01,5",".04,1,",".06,2",".14,3",".18,1" D
 . S DGFIELD=$P(DGKEY,","),DGREF=$P(DGKEY,",",2)
 . D DELIX^DDMOD(DGFILE,DGFIELD,DGREF)
 Q
