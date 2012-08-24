DG53842P ;ALB/BDB - PRE-INSTALL DG*5.3*842;AUG 18, 2011
 ;;5.3;Registration;**842**;Aug 13, 1993;Build 33
 Q
EN ;Pre-install entry point
 ;Pre-install process to delete the old X-Ref trigger in
 ;PATIENT file #2 for RECEIVING A VA PENSION? field #.36235
 D BMES^XPDUTL("Deleting trigger on RECEIVING A VA PENSION? field")
 D DELIX^DDMOD(2,.36235,1)
 Q
 ;
