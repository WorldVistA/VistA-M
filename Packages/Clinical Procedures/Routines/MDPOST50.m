MDPOST50 ;MNTVBB/RRA - Post Installation Tasks;01/07/17
 ;;1.0;CLINICAL PROCEDURES;**50**;Apr 01, 2004;Build 2
 ;;Per VA Directive 6402, this routine should not be modified..
 ;
 ; This routine uses the following IAs:
 ; IA# 10141  MES^XPDUTL      Kernel
 ; IA# 2263 [Supported] XPAR Utilities
 ;
 Q
EN ; Post installation tasks to bring Legacy CP up to snuff
 ;
 N MDK,MDKLST
 ; Installing commands in the command file...
 D MES^XPDUTL(" Post install starting....updating Parameters...")
 ;
 ; Deactivate all previous versions from XPAR
 D GETLST^XPAR(.MDKLST,"SYS","MDK GUI VERSION")
 F MDK=0:0 S MDK=$O(MDKLST(MDK)) Q:'MDK  D
 .D EN^XPAR("SYS","MDK GUI VERSION",$P(MDKLST(MDK),"^",1),0)
 ; Add and/or activate current client versions
 ; Update MD PARAMETERS with new build numbers for executables.  
 D EN^XPAR("SYS","MDK GUI VERSION","HEMODIALYSIS.EXE:1.0.50.3",1)
 ;
 D MES^XPDUTL(" MD*1.0*50 Post Init complete")
 ;
 Q
 ;
