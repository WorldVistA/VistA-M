DG531117P ;ALB/BA - DELETE PTF SUBFILE CROSS REFERENCE ; Oct 22, 2024@14:22:39 
 ;;5.3;Registration;**1117**;Aug 13, 1993;Build 32
 ;
 Q
 ;
PRE ; PRE-INSTALL Main entry point
 D BMES^XPDUTL("Running pre-install routine DG531117P")
 D DELIX^DDMOD(45.0535,2,1,"KW","MYOUT")
 D BMES^XPDUTL("Cross Reference was deleted")
 D BMES^XPDUTL("Pre-install routine DG531117P has completed")
 Q
