MDPOST58 ;POST INSTALLATION TASKS ; 10/24/17 12:32pm
 ;;1.0;CLINICAL PROCEDURES;**58**;Apr 01, 2004;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel (supported)
 ; #2263 - EN^XPAR Kernel (supported)
 ;
 Q
EN ;
 ;
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; CP Flowsheets
 ; Update MD PARAMETERS with new build numbers for executables.
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.58.1")
 ;
 D MES^XPDUTL(" MD*1.0*58 Post Init complete")
 ;
 Q
