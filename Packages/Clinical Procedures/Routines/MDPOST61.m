MDPOST61 ;Post Installation Tasks ; 4/30/18 8:41am
 ;;1.0;CLINICAL PROCEDURES;**61**;Apr 01, 2004;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel (supported)
 ; #2263 - EN^XPAR Kernel (supported)
 ;
 Q
EN ;
 ; Installing commands in the command file...
 D MES^XPDUTL("MD*1.0*61 Post install starting....updating Parameters...")
 ;
 ; CP Flowsheets
 ; Update MD PARAMETERS with new build numbers for executables.
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.61.1")
 ;
 D MES^XPDUTL(" MD*1.0*61 Post Init complete")
 ;
 Q
ROLLBACK ;
 D MES^XPDUTL("MD*1.0*61 Rollback starting....updating Parameters...")
 ;
 ; CP Flowsheets
 ; Update MD PARAMETERS with previous build numbers for executables.
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.58.1")
 ;
 D MES^XPDUTL(" MD*1.0*61 Rollback complete")
 ;
 Q
