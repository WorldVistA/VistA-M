MDPOST51 ;MNTVBB/RRA - Post Installation Tasks;01/07/17
 ;;1.0;CLINICAL PROCEDURES;**51**;Apr 01, 2004;Build 8
 ;;Per VA Directive 6402, this routine should not be modified..
 ;
 ; This routine uses the following IAs:
 ;  #10141       - MES^XPDUTL                   Kernel                         (supported)
 ;  #2263        - EN^XPAR                      Kernel                         (supported)
 ;
 Q
EN ; Post installation tasks to bring Legacy CP up to snuff
 ;
 ;
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MD PARAMETERS","VERSION_CPFLOWSHEETS","1.0.51.6")
 ;
 D MES^XPDUTL(" MD*1.0*51 Post Init complete")
 ;
 Q
 ;
