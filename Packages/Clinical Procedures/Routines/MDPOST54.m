MDPOST54 ; MNTVBB/DK - POST INSTALLATION TASKS ;Apr 4, 2018@11:53
 ;;1.0;CLINICAL PROCEDURES;**54**;Apr 01, 2004;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL  Kernal  (supported)
 ;  #2263        - EN^XPAR     Kernal  (supported)
 ;
 Q
EN ; Update version number
 ;
 ;
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPCONSOLE","1.0.54.2")
 ;
 D MES^XPDUTL(" MD*1.0*54 Post Init complete")
 ;
 Q
 ;
